from django.contrib import admin
from products.models import Products,ProductsType
# Register your models here.


class ProductsAdmin(admin.ModelAdmin):
    list_display = ['type_id','name', 'price', 'unit', 'stock', 'sales', 'status', 'update_time']
    search_fields = ['name']
    list_filter = ['update_time']
    list_per_page = 20
admin.site.register(Products,ProductsAdmin)
admin.site.register(ProductsType)
