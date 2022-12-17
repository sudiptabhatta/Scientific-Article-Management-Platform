# Generated by Django 4.1.2 on 2022-12-17 16:34

from django.conf import settings
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ("users", "0002_customuser_profile_pic"),
    ]

    operations = [
        migrations.AddField(
            model_name="customuser",
            name="following",
            field=models.ManyToManyField(
                blank=True, related_name="followers", to=settings.AUTH_USER_MODEL
            ),
        ),
    ]
