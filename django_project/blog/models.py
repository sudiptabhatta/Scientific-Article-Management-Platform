from django.db import models

# Create your models here.
class Category(models.Model):
    cid = models.AutoField(primary_key=True, blank=True)
    category_name = models.CharField(max_length=100)

    def __str__(self):
        return self.category_name