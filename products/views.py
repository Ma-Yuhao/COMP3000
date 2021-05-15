from django.http import HttpResponse
from django.shortcuts import render, reverse, redirect
from django.shortcuts import render
from products.models import Products,ProductsType
import  os
from django.core.paginator import Paginator
from rest_framework import mixins
from products.serializers import ProductsSerializer
from rest_framework import viewsets
from rest_framework_jwt.authentication import JSONWebTokenAuthentication
from rest_framework.authentication import SessionAuthentication
from rest_framework.permissions import IsAuthenticated
from django_redis import get_redis_connection
import logging
import  json
from django.core import serializers
from django.views.decorators.csrf import csrf_exempt
logger = logging.getLogger('django.request')

class ProductsListViewSet(mixins.ListModelMixin, mixins.RetrieveModelMixin, viewsets.GenericViewSet):
    serializer_class = ProductsSerializer
    permission_classes = (IsAuthenticated,)
    authentication_classes = (JSONWebTokenAuthentication,)
    queryset = Products.objects.all()

from django.views.decorators.cache import cache_page
#@cache_page(60, key_prefix="store-index")
def index(request):
    logger.info(request.body)
    products_type = ProductsType.objects.all()
    length=len(products_type)
    products = Products.objects.all().order_by('create_time')[:4*length]
    context = {
        'products':products,
        'products_type':products_type,
    }
    return render(request, 'products/index.html', context)
def detail(request, products_id):
    products = Products.objects.get_products_by_id(products_id=products_id)

    if products is None:
        return redirect(reverse('products:index'))

    products_li = Products.objects.get_products_by_type(type_id=products.type_id, limit=2, sort='new')

    # type_title = PRODUCTS_TYPE[products.type_id]

    if request.session.has_key('islogin'):

        conn = get_redis_connection('default')
        key = 'history_%d' % request.session.get('passport_id')
        conn.lrem(key, 0, products.id)
        conn.lpush(key, products.id)
        conn.ltrim(key, 0, 4)

    context = {
        'products': products,
        'products_li':products_li,
        # 'type_title':type_title
    }

    return render(request, 'products/detail.html', context)

from django.core.paginator import Paginator

def list(request, type_id, page):
    sort = request.GET.get('sort', 'default')
    products_li = Products.objects.get_products_by_type(type_id=type_id, sort=sort)

    paginator = Paginator(products_li, 5)

    num_pages = paginator.num_pages

    if page == '' or int(page) > num_pages:
        page = 1
    else:
        page = int(page)

    products_li = paginator.page(page)

    if num_pages < 5:
        pages = range(1, num_pages+1)
    elif page <= 3:
        pages = range(1, 6)
    elif num_pages - page <= 2:
        pages = range(num_pages-4, num_pages+1)
    else:
        pages = range(page-2, page+3)

    products_new = Products.objects.get_products_by_type(type_id=type_id, limit=2, sort='new')
    context = {
        'products_li': products_li,
        'products_new': products_new,
        'type_id': type_id,
        'sort': sort,
        'pages': pages
    }

    return render(request, 'products/list.html', context)









def getsname(request):
    sname = request.GET.get("sname")
    if sname == "":
        ret = {
            "ret": []
        }
        return HttpResponse(json.dumps(ret, ensure_ascii=False), content_type="application/json;charset=utf-8")
    product_list = Products.objects.filter(name__icontains=sname).values("name")  #icontains:忽略大小写状态下的模糊查询,contains: 精确大小写状态下的模糊查询
    info = []
    for i in product_list:
        d = {}
        d["name"] = i["name"]
        info.append(d)

    ret = {
        "ret": info
    }
    return HttpResponse(json.dumps(ret, ensure_ascii=False), content_type="application/json;charset=utf-8")
