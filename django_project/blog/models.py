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
    cid = models.ForeignKey(Category, on_delete=models.CASCADE, verbose_name='specialization') # verbose_name is a human-readable name for the field. If the verbose name isn't given, Django will automatically create it using the field's attribute name. This attribute in general changes the field name in admin interface.
    approved = models.BooleanField('Approved', default=False)
    like = models.ManyToManyField(get_user_model(), related_name='likes')

    def __str__(self):
        return self.title

    
    def get_absolute_url(self):
        return reverse('post-detail', kwargs={'pk':self.pk})

    # number of comments of a current post
    @property # this method will be treated as a field
    def numberOfComments(self):
        return Comment.objects.filter(aid=self).count()


    @property
    def total_likes(self):
        return self.like.count()



class Comment(models.Model):
    commentid = models.AutoField(primary_key=True)
    author = models.ForeignKey(get_user_model(), on_delete=models.CASCADE)
    aid = models.ForeignKey(Post, related_name='comments', on_delete=models.CASCADE)
    comment = models.TextField()
    created = models.DateTimeField(auto_now_add=True)


    def __str__(self):
        return '%s - %s' % (self.aid.title, self.author.username)