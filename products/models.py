from django.db import models

# Create your models here.
from db.base_model import BaseModel
from tinymce.models import HTMLField
from products.enums import *
class ProductsManager(models.Manager):
    def get_products_by_type(self, type_id, limit=None, sort='default'):
        if sort == 'new':
            order_by = ('-create_time',)
        elif sort == 'hot':
            order_by = ('-sales', )
        elif sort == 'price':
            order_by = ('price', )
        else:
            order_by = ('-pk', )


        products_li = self.filter(type_id=type_id).order_by(*order_by)


        if limit:
            products_li = products_li[:limit]
        return products_li

    def get_products_by_id(self, products_id):

        try:
            products = self.get(id=products_id)
        except self.model.DoesNotExist:

            products = None
        return products


class Products(BaseModel):
    status_choices = ((k, v) for k,v in STATUS_CHOICE.items())
    type_id = models.ForeignKey('ProductsType',to_field='type_id',on_delete=models.CASCADE)
    name = models.CharField(max_length=20)
    desc = models.CharField(max_length=128, verbose_name='describe')
    price = models.DecimalField(max_digits=10, decimal_places=2)
    unit = models.CharField(max_length=20,blank=True,null=True)
    stock = models.IntegerField(default=0)
    sales = models.IntegerField(default=0)
    detail = HTMLField()
    image = models.ImageField(upload_to='products')
    status = models.SmallIntegerField(default=ONLINE, choices=status_choices)
    objects = ProductsManager()

    def __str__(self):
        return self.name

    class Meta:
        db_table = 's_products'
        verbose_name = 'shelves'
        verbose_name_plural = 'shelves'
class ProductsType(models.Model):
    type_id = models.AutoField( primary_key=True)
    name = models.CharField(max_length=20)
    image = models.ImageField(upload_to='typelogo', verbose_name='LOGO')
    c_time = models.DateTimeField( auto_now_add=True)
    def __str__(self):
        return self.name
    class Meta:
        db_table = 's_productstype'
        ordering = ['c_time']
        verbose_name = 'types'
        verbose_name_plural = 'types'
