# Django
from django.core.files.uploadedfile import SimpleUploadedFile

# Django Test
from django.test import override_settings

# Settings
from django.conf import settings

# Test
from tictacshop.utils.tests import AbstractAdminTest

# Models
from tictacshop.products.models import (
    Brand,
    Category,
    Product,
    ProductImage
)

# Python
import shutil
import tempfile
import base64
import pathlib


MEDIA_ROOT = tempfile.mkdtemp()


@override_settings(MEDIA_ROOT=MEDIA_ROOT)
class ProductImageTest(AbstractAdminTest):
    BASE_URL = f'/{settings.ADMIN_URL}/products/productimage'

    BRAND = 'Sony'
    CATEGORY = 'Cameras'

    PRODUCT_NAME = 'Compact Camera'
    PRODUCT_PRICE = '1299900.00'
    PRODUCT_DESCRIPTION = 'No description'

    IMAGES = [
        {
            'name': 'image.gif',
            'encoded_pixels': 'R0lGODlhAQABAIAAAP///wAAACH5BAEAAAAALAAAAAABAAEAAAICRAEAOw==',
        },
        {
            'name': 'image_modified.png',
            'encoded_pixels': 'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNk+A8AAQUBAScY42YAAAAASUVORK5CYII=',
        },
    ]

    def setUp(self):
        super().setUp()

        brand = Brand.objects.create(name=type(self).BRAND)

        category = Category.objects.create(name=type(self).CATEGORY)

        self.product = Product.objects.create(
            name=type(self).PRODUCT_NAME,
            brand=brand,
            price=type(self).PRODUCT_PRICE,
            description=type(self).PRODUCT_DESCRIPTION,
        )

        self.product.categories.set([category])
    
    def tearDown(self):
        super().tearDown()
        shutil.rmtree(MEDIA_ROOT, ignore_errors=True)

    def create_product_image(self, image=None):
        data = {}

        if image:
            data['product'] = str(self.product.pk)
            data['image'] = image

        latest = ProductImage.objects.order_by('created').values('pk').first()

        self.client.post(f'{type(self).BASE_URL}/add/', data, follow=True)

        return ProductImage.objects.filter(
            pk__gt=latest['pk'] if latest else -1,
            product__id=self.product.pk,
            image__endswith=image.name if image else ''
        ).first()
    
    def assertImageEqual(self, product_image, image_data, msg=None):
        product_image_filename = pathlib.Path(product_image.image.name).name
        self.assertEqual(product_image_filename, image_data['name'])

        with product_image.image.open() as product_image_file:
            self.assertEqual(
                base64.b64encode(product_image_file.read()).decode('ascii'),
                image_data['encoded_pixels']
            )

    def test_create_product_image(self):
        image_data = type(self).IMAGES[0]
        image_format = pathlib.Path(image_data['name']).suffix.lstrip(".")
        image = SimpleUploadedFile(
            name=image_data['name'],
            content=base64.b64decode(image_data['encoded_pixels']),
            content_type=f'image/{image_format}'
        )

        product_image = self.create_product_image(image)

        self.assertIsNotNone(product_image)

        self.assertImageEqual(product_image, image_data)

    def test_create_product_image_without_submiting_image(self):
        product_image = self.create_product_image()

        self.assertIsNone(product_image)

    def test_change_product_image(self):
        old_image_data = type(self).IMAGES[0]
        old_image_format = pathlib.Path(old_image_data['name']).suffix.lstrip(".")
        old_image = SimpleUploadedFile(
            name=old_image_data['name'],
            content=base64.b64decode(old_image_data['encoded_pixels']),
            content_type=f'image/{old_image_format}'
        )

        product_image = self.create_product_image(old_image)

        self.assertIsNotNone(product_image)

        self.assertImageEqual(product_image, old_image_data)

        new_image_data = type(self).IMAGES[1]
        new_image_format = pathlib.Path(new_image_data['name']).suffix.lstrip(".")
        new_image = SimpleUploadedFile(
            name=new_image_data['name'],
            content=base64.b64decode(new_image_data['encoded_pixels']),
            content_type=f'image/{new_image_format}'
        )

        self.client.post(
            f'{type(self).BASE_URL}/{product_image.pk}/change/',
            {
                'product': str(self.product.pk),
                'image': new_image,
            }
        )

        product_image = ProductImage.objects.get(pk=product_image.pk)

        self.assertImageEqual(product_image, new_image_data)

    def test_delete_product_image(self):
        image_data = type(self).IMAGES[0]
        image_format = pathlib.Path(image_data['name']).suffix.lstrip(".")
        image = SimpleUploadedFile(
            name=image_data['name'],
            content=base64.b64decode(image_data['encoded_pixels']),
            content_type=f'image/{image_format}'
        )

        product_image = self.create_product_image(image)

        self.assertIsNotNone(product_image)

        self.client.post(
            f'{type(self).BASE_URL}/{product_image.pk}/delete/',
            {'post': 'yes'}
        )

        self.assertFalse(ProductImage.objects.filter(pk=product_image.pk).exists())
