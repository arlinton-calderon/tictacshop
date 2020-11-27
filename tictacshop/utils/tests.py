# Django Test
from django.test import TestCase

# Settings
from django.conf import settings

# Models
from tictacshop.users.models import CustomUser


class AbstractAdminTest(TestCase):
    def setUp(self):
        CustomUser.objects.create_superuser(
            username=settings.ADMIN_USERNAME,
            email=settings.ADMIN_EMAIL,
            password=settings.ADMIN_PASSWORD
        )

        self.client.login(
            email=settings.ADMIN_EMAIL,
            password=settings.ADMIN_PASSWORD
        )

    def tearDown(self):
        self.client.logout()
