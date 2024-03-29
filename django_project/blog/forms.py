from django import forms
from .models import Post, Comment, Category

class PostForm(forms.ModelForm):
    class Meta:
        model = Post
        fields = ['title', 'content', 'image', 'cid']

        widgets = {
            'title': forms.TextInput(attrs={'class': 'form-control'}),
            'content': forms.Textarea(attrs={'class': 'form-control'}),
            'image': forms.FileInput(attrs={'class': 'form-control'}),
            'cid': forms.Select(attrs={'class': 'form-control'}),
        }


class EditForm(forms.ModelForm):
    class Meta:
        model = Post
        fields = ['title', 'content', 'image', 'cid']

        widgets = {
            'title': forms.TextInput(attrs={'class': 'form-control'}),
            'content': forms.Textarea(attrs={'class': 'form-control'}),
            'cid': forms.Select(attrs={'class': 'form-control'}),
        }


class CommentForm(forms.ModelForm):
    class Meta:
        model = Comment
        fields = ['comment']

        widgets = {
            'comment': forms.Textarea(attrs={'class': 'form-control'})
        }


class CategoryForm(forms.ModelForm):
    class Meta:
        model = Category
        fields = ['category_name']

        widgets = {
            'category_name': forms.TextInput(attrs={'class': 'form-control'})
        }