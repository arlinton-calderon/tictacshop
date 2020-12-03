# Settings
from django.conf import settings

# Test
from tictacshop.utils.tests import AbstractAdminTest

# Models
from tictacshop.products.models import (Brand, Category, Product)


class ProductTest(AbstractAdminTest):
    BASE_URL = f'/{settings.ADMIN_URL}/products/product'

    BRANDS = ['Sony', 'Samsung']
    CATEGORIES = ['Cameras', 'TVs']

    NAME = 'Compact Camera'
    PRICE = '1299900.00'
    DESCRIPTION = 'No description'

    NAME_MODIFIED = f'{NAME} (Modified)'
    PRICE_MODIFIED = '1300000.00'
    DESCRIPTION_MODIFIED = f'{DESCRIPTION} (Modified)'

    IMAGES_FIELDSET_DATA = {
        'images-TOTAL_FORMS': '0',
        'images-INITIAL_FORMS': '0',
        'images-MIN_NUM_FORMS': '',
        'images-MAX_NUM_FORMS': '',
    }

    def setUp(self):
        super().setUp()

        Brand.objects.bulk_create(
            [Brand(name=name) for name in type(self).BRANDS]
        )

        Category.objects.bulk_create(
            [Category(name=name) for name in type(self).CATEGORIES]
        )

    def create_product(self, *, name='', brand='', categories=[], price='', description=''):
        data = {}

        if name:
            data['name'] = name

        if brand and (brand_object := Brand.objects.filter(name=brand).values('pk').first()):
            data['brand'] = str(brand_object['pk'])

        if categories and (categories_list := Category.objects.filter(name__in=categories).values('pk')):
            data['categories'] = [
                str(category['pk'])
                for category in categories_list
            ]

        if price:
            data['price'] = price

        if description:
            data['description'] = description

        data.update(type(self).IMAGES_FIELDSET_DATA)

        latest = Product.objects.order_by('created').values('pk').first()

        self.client.post(f'{type(self).BASE_URL}/add/', data)

        if 'brand' in data:
            data.pop('brand')

        if 'categories' in data:
            data.pop('categories')

        for key in type(self).IMAGES_FIELDSET_DATA.keys():
            data.pop(key)

        data['brand__name'] = brand
        data['categories__name__in'] = categories

        return Product.objects.filter(pk__gt=latest['pk'] if latest else -1, **data).first()

    def test_create_product(self):
        name = type(self).NAME
        brand = type(self).BRANDS[0]
        categories = type(self).CATEGORIES[:1]
        price = type(self).PRICE
        description = type(self).DESCRIPTION

        product = self.create_product(
            name=name,
            brand=brand,
            categories=categories,
            price=price,
            description=description,
        )

        self.assertIsNotNone(product)

        self.assertEqual(product.name, name)

        self.assertEqual(product.brand.name, brand)

        self.assertEqual(
            [category.name for category in product.categories.all()],
            categories
        )

        self.assertEqual(str(product.price), price)

        self.assertEqual(product.description, description)

    def test_create_product_without_submitting_credentials(self):
        product = self.create_product()

        self.assertIsNone(product)

    def test_change_product(self):
        name = type(self).NAME
        brand = type(self).BRANDS[0]
        categories = type(self).CATEGORIES[:1]
        price = type(self).PRICE
        description = type(self).DESCRIPTION

        name_modified = type(self).NAME_MODIFIED
        brand_modified = type(self).BRANDS[1]
        categories_modified = type(self).CATEGORIES[1:]
        price_modified = type(self).PRICE_MODIFIED
        description_modified = type(self).DESCRIPTION_MODIFIED

        product = self.create_product(
            name=name,
            brand=brand,
            categories=categories,
            price=price,
            description=description,
        )

        self.assertIsNotNone(product)

        brand_object = Brand.objects.filter(name=brand_modified).values('pk').first()
        brand_id = brand_object['pk'] if brand_object else -1

        categories_list = Category.objects.filter(name__in=categories_modified).values('pk')
        categories_ids = [str(category['pk']) for category in categories_list]

        data = {
            'name': name_modified,
            'brand': brand_id,
            'categories': categories_ids,
            'price': price_modified,
            'description': description_modified,
        }

        data.update(type(self).IMAGES_FIELDSET_DATA)

        self.client.post(
            f'{type(self).BASE_URL}/{product.pk}/change/',
            data
        )

        product = Product.objects.get(pk=product.pk)

        self.assertEqual(product.name, name_modified)

        self.assertEqual(product.brand.name, brand_modified)

        self.assertEqual(
            [category.name for category in product.categories.all()],
            categories_modified
        )

        self.assertEqual(str(product.price), price_modified)

        self.assertEqual(product.description, description_modified)

    def test_delete_product(self):
        name = type(self).NAME
        brand = type(self).BRANDS[0]
        categories = type(self).CATEGORIES[:1]
        price = type(self).PRICE
        description = type(self).DESCRIPTION

        product = self.create_product(
            name=name,
            brand=brand,
            categories=categories,
            price=price,
            description=description,
        )

        self.assertIsNotNone(product)

        self.client.post(
            f'{type(self).BASE_URL}/{product.pk}/delete/',
            {'post': 'yes'}
        )

        self.assertFalse(Product.objects.filter(pk=product.pk).exists())
