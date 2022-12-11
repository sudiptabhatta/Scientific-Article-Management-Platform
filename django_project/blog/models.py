from django.db import models
from django.utils import timezone
from django.contrib.auth import get_user_model

# Create your models here.
class Category(models.Model):
    cid = models.AutoField(primary_key=True, blank=True) 
    category_name = models.CharField(max_length=100)

    def __str__(self):
        return self.category_name


class Post(models.Model):
    aid = models.AutoField(primary_key=True)
    image = models.ImageField(null=True, blank=True, default='blog-default.png', upload_to='images/')
    title = models.CharField(max_length=200)
    content = models.TextField()
    created = models.DateTimeField(default=timezone.now)
    author = models.ForeignKey(get_user_model(), on_delete=models.CASCADE)
    cid = models.ForeignKey(Category, on_delete=models.CASCADE) 

    def __str__(self):
        return self.title