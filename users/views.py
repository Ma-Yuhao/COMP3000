from django.shortcuts import render, redirect, reverse
from django.http import JsonResponse
from django.contrib.auth.backends import ModelBackend
from users.models import Passport, Address
from order.models import OrderInfo, OrderProducts
import re
from django.shortcuts import render, redirect, reverse
from utils.decorators import login_required
from django_redis import get_redis_connection
import redis
import io
from itsdangerous import TimedJSONWebSignatureSerializer as Serializer
from itsdangerous import SignatureExpired
from users.tasks import send_active_email
from django.conf import settings
from products.models import Products
from PIL import Image, ImageDraw, ImageFont

import random



def register(request):

    return render(request, 'users/register.html')



def register_handle(request):

    username = request.POST.get('user_name')
    password = request.POST.get('pwd')
    cpassword = request.POST.get('cpwd')
    email = request.POST.get('email')

    if not all([username, password, email]):

        return render(request, 'users/register.html', {'errmsg': 'Parameter cannot be empty!'})
    if  password!=cpassword:
        return render(request, 'users/register.html', {'errmsg': 'The two passwords are inconsistent!'})
    if not re.match(r'^[a-z0-9][\w\.\-]*@[a-z0-9\-]+(\.[a-z]{2,5}){1,2}$', email):

        return render(request, 'users/register.html', {'errmsg': 'Illegal mailbox!'})
    try:
        passport = Passport.objects.add_one_passport(username=username, password=password, email=email)
    except Exception as e:
        print("e: ", e)
        return render(request, 'users/register.html', {'errmsg': 'The user name already exists！'})

    return redirect(reverse('products:index'))

def login(request):
    if request.COOKIES.get("username"):
        username = request.COOKIES.get("username")
        checked = 'checked'
    else:
        username = ''
        checked = ''
    context = {
        'username': username,
        'checked': checked,
    }
    return render(request, 'users/login.html', context)


def login_check(request):
    username = request.POST.get('username')
    password = request.POST.get('password')
    remember = request.POST.get('remember')
    verifycode = request.POST.get('verifycode')
    if not all([username, password, remember, verifycode]):
        print('空')
        return JsonResponse({'res': 0, 'errmsg': 'data cannot be null'})
    if verifycode.upper() != request.session['verifycode']:
        return JsonResponse({'res': 2,'errmsg': 'data cannot be null'})
    passport = Passport.objects.get_one_passport(username=username, password=password)
    if passport:
        next_url = reverse('products:index')
        jres = JsonResponse({'res': 1, 'next_url': next_url})
        if remember == 'true':
            jres.set_cookie('username', username, max_age=7 * 24 * 3600)
        else:
            jres.delete_cookie('username')
        request.session['islogin'] = True
        request.session['username'] = username
        request.session['passport_id'] = passport.id
        cache_clean()
        return jres
    else:
        return JsonResponse({'res': 0, 'errmsg': 'username or password cannot be wrong.'})


def logout(request):
    request.session.flush()
    cache_clean()
    return redirect(reverse('products:index'))


def cache_clean():
    r = redis.StrictRedis(host='localhost', port=6379, db=2)
    for key in r.keys():
        if 'store-index' in key.decode('utf8'):
            print('key: ', key)
            r.delete(key)


class CustomBackend(ModelBackend):
    def authenticate(self, username=None, password=None, **kwargs):
        try:
            user = Passport.objects.get_one_passport(username, password)
            return user
        except Exception as e:
            print("e: ", e)
            return None


@login_required
def user(request):
    passport_id = request.session.get('passport_id')
    addr = Address.objects.get_default_address(passport_id=passport_id)

    conn = get_redis_connection('default')
    key = 'history_%d' % passport_id
    history_li = conn.lrange(key, 0, 4)
    products_li = []

    for id in history_li:
        products = Products.objects.get_products_by_id(products_id=id)
        if products is not None:
            products_li.append(products)
    context = {
        'addr': addr,
        'page': 'user',
        'products_li': products_li
    }

    return render(request, 'users/user_center_info.html', context)


@login_required
def address(request):
    passport_id = request.session.get('passport_id')

    if request.method == 'GET':
        addr = Address.objects.get_update_address(passport_id=passport_id)
        return render(request, 'users/user_center_site.html', {'addr': addr, 'page': 'address'})
    else:
        recipient_name = request.POST.get('username')
        recipient_addr = request.POST.get('addr')
        zip_code = request.POST.get('zip_code')
        recipient_phone = request.POST.get('phone')

        if not all([recipient_name, recipient_addr, zip_code, recipient_phone]):
            return render(request, 'users/user_center_site.html', {'errmsg': 'Parameter cannot be empty!'})

        Address.objects.add_one_address(passport_id=passport_id,
                                        recipient_name=recipient_name,
                                        recipient_addr=recipient_addr,
                                        zip_code=zip_code,
                                        recipient_phone=recipient_phone)

        return redirect(reverse('user:address'))


