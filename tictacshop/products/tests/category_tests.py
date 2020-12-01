# Settings
from django.conf import settings

# Test
from tictacshop.utils.tests import AbstractAdminTest

# Models
from tictacshop.products.models import Category


class CategoryTest(AbstractAdminTest):
    BASE_URL = f'/{settings.ADMIN_URL}/products/category'

    NAME = 'Cámaras'
    NAME_MODIFIED = f'{NAME} Modificado'

    def create_category(self, name=None):
        latest = Category.objects.order_by('created').values('pk').first()

        self.client.post(
            f'{type(self).BASE_URL}/add/',
            {'name': name} if name else None
        )

        return Category.objects.filter(pk__gt=latest['pk'] if latest else -1, name=name).first()

    def test_create_category(self):
        name = type(self).NAME

        category = self.create_category(name)

        self.assertIsNotNone(category)

        self.assertEqual(category.name, name)

    def test_create_category_with_empty_name(self):
        category = self.create_category()

        self.assertIsNone(category)

    def test_change_category(self):
        old_name = type(self).NAME
        new_name = type(self).NAME_MODIFIED

        category = self.create_category(name=old_name)

        self.assertIsNotNone(category)

        self.client.post(
            f'{type(self).BASE_URL}/{category.pk}/change/',
            {'name': new_name}
        )

        category = Category.objects.get(pk=category.pk)

        self.assertEqual(category.name, new_name)

    def test_delete_category(self):
        name = type(self).NAME

        category = self.create_category(name=name)

        self.assertIsNotNone(category)

        self.client.post(
            f'{type(self).BASE_URL}/{category.pk}/delete/',
            {'post': 'yes'}
        )

        self.assertFalse(Category.objects.filter(pk=category.pk).exists())
