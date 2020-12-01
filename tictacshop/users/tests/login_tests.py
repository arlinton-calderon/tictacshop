# Django
from django.contrib import auth
from django.contrib.auth.models import AnonymousUser

# Django Test
from django.test import TestCase

# Settings
from django.conf import settings

# Models
from tictacshop.users.models import CustomUser


class LoginTest(TestCase):
    BASE_URL = f'/{settings.ADMIN_URL}/login'

    VALID_USERNAME = 'new_admin'
    VALID_EMAIL = f'{VALID_USERNAME}@tictacshop.com'
    VALID_PASSWORD = f'{VALID_USERNAME}_password'

    INVALID_USERNAME = 'old_admin'
    INVALID_EMAIL = f'{INVALID_USERNAME}@tictacshop.com'
    INVALID_PASSWORD = f'{INVALID_USERNAME}_password'

    def setUp(self):
        CustomUser.objects.create_superuser(
            username=type(self).VALID_USERNAME,
            email=type(self).VALID_EMAIL,
            password=type(self).VALID_PASSWORD
        )

    def login(self, email, password):
        data = {}
        
        if email:
            data['username'] = email
        
        if password:
            data['password'] = password

        self.client.post(f'{type(self).BASE_URL}/', data)
    
    def assertIsLoggedUser(self, username, email, password):
        self.assertIn(auth.SESSION_KEY, self.client.session)

        user = auth.get_user(self.client)

        self.assertIsInstance(user, CustomUser)

        self.assertTrue(user.is_authenticated)

        self.assertEqual(user.username, username)

        self.assertEqual(user.email, email)

        self.assertTrue(user.check_password(password))
    
    def assertIsAnonymousUser(self):
        self.assertNotIn(auth.SESSION_KEY, self.client.session)

        user = auth.get_user(self.client)

        self.assertIsInstance(user, AnonymousUser)

        self.assertFalse(user.is_authenticated)

    def test_login_with_valid_credentials(self):
        username = type(self).VALID_USERNAME
        email = type(self).VALID_EMAIL
        password = type(self).VALID_PASSWORD

        self.login(email=email, password=password)

        self.assertIsLoggedUser(
            username=username,
            email=email,
            password=password
        )

    def test_login_without_submitting_email(self):
        password = type(self).INVALID_PASSWORD

        self.login(email=None, password=password)

        self.assertIsAnonymousUser()
    
    def test_login_without_submitting_password(self):
        email = type(self).INVALID_EMAIL

        self.login(email=email, password=None)

        self.assertIsAnonymousUser()
    
    def test_login_without_submitting_credentials(self):
        self.login(email=None, password=None)

        self.assertIsAnonymousUser()
    
    def test_login_with_invalid_credentials(self):
        email = type(self).INVALID_EMAIL
        password = type(self).INVALID_PASSWORD

        self.login(email=email, password=password)

        self.assertIsAnonymousUser()
    
    def test_logout(self):
        username = type(self).VALID_USERNAME
        email = type(self).VALID_EMAIL
        password = type(self).VALID_PASSWORD

        self.login(email=email, password=password)

        self.assertIsLoggedUser(
            username=username,
            email=email,
            password=password
        )

        self.client.post(f'/{settings.ADMIN_URL}/logout/')

        self.assertIsAnonymousUser()