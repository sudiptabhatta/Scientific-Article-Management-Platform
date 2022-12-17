from django.shortcuts import render, get_object_or_404
from .models import Post, Comment, Category
from django.views.generic import ListView, DetailView, CreateView, UpdateView, DeleteView
from django.contrib.auth.mixins import LoginRequiredMixin, UserPassesTestMixin
from .forms import PostForm, EditForm, CommentForm
from django.contrib.auth import get_user_model

from itertools import chain
from django.http import HttpResponse
from django.core import serializers

User = get_user_model()

# get all posts of the loggedin user
class UserPostListView(LoginRequiredMixin, ListView):
    model = Post # query the post model to create the list of articles
    template_name = 'blog/researcher-profile.html'
    context_object_name = 'posts' # if I don't set context_object_name here, it will be object_list to iterate through the list of posts in the html page.
    ordering = ['-created']

    # return the list of items for this view only from a certain user
    def get_queryset(self):
        # return Post.objects.filter(author = self.request.user, approved=True) 
        return Post.objects.filter(author = self.request.user)
    
    def get_context_data(self, *args, **kwargs):
        cat_menu = Category.objects.all()
        context = super(UserPostListView, self).get_context_data(*args, **kwargs)
        context['cat_menu'] = cat_menu
        return context


# display other people's profile
class OtherPeopleProfileView(LoginRequiredMixin, ListView):
    model = Post 
    template_name = 'blog/other-people-profile.html'
    context_object_name = 'posts' 

    # return the list of items for this view only from a certain user
    def get_queryset(self):
        user = get_object_or_404(User, username=self.kwargs.get('username')) # if the username given in the url exists, then store that user in the user variable
        posts = Post.objects.filter(author = user).order_by('-created')
        return posts

    def get_context_data(self, **kwargs):
        context = super(OtherPeopleProfileView, self).get_context_data(**kwargs)
        cat_menu = Category.objects.all()
        user = get_object_or_404(User, username=self.kwargs.get('username'))
        context['cur_profile'] = User.objects.filter(username=user).first()
        context['cat_menu'] = cat_menu
        return context

    
# view posts of a category
def categoryView(request, cats):
    category_posts = Post.objects.filter(cid=cats)
    cat_menu = Category.objects.all()
    return render(request, 'blog/category.html', {'category_posts': category_posts, 'cat_menu': cat_menu})


# see details of a post create by a user
class UserPostDetailView(LoginRequiredMixin, DetailView):
    model = Post

    # comment section implementation 
    def get_context_data(self, **kwargs): # it is used to pass data to the template. So this functions returns a dict representing the template context
        context = super().get_context_data(**kwargs)
        cat_menu = Category.objects.all()
        context['cat_menu'] = cat_menu
        # retrieve all comments of a specific post and store them in a local variable comments_connected
        comments_connected = Comment.objects.filter(aid=self.get_object()).order_by('-created')
        # send the comments_connected as a context to the post detail
        context['comments'] = comments_connected
        if self.request.user.is_authenticated:
            context['comment_form'] = CommentForm(instance=self.request.user)
        return context


    # define a post method to receive the context from our form in order to directly post comments from the post-detail page
    def post(self, request, *args, **kwargs):
        new_comment = Comment(comment=request.POST.get('comment'),
                                author=self.request.user,
                                aid=self.get_object())
        new_comment.save()
        return self.get(self, request, *args, **kwargs) 




# create post
class UserPostCreateView(LoginRequiredMixin, CreateView):
    model = Post
    form_class = PostForm
    template_name = 'blog/post_create.html'
    # fields = ['title', 'content', 'image', 'cid']

    # if the form is valid, save the associated model
    def form_valid(self, form):
        form.instance.author = self.request.user
        return super().form_valid(form)

    def get_context_data(self, *args, **kwargs):
        cat_menu = Category.objects.all()
        context = super(UserPostCreateView, self).get_context_data(*args, **kwargs)
        context['cat_menu'] = cat_menu
        return context



# update post
class UserPostUpdateView(LoginRequiredMixin, UserPassesTestMixin, UpdateView):
    model = Post
    form_class = EditForm
    template_name = 'blog/post_update.html'
    # fields = ['title', 'content', 'image', 'cid']

    def form_valid(self, form):
        form.instance.author = self.request.user
        return super().form_valid(form)


    # UserPassesTestMixin will run this function
    def test_func(self):
        post = self.get_object() # the post that the user wants to update
        if self.request.user == post.author: # check if the logged in user is the author of the post that he/she wants to uodate
            return True
        return False

    
    def get_context_data(self, *args, **kwargs):
        cat_menu = Category.objects.all()
        context = super(UserPostUpdateView, self).get_context_data(*args, **kwargs)
        context['cat_menu'] = cat_menu
        return context




# delete post
class UserPostDeleteView(LoginRequiredMixin, UserPassesTestMixin, DeleteView):
    model = Post
    success_url = '/profile/' 

    def test_func(self):
        post = self.get_object() 
        if self.request.user == post.author:
            return True
        return False

    # to get category list in the navbar
    def get_context_data(self, *args, **kwargs):
        cat_menu = Category.objects.all()
        context = super(UserPostDeleteView, self).get_context_data(*args, **kwargs)
        context['cat_menu'] = cat_menu
        return context
    