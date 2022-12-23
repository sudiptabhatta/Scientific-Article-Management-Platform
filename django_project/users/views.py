from django.shortcuts import render, redirect
from .forms import UserRegisterForm, UserUpdateForm
from django.contrib import messages
from django.contrib.auth import authenticate, login, logout
from blog.models import Category
from django.contrib.auth.decorators import login_required
from .decorators import unauthenticated_user, allowed_users
from django.contrib.auth.models import Group
from django.contrib.auth.mixins import AccessMixin
from django.http import HttpResponseRedirect

# Create your views here.
def home(request):
    return render(request, 'users/home.html')


@unauthenticated_user
def register(request):
    if request.method == 'POST':
        form = UserRegisterForm(request.POST) # post request is gonna contain data in the message body and validate that form data
        if form.is_valid():
            user = form.save()
            username = form.cleaned_data.get('username')

            group = Group.objects.get(name='researcher')
            user.groups.add(group)

            messages.success(request, f'Account created for {username}. You are now able to log in.')
            return redirect('login')
    else:
        form = UserRegisterForm() # display a blank form
    return render(request, 'users/register.html', {'form': form})


@unauthenticated_user
def login_request(request):
    if request.method == 'POST':
        username = request.POST['username']
        password = request.POST['password']
        user = authenticate(request, username=username, password=password)
        if user is not None and user.is_superuser == 1:
            login(request, user)
            messages.success(request, f'Welcome {username}')
            # Redirect to a success page.
            return redirect('moderator-profile')
        if user is not None and user.is_superuser == 0:
            login(request, user)
            messages.success(request, f'Welcome {username}')
            # Redirect to a success page.
            return redirect('researcher-profile')
        else:
            # Return an 'invalid login' error message.
            messages.warning(request, f'There was an error logging in. Try again...')
            return redirect('login')
    else:
        return render(request, 'users/login.html')



# The logout_request function uses the Django function logout() to log the user out of their account and redirect them to the login when the logout URL is requested. 
def logout_request(request):
    logout(request) 
    messages.info(request, f'You have successfully logged out.')
    return redirect('login')


@login_required
@allowed_users(allowed_roles=['admin', 'researcher'])
# user information update
def userInfoUpdate(request):
    if request.method == 'POST':
        u_form = UserUpdateForm(request.POST, request.FILES, instance=request.user)
        if u_form.is_valid():
            u_form.save()
            messages.success(request, f'Your account has been updated!')
            return redirect('researcher-profile')

    else:
        u_form = UserUpdateForm(instance=request.user)

    context = {
        'u_form': u_form,
        'cat_menu': Category.objects.all()
    }

    return render(request, 'users/user_update.html', context)

