from django.db import models
from django.utils import timezone
from django.contrib.auth import get_user_model
from django.urls import reverse
from ckeditor.fields import RichTextField # first I installed ckeditor by this command: pip install django-ckeditor

# Create your models here.
class Category(models.Model):
    cid = models.AutoField(primary_key=True, blank=True) 
    category_name = models.CharField(max_length=100)

    def __str__(self):
        return self.category_name


class Post(models.Model):
    aid = models.AutoField(primary_key=True)
    image = models.ImageField(default='blog-default.png', upload_to='images/')
    title = models.CharField(max_length=200)
    # content = models.TextField()
    content = RichTextField()
    created = models.DateTimeField(default=timezone.now)
    author = models.ForeignKey(get_user_model(), on_delete=models.CASCADE)
    cid = models.ForeignKey(Category, on_delete=models.CASCADE, verbose_name='specialization') 
    approved = models.BooleanField('Approved', default=False)

    def __str__(self):
        return self.title

    
    def get_absolute_url(self):
        return reverse('post-detail', kwargs={'pk':self.pk})


    