from django.db import models
from db.base_model import BaseModel

class OrderInfo(BaseModel):
    '''订单信息模型类'''
    PAY_METHOD_CHOICES = (
        (1, "Cash on Delivery"),
        (2, "Wechat"),
        (3, "Alipay"),
        (4, "UnionPay"),
        (5, "PayPal")
    )

    PAY_METHODS_ENUM = {
        "CASH": 1,
        "WEIXIN": 2,
        "ALIPAY": 3,
        "UNIONPAY": 4,
        "PayPal": 5,
    }

    ORDER_STATUS_CHOICES = (
        (1, "Completed"),
    )

    order_id = models.CharField(max_length=64, primary_key=True)
    passport = models.ForeignKey('users.Passport')
    addr = models.ForeignKey('users.Address', verbose_name='address')
    total_count = models.IntegerField(default=1)
    total_price = models.DecimalField(max_digits=10, decimal_places=2)
    transit_price = models.DecimalField(max_digits=10, decimal_places=2)
    pay_method = models.SmallIntegerField(choices=PAY_METHOD_CHOICES, default=1)
    status = models.SmallIntegerField(choices=ORDER_STATUS_CHOICES, default=1)
    class Meta:
        db_table = 's_order_info'
        ordering = ['create_time']
        verbose_name = 'order'
        verbose_name_plural = 'order'

class OrderProducts(BaseModel):
    '''订单商品模型类'''
    order = models.ForeignKey('OrderInfo')
    products = models.ForeignKey('products.Products')
    count = models.IntegerField(default=1)
    price = models.DecimalField(max_digits=10, decimal_places=2)

    class Meta:
        db_table = 's_order_products'
