"""User model."""

# Django
from django.db import models
from django.contrib.auth.models import AbstractUser

# Models
from tictacshop.utils.models import AbstractBaseModel


class CustomUser(AbstractBaseModel, AbstractUser):
    """User model.

    Extend from Django's AbstractUser, change the username field
    to email and add some extra fields.
    """

    email = models.EmailField(
        verbose_name='Correo electrónico',
        unique=True,
        error_messages={
            'unique': 'Ya existe un usuario registrado con este correo electrónico.'
        }
    )

    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = ['username', 'first_name', 'last_name']

    class Meta(AbstractBaseModel.Meta):
        verbose_name = 'usuario'
        verbose_name_plural = 'usuarios'

    def __str__(self):
        return self.username

    def get_short_name(self):
        return self.username

    def get_full_name(self):
        return self.username
