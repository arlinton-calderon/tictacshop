# Settings
from django.conf import settings

# Test
from tictacshop.utils.tests import AbstractAdminTest

# Models
from tictacshop.products.models import Brand


class BrandTest(AbstractAdminTest):
    BASE_URL = f'/{settings.ADMIN_URL}/products/brand'

    BRAND_NAME = 'Sony'
    BRAND_NAME_MODIFIED = 'Sony Modificado'

    def create_brand(self, brand_name):
        self.client.post(
            f'{type(self).BASE_URL}/add/',
            {'name': brand_name} if brand_name else None
        )

    def test_create_brand(self):
        brand_name = type(self).BRAND_NAME

        self.create_brand(brand_name)

        self.assertTrue(Brand.objects.filter(name=brand_name).exists())

    def test_create_brand_with_empty_name(self):
        self.create_brand(None)

        self.assertFalse(Brand.objects.all().exists())

    def test_change_brand(self):
        brand_old_name = type(self).BRAND_NAME
        brand_new_name = type(self).BRAND_NAME_MODIFIED

        brand = Brand.objects.create(name=brand_old_name)

        self.assertEqual(brand.pk, 1)

        self.client.post(
            f'{type(self).BASE_URL}/1/change/',
            {'name': brand_new_name}
        )

        self.assertFalse(Brand.objects.filter(name=brand_old_name).exists())

        self.assertTrue(Brand.objects.filter(name=brand_new_name).exists())

    def test_delete_brand(self):
        brand_name = type(self).BRAND_NAME

        brand = Brand.objects.create(name=brand_name)

        self.assertEqual(brand.pk, 1)

        self.client.post(
            f'{type(self).BASE_URL}/1/delete/',
            {'name': brand_name}
        )

        self.assertFalse(Brand.objects.filter(name=brand_name).exists())
