# -*- coding: utf-8 -*-
# Generated by Django 1.11.15 on 2021-05-19 16:37
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('products', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='products',
            name='detail_image1',
            field=models.ImageField(blank=True, null=True, upload_to='products'),
        ),
        migrations.AddField(
            model_name='products',
            name='detail_image2',
            field=models.ImageField(blank=True, null=True, upload_to='products'),
        ),
        migrations.AddField(
            model_name='products',
            name='detail_image3',
            field=models.ImageField(blank=True, null=True, upload_to='products'),
        ),
        migrations.AddField(
            model_name='products',
            name='detail_image4',
            field=models.ImageField(blank=True, null=True, upload_to='products'),
        ),
    ]