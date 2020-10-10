# Django
from django.contrib import admin

# Models
from tictacshop.products.models import Brand, Category, Product, ProductImage


class BaseSimpleAdmin(admin.ModelAdmin):
    list_display = ('name', 'created', 'modified')
    list_display_links = None
    list_editable = ('name', )
    list_filter = ('created', 'modified')

    search_fields = ('name', )
    readonly_fields = ('created', 'modified')


@admin.register(Brand)
class BrandAdmin(BaseSimpleAdmin):
    pass


@admin.register(Category)
class CategoryAdmin(BaseSimpleAdmin):
    pass


@admin.register(ProductImage)
class ProductImageAdmin(admin.ModelAdmin):
    list_display = ('image', 'created', 'modified')
    list_display_links = ('image', )
    list_filter = ('created', 'modified')

    search_fields = (
        'product__name',
        'product__brand__name',
        'product__categories__name',
        'image',
    )

    readonly_fields = ('created', 'modified')


class ProductImageInline(admin.StackedInline):
    model = ProductImage
    can_delete = False
    verbose_name_plural = 'imagenes'


@admin.register(Product)
class ProductAdmin(admin.ModelAdmin):
    inlines = (ProductImageInline, )

    list_display = ('name', 'brand', 'price', 'created', 'modified')
    list_display_links = ('name', )
    list_filter = ('created', 'modified')

    search_fields = (
        'name',
        'brand__name',
        'categories__name'
    )