from django.core.paginator import Paginator


@login_required
def order(request, page):
    passport_id = request.session.get('passport_id')
    order_li = OrderInfo.objects.filter(passport_id=passport_id)
    for order in order_li:
        order_id = order.order_id
        order_products_li = OrderProducts.objects.filter(order_id=order_id)
        for order_products in order_products_li:
            count = order_products.count
            price = order_products.price
            amount = count * price
            order_products.amount = amount
        order.order_products_li = order_products_li

    paginator = Paginator(order_li, 3)
    num_pages = paginator.num_pages
    if not page:
        page = 1
    if page == '' or int(page) > num_pages:
        page = 1
    else:
        page = int(page)

    order_li = paginator.page(page)

    if num_pages < 5:
        pages = range(1, num_pages + 1)
    elif page <= 3:
        pages = range(1, 6)
    elif num_pages - page <= 2:
        pages = range(num_pages - 4, num_pages + 1)
    else:
        pages = range(page - 2, page + 3)

    context = {
        'order_li': order_li,
        'pages': pages,
    }

    return render(request, 'users/user_center_order.html', context)

@login_required
def order2(request, page):
    cu_order_id=request.GET.get('out_trade_no')
    print('cu_order_id',cu_order_id)
    cu_order = OrderInfo.objects.get(order_id=cu_order_id)
    cu_order.status=2
    cu_order.save()
    passport_id = request.session.get('passport_id')
    order_li = OrderInfo.objects.filter(passport_id=passport_id)
    for order in order_li:
        order_id = order.order_id
        order_products_li = OrderProducts.objects.filter(order_id=order_id)
        for order_products in order_products_li:
            count = order_products.count
            price = order_products.price
            amount = count * price
            order_products.amount = amount
        order.order_products_li = order_products_li

    paginator = Paginator(order_li, 3)
    num_pages = paginator.num_pages
    if not page:
        page = 1
    if page == '' or int(page) > num_pages:
        page = 1
    else:
        page = int(page)

    order_li = paginator.page(page)

    if num_pages < 5:
        pages = range(1, num_pages + 1)
    elif page <= 3:
        pages = range(1, 6)
    elif num_pages - page <= 2:
        pages = range(num_pages - 4, num_pages + 1)
    else:
        pages = range(page - 2, page + 3)

    context = {
        'order_li': order_li,
        'pages': pages,
    }

    return render(request, 'users/user_center_order.html', context)





def register_active(request, token):
    serializer = Serializer(settings.SECRET_KEY, 3600)
    try:
        info = serializer.loads(token)
        passport_id = info['confirm']
        passport = Passport.objects.get(id=passport_id)
        passport.is_active = True
        passport.save()
        return redirect(reverse('user:login'))
    except SignatureExpired:
        return HttpResponse('Activation link expired')

from django.http import HttpResponse
from django.conf import settings
import os


def verifycode(request):
    bgcolor = (random.randrange(20, 100), random.randrange(
        20, 100), 255)
    width = 100
    height = 20
    im = Image.new('RGB', (width, height), bgcolor)
    draw = ImageDraw.Draw(im)
    for i in range(0, 100):
        xy = (random.randrange(0, width), random.randrange(0, height))
        fill = (random.randrange(0, 255), 255, random.randrange(0, 255))
        draw.point(xy, fill=fill)
    str1 = 'ABCD123EFGHIJK456LMNOPQRS789TUVWXYZ0'
    rand_str = ''
    for i in range(0, 4):
        rand_str += str1[random.randrange(0, len(str1))]
    font = ImageFont.truetype(os.path.join(settings.BASE_DIR, "simhei.ttf"), 15)
    fontcolor = (255, random.randrange(0, 255), random.randrange(0, 255))
    draw.text((5, 2), rand_str[0], font=font, fill=fontcolor)
    draw.text((25, 2), rand_str[1], font=font, fill=fontcolor)
    draw.text((50, 2), rand_str[2], font=font, fill=fontcolor)
    draw.text((75, 2), rand_str[3], font=font, fill=fontcolor)
    del draw
    request.session['verifycode'] = rand_str
    buf = io.BytesIO()
    im.save(buf, 'png')
    return HttpResponse(buf.getvalue(), 'image/png')
