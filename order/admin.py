from django.contrib import admin
from .models import OrderInfo
# Register your models here.
class OrderInfoAdmin(admin.ModelAdmin):
    list_display = ['order_id','passport', 'get_addr', 'total_count', 'total_price', 'pay_method', 'status', 'create_time']
    search_fields = ['order_id']
    # list_filter = ['create_time']
    raw_id_fields = ("addr",)
    list_per_page = 20
    def get_addr(self, obj):
        return obj.addr
    get_addr.short_description = 'consignee'

admin.site.register(OrderInfo,OrderInfoAdmin)
