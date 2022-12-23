from django.http import HttpResponse
from django.shortcuts import redirect

# if you are logged in, but want to view login or registration page, then this will redirect you to the profile page. if not, this will redirect you to the login or registration page based on which page you want to access.
def unauthenticated_user(view_func):
    def wrapper_func(request, *args, **kwargs):
        if request.user.is_authenticated and request.user.is_superuser:
            return redirect('moderator-profile')
        elif request.user.is_authenticated and not request.user.is_superuser:
            return redirect('researcher-profile')
        else:
            return view_func(request, *args, **kwargs)
    return wrapper_func


def allowed_users(allowed_roles=[]):
    def decorator(view_func):
        def wrapper_func(request, *args, **kwargs):
            group = None
            if request.user.groups.exists():
                group = request.user.groups.all()[0].name
            
            if group in allowed_roles:
                return view_func(request, *args, **kwargs)
            else:
                return HttpResponse('You are not authorized to view this page')
        return wrapper_func
    return decorator

