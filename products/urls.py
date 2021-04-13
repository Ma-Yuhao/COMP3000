from django.conf.urls import url
from products import views

urlpatterns = [
    url(r'^$', views.index, name='index'),
    url(r'products/(?P<products_id>\d+)/$', views.detail, name='detail'),
    url(r'^list/(?P<type_id>\d+)/(?P<page>\d+)/$', views.list, name='list'),
    url(r'^getsname$', views.getsname, name='getsname'),
]
