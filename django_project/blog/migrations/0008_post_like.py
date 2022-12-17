# Generated by Django 4.1.2 on 2022-12-17 21:07

from django.conf import settings
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ("blog", "0007_comment"),
    ]

    operations = [
        migrations.AddField(
            model_name="post",
            name="like",
            field=models.ManyToManyField(
                related_name="likes", to=settings.AUTH_USER_MODEL
            ),
        ),
    ]
