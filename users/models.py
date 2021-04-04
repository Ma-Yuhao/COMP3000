from django.db import models
from db.base_model import BaseModel
from utils.get_hash import get_hash

class PassportManager(models.Manager):
    def add_one_passport(self, username, password, email):
        passport = self.create(username=username, password=(password), email=email)
        return passport
    def get_one_passport(self, username, password):
        try:
            passport = self.get(username=username, password=get_hash(password))
        except self.model.DoesNotExist:
            passport = None
        return passport


class Passport(BaseModel):
    username = models.CharField(max_length=20, unique=True)
    password = models.CharField(max_length=40)
    email = models.EmailField()
    is_active = models.BooleanField(default=False)

    objects = PassportManager()
    def save(self, force_insert=False, force_update=False, using=None,update_fields=None):
        self.password = get_hash(self.password)
        super(Passport,self).save(force_insert=False, force_update=False, using=None, update_fields=None)
    def __str__(self):

        return self.username
    class Meta:
        db_table = 's_user_account'
        verbose_name = 'account'
        verbose_name_plural = 'account'

class AddressManager(models.Manager):
    def get_default_address(self, passport_id):
        try:
            addr = self.get(passport_id=passport_id, is_default=True)
        except self.model.DoesNotExist:
            addr = None
        return addr
    def get_update_address(self, passport_id):
        try:
            addr = self.filter(passport_id=passport_id).last()
        except self.model.DoesNotExist:
            addr = None
        return addr

    def add_one_address(self, passport_id, recipient_name, recipient_addr, zip_code, recipient_phone):
        addr = self.get_default_address(passport_id=passport_id)

        if addr:
            is_default = False
        else:
            is_default = True

        addr = self.create(passport_id=passport_id,
                           recipient_name=recipient_name,
                           recipient_addr=recipient_addr,
                           zip_code=zip_code,
                           recipient_phone=recipient_phone,
                           is_default=is_default)
        return addr

class Address(BaseModel):
    recipient_name = models.CharField(max_length=20)
    recipient_addr = models.CharField(max_length=256)
    zip_code = models.CharField(max_length=6)
    recipient_phone = models.CharField(max_length=11)
    is_default = models.BooleanField(default=False)
    passport = models.ForeignKey('Passport')
    objects = AddressManager()

    def __str__(self):
        return self.recipient_name
    class Meta:
        db_table = 's_user_address'
        verbose_name = 'address'
        verbose_name_plural = 'address'
