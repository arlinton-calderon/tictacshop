"""User model admin."""

# Django
from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from django.contrib.auth.models import User
from django.utils.translation import gettext_lazy as _

# Models
from tictacshop.users.models import CustomUser

# Forms
from tictacshop.users.forms import CustomUserCreationForm


class CustomUserAdmin(UserAdmin):
    """User model admin."""

    fieldsets = (
        (None, {'fields': ('username', 'password')}),
        (_('Personal info'), {
            'fields': (
                'email',
                'first_name',
                'last_name'
            )
        }),
        (_('Permissions'), {
            'fields': (
                'is_active',
                'is_staff',
                'is_superuser',
                'groups',
                'user_permissions'
            ),
        }),
        (_('Important dates'), {
            'fields': (
                'date_joined',
                'last_login',
            )
        }),
    )

    add_fieldsets = (
        (None, {
            'classes': ('wide',),
            'fields': (
                'username',
                'email',
                'password1',
                'password2',
            ),
        }),
    )

    add_form = CustomUserCreationForm

    list_display = (
        'username',
        'email',
        'first_name',
        'last_name',
        'is_staff',
        'is_active',
        'created',
        'modified',
    )

    list_filter = ('created', 'modified', 'is_staff', 'is_active', )

    ordering = ('username', )


admin.site.register(CustomUser, CustomUserAdmin)
