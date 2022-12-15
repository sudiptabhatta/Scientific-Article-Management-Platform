from django import forms
from django.contrib.auth import get_user_model
from django.contrib.auth.forms import UserCreationForm
from blog.models import Category

User = get_user_model()

class UserRegisterForm(UserCreationForm):
    email = forms.EmailField()

    categories = Category.objects.all()
    specialization = forms.ModelChoiceField(queryset=categories)

    class Meta:
        model = User
        fields = ['username', 'email', 'password1', 'password2', 'specialization']


class UserUpdateForm(forms.ModelForm):
    email = forms.EmailField()

    class Meta:
        model = User
        fields = ['username', 'email', 'profile_pic']