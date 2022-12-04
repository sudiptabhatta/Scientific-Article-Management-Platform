from django.db import models
from blog.models import Category
from django.contrib.auth.models import AbstractUser

# Create your models here.
class CustomUser(AbstractUser):
    cid = models.ForeignKey(Category, on_delete=models.CASCADE)