from django.db import models
from blog.models import Category
from django.contrib.auth.models import AbstractUser # AbstractUser class inherits the User class and is used to add Additional Fields required for your User in Database itself

# Create your models here.
class CustomUser(AbstractUser):
    cid = models.ForeignKey(Category, on_delete=models.CASCADE, verbose_name='specialization', blank=True, null=True)
    profile_pic = models.ImageField(default='default_person.jpg', upload_to='profile_pics')