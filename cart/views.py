from django.shortcuts import render
from django.http import JsonResponse
from products.models import Products
from utils.decorators import login_required
from django_redis import get_redis_connection

@login_required
def cart_add(request):
    products_id = request.POST.get('products_id')
    products_count = request.POST.get('products_count')

    if not all([products_id, products_count]):
        return JsonResponse({'res':1 , 'errmsg':'数据不完整'})

    products = Products.objects.get_products_by_id(products_id=products_id)
    if products is None:
        return JsonResponse({'res':2, 'errmsg':'商品不存在'})

    try:
        count = int(products_count)
    except Exception as e:
        return JsonResponse({'res':3, 'errmsg':'商品数量必须为数字'})

    conn = get_redis_connection('default')
    cart_key = 'cart_%d' % request.session.get('passport_id')

    res = conn.hget(cart_key, products_id)
    if res is None:
        res = count
    else:
        res = int(res) + count


    if res > products.stock:
        return JsonResponse({'res': 4, 'errmsg': '商品库存不足'})
    else:
        conn.hset(cart_key, products_id, res)


    return JsonResponse({'res': 5})

@login_required
def cart_count(request):
    conn = get_redis_connection('default')
    cart_key = 'cart_%d' % request.session.get('passport_id')
    res = 0
    res_list = conn.hvals(cart_key)
    for i in res_list:
        res += int(i)
    return JsonResponse({'res': res})

@login_required
def cart_show(request):
    passport_id = request.session.get('passport_id')
    conn = get_redis_connection('default')
    cart_key = 'cart_%d' % passport_id
    res_dict = conn.hgetall(cart_key)
    products_li = []
    total_count = 0
    total_price = 0
    for products_id, count in res_dict.items():
        products = Products.objects.get_products_by_id(products_id=products_id)
        products.count = count
        products.amount = int(count) * products.price
        products_li.append(products)
        total_count += int(count)
        total_price += int(count) * products.price
    context = {
        'products_li': products_li,
        'total_count': total_count,
        'total_price': total_price,
    }

    return render(request, 'cart/cart.html', context)

@login_required
def cart_del(request):
    products_id = request.POST.get('products_id')


    if not all([products_id]):
        return JsonResponse({'res': 1, 'errmsg': '数据不完整'})

    products = Products.objects.get_products_by_id(products_id=products_id)
    if products is None:
        return JsonResponse({'res': 2, 'errmsg': '商品不存在'})


    conn = get_redis_connection('default')
    cart_key = 'cart_%d' % request.session.get('passport_id')
    conn.hdel(cart_key, products_id)


    return JsonResponse({'res': 3})

@login_required
def cart_update(request):

    products_id = request.POST.get('products_id')
    products_count = request.POST.get('products_count')

    if not all([products_id, products_count]):
        return JsonResponse({'res': 1, 'errmsg': '数据不完整'})

    products = Products.objects.get_products_by_id(products_id=products_id)
    if products is None:
        return JsonResponse({'res': 2, 'errmsg': '商品不存在'})

    try:
        products_count = int(products_count)
    except Exception as e:
        print("e: ", e)
        return JsonResponse({'res': 3, 'errmsg': '商品数目必须为数字'})


    conn = get_redis_connection('default')
    cart_key = 'cart_%d' % request.session.get('passport_id')


    if products_count > products.stock:
        return JsonResponse({'res': 4, 'errmsg': '商品库存不足'})

    conn.hset(cart_key, products_id, products_count)

    return JsonResponse({'res': 5})
