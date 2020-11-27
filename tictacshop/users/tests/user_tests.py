# Settings
from django.conf import settings

# Test
from tictacshop.utils.tests import AbstractAdminTest

# Models
from tictacshop.users.models import CustomUser


class UserTest(AbstractAdminTest):
    BASE_URL = f'/{settings.ADMIN_URL}/users/customuser'