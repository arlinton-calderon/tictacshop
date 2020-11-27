# Settings
from django.conf import settings

# Test
from tictacshop.utils.tests import AbstractAdminTest

# Models
from tictacshop.products.models import Category


class CategoryTest(AbstractAdminTest):
    BASE_URL = f'/{settings.ADMIN_URL}/products/category'

    CATEGORY_NAME = 'Cámaras'
    CATEGORY_NAME_MODIFIED = 'Cámaras Modificado'

    def create_category(self, category_name):
        self.client.post(
            f'{type(self).BASE_URL}/add/',
            {'name': category_name} if category_name else None
        )

    def test_create_category(self):
        category_name = type(self).CATEGORY_NAME

        self.create_category(category_name)

        self.assertTrue(Category.objects.filter(name=category_name).exists())

    def test_create_category_with_empty_name(self):
        self.create_category(None)

        self.assertFalse(Category.objects.all().exists())

    def test_change_category(self):
        category_old_name = type(self).CATEGORY_NAME
        category_new_name = type(self).CATEGORY_NAME_MODIFIED

        category = Category.objects.create(name=category_old_name)

        self.assertEqual(category.pk, 1)

        self.client.post(
            f'{type(self).BASE_URL}/1/change/',
            {'name': category_new_name}
        )

        self.assertFalse(Category.objects.filter(name=category_old_name).exists())

        self.assertTrue(Category.objects.filter(name=category_new_name).exists())

    def test_delete_category(self):
        category_name = type(self).CATEGORY_NAME

        category = Category.objects.create(name=category_name)

        self.assertEqual(category.pk, 1)

        self.client.post(
            f'{type(self).BASE_URL}/1/delete/',
            {'name': category_name}
        )

        self.assertFalse(Category.objects.filter(name=category_name).exists())
