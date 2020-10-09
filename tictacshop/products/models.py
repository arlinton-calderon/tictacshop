from django.db import models


class BaseDateModel(models.Model):
    created = models.DateTimeField(auto_now_add=True, verbose_name='Creado')
    modified = models.DateTimeField(auto_now=True, verbose_name='Modificado')

    class Meta:
        abstract = True


class BaseNameModel(BaseDateModel):
    name = models.CharField(
        max_length=256,
        unique=True,
        db_index=True,
        verbose_name='Nombre'
    )

    class Meta:
        abstract = True

    def __str__(self):
        return self.name


class Brand(BaseNameModel):
    class Meta(BaseNameModel.Meta):
        verbose_name = 'marca'
        verbose_name_plural = 'marcas'
        ordering = ['name']


class Category(BaseNameModel):
    class Meta(BaseNameModel.Meta):
        verbose_name = 'categoria'
        verbose_name_plural = 'categorias'
        ordering = ['name']


class Product(BaseNameModel):
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


class ProductImage(BaseDateModel):
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
