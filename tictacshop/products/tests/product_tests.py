# Settings
from django.conf import settings

# Test
from tictacshop.utils.tests import AbstractAdminTest

# Models
from tictacshop.products.models import Product


class ProductTest(AbstractAdminTest):
    BASE_URL = f'/{settings.ADMIN_URL}/products/product'

    NAME = 'Compact Camera'
    BRAND = 'Sony'
    CATEGORIES = ('Cameras', )
    PRICE = '1299900.00'
    DESCRIPTION = 'No description'

    def create_product(self):
        pass