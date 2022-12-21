from django import forms
from django.contrib.auth import get_user_model # I changed the default User model. So I need to change the way I access it The right way to use it is get_user_model()
from django.contrib.auth.forms import UserCreationForm # it is used to create a new user
from blog.models import Category

User = get_user_model()

class UserRegisterForm(UserCreationForm):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.fields['cid'].required = True

    email = forms.EmailField()

    # categories = Category.objects.all()
    # specialization = forms.ModelChoiceField(queryset=categories)

    class Meta:
        model = User
        fields = ['username', 'email', 'password1', 'password2', 'cid']

        widgets = {
            'cid': forms.Select(attrs={'class': 'form-control'}),
        }


class UserUpdateForm(forms.ModelForm):
    email = forms.EmailField()

    class Meta:
        model = User
        fields = ['username', 'email', 'profile_pic']