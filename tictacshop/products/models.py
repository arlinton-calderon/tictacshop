"""Product models."""

# Django
from django.db import models
from django.dispatch import receiver

import pathlib

# Models
from tictacshop.utils.models import AbstractBaseModel


class AbstractNameModel(AbstractBaseModel):
    name = models.CharField(
        max_length=256,
        unique=True,
        db_index=True,
        verbose_name='nombre'
    )

    class Meta(AbstractBaseModel.Meta):
        abstract = True
        ordering = ['name']

    def __str__(self):
        return self.name


class Brand(AbstractNameModel):
    class Meta(AbstractNameModel.Meta):
        verbose_name = 'marca'
        verbose_name_plural = 'marcas'


class Category(AbstractNameModel):
    class Meta(AbstractNameModel.Meta):
        verbose_name = 'categoria'
        verbose_name_plural = 'categorias'


class Product(AbstractNameModel):
    brand = models.ForeignKey(
        Brand,
        on_delete=models.PROTECT,
        related_name='products',
        verbose_name='marca'
    )

    categories = models.ManyToManyField(
        Category,
        related_name='products',
        verbose_name='categorias'
    )

    price = models.DecimalField(
        verbose_name='precio',
        max_digits=10,
        decimal_places=2
    )

    description = models.TextField(
        max_length=2048,
        blank=True,
        verbose_name='descripción'
    )

    class Meta(AbstractNameModel.Meta):
        verbose_name = 'producto'
        verbose_name_plural = 'productos'
        unique_together = (('name', 'brand'), )
        ordering = ['brand__name', 'name']

    def __str__(self):
        return self.name


class ProductImage(AbstractBaseModel):
    image = models.ImageField(
        upload_to='products/images/%Y/%m/%d',
        verbose_name='archivo'
    )

    product = models.ForeignKey(
        Product,
        on_delete=models.CASCADE,
        related_name='images',
        verbose_name='producto'
    )

    class Meta(AbstractBaseModel.Meta):
        verbose_name = 'imagen'
        verbose_name_plural = 'imágenes'
        unique_together = (('image', 'product'), )

    def __str__(self):
        path = self.image.name
        filename = pathlib.Path(path).name
        return filename

@receiver(models.signals.post_delete, sender=ProductImage)
def auto_delete_file_on_delete(sender, instance, **kwargs):
    """
    Deletes file from filesystem
    when corresponding `ProductImage` object is deleted.
    """
    if instance.image:
        if pathlib.Path(instance.image.path).is_file():
            pathlib.Path(instance.image.path).unlink()

@receiver(models.signals.pre_save, sender=ProductImage)
def auto_delete_file_on_change(sender, instance, **kwargs):
    """
    Deletes old file from filesystem
    when corresponding `ProductImage` object is updated
    with new file.
    """
    if not instance.pk:
        return False

    try:
        old_image = ProductImage.objects.get(pk=instance.pk).image
    except ProductImage.DoesNotExist:
        return False

    new_image = instance.image
    if not old_image == new_image:
        if pathlib.Path(old_image.path).is_file():
            pathlib.Path(old_image.path).unlink()