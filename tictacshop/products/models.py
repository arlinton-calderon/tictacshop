"""Product models."""

from django.db import models


from tictacshop.utils.models import AbstractBaseModel


class AbstractNameModel(AbstractBaseModel):
    name = models.CharField(
        max_length=256,
        unique=True,
        db_index=True,
        verbose_name='Nombre'
    )

    class Meta(AbstractBaseModel.Meta):
        abstract = True

    def __str__(self):
        return self.name


class Brand(AbstractNameModel):
    class Meta(AbstractNameModel.Meta):
        verbose_name = 'marca'
        verbose_name_plural = 'marcas'
        ordering = ['name']


class Category(AbstractNameModel):
    class Meta(AbstractNameModel.Meta):
        verbose_name = 'categoria'
        verbose_name_plural = 'categorias'
        ordering = ['name']


class Product(AbstractNameModel):
    brand = models.ForeignKey(
        Brand,
        on_delete=models.PROTECT,
        related_name='products',
        verbose_name='Marca'
    )

    categories = models.ManyToManyField(
        Category,
        related_name='products',
        verbose_name='Categorias'
    )

    price = models.DecimalField(
        verbose_name='Precio',
        max_digits=10,
        decimal_places=2
    )

    description = models.TextField(
        max_length=2048,
        blank=True,
        verbose_name='Descripción'
    )

    class Meta:
        verbose_name = 'producto'
        verbose_name_plural = 'productos'
        unique_together = (('name', 'brand'), )
        ordering = ['brand__name', 'name']

    def __str__(self):
        return f'{self.brand.name} - {self.name}'


class ProductImage(AbstractBaseModel):
    image = models.ImageField(
        upload_to='products/images/%Y/%m/%d',
        blank=True,
        null=True,
        verbose_name='Archivo'
    )

    product = models.ForeignKey(
        Product,
        on_delete=models.CASCADE,
        related_name='images',
        verbose_name='Producto'
    )

    class Meta:
        verbose_name = 'imagen'
        verbose_name_plural = 'imagenes'

    def __str__(self):
        return str(self.image)
