"""Base model."""

# Django
from django.db import models
from django.utils.timezone import now


class AbstractBaseModel(models.Model):
    created = models.DateTimeField(
        verbose_name='Creado',
        auto_now_add=True,
    )

    modified = models.DateTimeField(
        verbose_name='Modificado',
        auto_now=True,
    )

    class Meta:
        abstract = True
        get_latest_by = 'created'
        ordering = ['-created', '-modified']
