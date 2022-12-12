from django.shortcuts import render
from .models import Post
from django.views.generic import ListView, DetailView, CreateView
from django.contrib.auth.mixins import LoginRequiredMixin

# get all posts of the logged in user
class UserPostListView(LoginRequiredMixin, ListView):
    model = Post # query the post model to create the list of articles
    template_name = 'blog/researcher-profile.html'
    context_object_name = 'posts' # if I don't set context_object_name here, it will be object_list to iterate through the list of posts in the html page.
    ordering = ['-created']

    def get_queryset(self):
        return Post.objects.filter(author = self.request.user)


# see details of a post create by a user
class UserPostDetailView(LoginRequiredMixin, DetailView):
    model = Post



# create post
class UserPostCreateView(LoginRequiredMixin, CreateView):
    model = Post
    fields = ['title', 'content', 'image', 'cid']

    def form_valid(self, form):
        form.instance.author = self.request.user
        return super().form_valid(form)
