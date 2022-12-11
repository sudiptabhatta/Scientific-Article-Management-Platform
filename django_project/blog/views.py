from django.shortcuts import render
from .models import Post
from django.views.generic import ListView
from django.contrib.auth.mixins import LoginRequiredMixin

# Create your views here.
class UserPostListView(LoginRequiredMixin, ListView):
    model = Post # query the post model to create the list of articles
    template_name = 'blog/researcher-profile.html'
    context_object_name = 'posts' # if I don't set context_object_name here, it will be object_list to iterate through the list of posts in the html page.
    ordering = ['-created']

    # get the posts of the logged in user
    def get_queryset(self):
        return Post.objects.filter(author = self.request.user)
