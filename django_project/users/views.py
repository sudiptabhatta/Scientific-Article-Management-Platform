from django.shortcuts import render, redirect
from .forms import UserRegisterForm
from django.contrib import messages
from django.contrib.auth import logout

# Create your views here.
def home(request):
    return render(request, 'users/home.html')


def register(request):
    if request.method == 'POST':
        form = UserRegisterForm(request.POST)
        if form.is_valid():
            form.save()
            username = form.cleaned_data.get('username')
            messages.success(request, f'Account created for {username}. You are now able to log in.')
            return redirect('login')
    else:
        form = UserRegisterForm()
    return render(request, 'users/register.html', {'form': form})


# The logout_request function uses the Django function logout() to log the user out of their account and redirect them to the login when the logout URL is requested. 
def logout_request(request):
    logout(request) 
    messages.info(request, f'You have successfully logged out.')
    return redirect('login')