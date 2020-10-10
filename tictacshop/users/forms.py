"""User model form."""

# Django
from django.contrib.auth.forms import UserCreationForm

# Models
from tictacshop.users.models import CustomUser


class CustomUserCreationForm(UserCreationForm):
    class Meta(UserCreationForm.Meta):
        model = CustomUser
        fields = ('username', 'email', )
