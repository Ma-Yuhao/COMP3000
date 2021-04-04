from django.contrib import admin
from users.models import Passport
from django.contrib.auth.models import Group, User

admin.site.site_header = 'Sale Fish'
admin.site.site_title = 'backstage'
# Register your models here.

admin.site.register(Passport)
admin.site.unregister(Group)
admin.site.unregister(User)