"""django_project URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.1/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path
from users import views as user_views
from blog.views import (
    UserPostListView, 
    UserPostDetailView, 
    UserPostCreateView, 
    UserPostUpdateView, 
    UserPostDeleteView, 
    categoryView, 
    OtherPeopleProfileView, 
    PostLikeView,
    searchView,
    ModeratorPostListView,
    categoryInsert
)

from django.conf import settings
from django.conf.urls.static import static

urlpatterns = [
    path("admin/", admin.site.urls),
    path('', user_views.home, name='home'),
    path('register/', user_views.register, name='register'),
    path('login/', user_views.login_request, name='login'),
    path('logout/', user_views.logout_request, name='logout'),
    path('researcher-profile/', UserPostListView.as_view(), name='researcher-profile'),
    path('moderator-profile/', ModeratorPostListView.as_view(), name='moderator-profile'),
    path('post/<int:pk>/', UserPostDetailView.as_view(), name='post-detail'),
    path('post/new/', UserPostCreateView.as_view(), name='post-create'),
    path('post/<int:pk>/edit/', UserPostUpdateView.as_view(), name='post-update'),
    path('post/<int:pk>/delete/', UserPostDeleteView.as_view(), name='post-delete'),
    path('category/<int:cats>/', categoryView, name='category'),
    path('user/edit/', user_views.userInfoUpdate, name='user-update'),
    path('profile/<str:username>/', OtherPeopleProfileView.as_view(), name='other-people-profile'),
    path('like/<int:pk>', PostLikeView, name='post-like'),
    path('search/', searchView, name='search'),
    path('category/insert/', categoryInsert, name='category-insert'),
]

if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
