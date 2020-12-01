# Settings
from django.conf import settings

# Test
from tictacshop.utils.tests import AbstractAdminTest

# Models
from tictacshop.products.models import Brand


class BrandTest(AbstractAdminTest):
    BASE_URL = f'/{settings.ADMIN_URL}/products/brand'

    NAME = 'Sony'
    NAME_MODIFIED = f'{NAME} Modificado'

    def create_brand(self, name=None):
        latest = Brand.objects.order_by('created').values('pk').first()

        self.client.post(
            f'{type(self).BASE_URL}/add/',
            {'name': name} if name else None
        )

        return Brand.objects.filter(pk__gt=latest['pk'] if latest else -1, name=name).first()

    def test_create_brand(self):
        name = type(self).NAME

        brand = self.create_brand(name)

        self.assertIsNotNone(brand)

        self.assertEqual(brand.name, name)

    def test_create_brand_with_empty_name(self):
        brand = self.create_brand()

        self.assertIsNone(brand)

    def test_change_brand(self):
        old_name = type(self).NAME
        new_name = type(self).NAME_MODIFIED

        brand = self.create_brand(name=old_name)

        self.assertIsNotNone(brand)

        self.client.post(
            f'{type(self).BASE_URL}/{brand.pk}/change/',
            {'name': new_name}
        )

        brand = Brand.objects.get(pk=brand.pk)

        self.assertEqual(brand.name, new_name)

    def test_delete_brand(self):
        name = type(self).NAME

        brand = self.create_brand(name=name)

        self.assertIsNotNone(brand)

        self.client.post(
            f'{type(self).BASE_URL}/{brand.pk}/delete/',
            {'post': 'yes'}
        )

        self.assertFalse(Brand.objects.filter(pk=brand.pk).exists())
