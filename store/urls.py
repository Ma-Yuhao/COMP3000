from django.conf.urls import url, include
from django.contrib import admin
from rest_framework.routers import DefaultRouter
from rest_framework_jwt.views import obtain_jwt_token
from products.views import ProductsListViewSet
from django.views import static
from django.conf import settings
router = DefaultRouter()

router.register(r'products', ProductsListViewSet, base_name="products")

urlpatterns = [
    url(r'^search/', include('haystack.urls')),
    url(r'^admin/', admin.site.urls),
    url(r'^user/', include('users.urls', namespace='user')),
    url(r'^tinymce/', include('tinymce.urls')),
    url(r'^api/', include(router.urls)),
    url(r'^login/', obtain_jwt_token),
    url(r'^cart/', include('cart.urls', namespace='cart')),
    url(r'^order/', include('order.urls', namespace='order')),
    url(r'^', include('products.urls', namespace='products')),
    url(r'^static/(?P<path>.*)$', static.serve,
        {'document_root': settings.STATIC_ROOT}, name='static'),
    url(r'^media/(?P<path>.*)$', static.serve, {'document_root': settings.MEDIA_ROOT}),
]
