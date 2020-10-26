# Django
from django.contrib import admin
from django.utils.html import format_html

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
    list_select_related = True
    list_filter = ('created', 'modified')
    list_display_links = ('image_name', )
    list_display = (
        'image_name',
        'product',
        'image_thumbnail_tag',
        'created',
        'modified',
    )

    search_fields = (
        'product__name',
        'product__brand__name',
        'product__categories__name',
        'image',
    )

    readonly_fields = ('image_large_tag', 'created', 'modified')

    def image_name(self, obj):
        return str(obj)

    image_name.short_description = 'nombre'

    def image_tag(self, obj, width, height):
        return format_html(
            f'<img src="{obj.image.url}" style="width: {width}; height: {height}"/>'
        )

    def image_thumbnail_tag(self, obj):
        return self.image_tag(obj, width='64px', height='64px')

    def image_large_tag(self, obj):
        return self.image_tag(obj, width='256px', height='256px')

    image_thumbnail_tag.short_description = 'imagen'
    image_thumbnail_tag.allow_tags = True
    
    image_large_tag.short_description = 'imagen'
    image_large_tag.allow_tags = True


class ProductImageInline(admin.StackedInline):
    model = ProductImage
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
