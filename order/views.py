from django.shortcuts import render,redirect, reverse
from utils.decorators import login_required
from django.http import HttpResponse,JsonResponse
from users.models import Address
from products.models import Products
from order.models import OrderInfo, OrderProducts
from django_redis import get_redis_connection
from datetime import datetime
from django.conf import settings
import os
import time

@login_required
def order_place(request):

    products_ids = request.POST.getlist('products_ids')

    if not all(products_ids):

        return redirect(reverse('cart:show'))

    passport_id = request.session.get('passport_id')
    addr = Address.objects.get_default_address(passport_id=passport_id)


    products_li = []

    total_count = 0
    total_price = 0

    conn = get_redis_connection('default')
    cart_key = 'cart_%d' % passport_id

    for products_id in products_ids:

        products = Products.objects.get_products_by_id(products_id=products_id)

        count = conn.hget(cart_key, products_id)
        products.count = count

        amount = int(count) * products.price
        products.amount = amount
        products_li.append(products)

        total_count += int(count)
        total_price += products.amount


    transit_price = -10
    total_pay = total_price + transit_price

    products_ids = ','.join(products_ids)

    context = {
        'addr': addr,
        'products_li': products_li,
        'total_count': total_count,
        'total_price': total_price,
        'transit_price': transit_price,
        'total_pay': total_pay,
        'products_ids': products_ids,
    }

    return render(request, 'order/place_order.html', context)

from django.db import transaction

@transaction.atomic
def order_commit(request):

    if not request.session.has_key('islogin'):
        return JsonResponse({'res': 0, 'errmsg': 'User not logged in'})


    addr_id = request.POST.get('addr_id')
    pay_method = request.POST.get('pay_method')
    products_ids = request.POST.get('products_ids')


    if not all([addr_id, pay_method, products_ids]):
        return JsonResponse({'res': 1, 'errmsg': 'Incomplete data'})

    try:
        addr = Address.objects.get(id=addr_id)
    except Exception as e:

        return JsonResponse({'res': 2, 'errmsg': 'Address information error'})

    if int(pay_method) not in OrderInfo.PAY_METHODS_ENUM.values():
        return JsonResponse({'res': 3, 'errmsg': 'Payment method not supported'})

    passport_id = request.session.get('passport_id')

    order_id = datetime.now().strftime('%Y%m%d%H%M%S') + str(passport_id)

    transit_price = -10

    total_count = 0
    total_price = 0
    sid = transaction.savepoint()
    try:
        order = OrderInfo.objects.create(order_id=order_id,
                                 passport_id=passport_id,
                                 addr_id=addr_id,
                                 total_count=total_count,
                                 total_price=total_price,
                                 transit_price=transit_price,
                                 pay_method=pay_method)

        products_ids = products_ids.split(',')
        conn = get_redis_connection('default')
        cart_key = 'cart_%d' % passport_id

        for id in products_ids:
            products = Products.objects.get_products_by_id(products_id=id)
            if products is None:
                transaction.savepoint_rollback(sid)
                return JsonResponse({'res': 4, 'errmsg': 'Product information error'})


            count = conn.hget(cart_key, id)


            if int(count) > products.stock:
                transaction.savepoint_rollback(sid)
                return JsonResponse({'res': 5, 'errmsg': 'Insufficient inventory of goods'})


            OrderProducts.objects.create(order_id=order_id,
                                      products_id=id,
                                      count=count,
                                      price=products.price)


            products.sales += int(count)
            products.stock -= int(count)
            products.save()


            total_count += int(count)
            total_price += int(count) * products.price


        order.total_count = total_count
        order.total_price = total_price
        order.save()
    except Exception as e:

        transaction.savepoint_rollback(sid)
        return JsonResponse({'res': 7, 'errmsg': 'Server error'})


    conn.hdel(cart_key, *products_ids)
    transaction.savepoint_commit(sid)
    return JsonResponse({'res': 6})

from alipay import AliPay

@login_required
def order_pay(request):


    order_id = request.POST.get('order_id')

    if not order_id:
        return JsonResponse({'res': 1, 'errmsg': 'Order does not exist'})

    try:
        order = OrderInfo.objects.get(order_id=order_id,
                                      status=1,
                                      pay_method=3)
    except OrderInfo.DoesNotExist:
        return JsonResponse({'res': 2, 'errmsg': 'Order information error'})


    app_private_key_path = os.path.join(settings.BASE_DIR, 'order/app_private_key.pem')
    alipay_public_key_path = os.path.join(settings.BASE_DIR, 'order/app_public_key.pem')
    app_private_key_string = open(app_private_key_path).read()
    alipay_public_key_string = open(alipay_public_key_path).read()

    alipay = AliPay(
        appid="2016101100664723",
        app_notify_url=None,
        app_private_key_string=app_private_key_string,
        alipay_public_key_string=alipay_public_key_string,
        sign_type = "RSA2",
        debug = True,
    )

    total_pay = order.total_price + order.transit_price # decimal
    order_string = alipay.api_alipay_trade_page_pay(
        out_trade_no=order_id,
        total_amount=str(total_pay),
        subject='Order number：%s' % order_id,
        return_url="http://127.0.0.1:8000/user/order2/",
        notify_url="http://127.0.0.1:8000/user/order2/"
    )

    pay_url = settings.ALIPAY_URL + '?' + order_string
    return JsonResponse({'res': 3, 'pay_url': pay_url, 'message': 'OK'})
def deleteOrder(request):

    id=request.GET.get("order_id")
    OrderProducts.objects.filter(order_id=id).delete()
    OrderInfo.objects.filter(order_id=id).delete()
    return redirect("/user/order/")
