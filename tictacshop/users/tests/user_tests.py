# Settings
from django.conf import settings

# Test
from tictacshop.utils.tests import AbstractAdminTest

# Models
from tictacshop.users.models import CustomUser


class UserTest(AbstractAdminTest):
    BASE_URL = f'/{settings.ADMIN_URL}/users/customuser'

    USERNAME = 'warehouse'
    EMAIL = f'{USERNAME}@tictacshop.com'
    PASSWORD = 'safe password'

    USERNAME_MODIFIED = f'{USERNAME}_modified'
    EMAIL_MODIFIED = f'{USERNAME_MODIFIED}@tictacshop.com'
    FIRST_NAME = 'No first name'
    LAST_NAME = 'No last name'

    def create_user(self, *, username='', email='', first_name='', last_name='', password=''):
        data = {}

        if username:
            data['username'] = username

        if email:
            data['email'] = email

        if first_name:
            data['first_name'] = first_name

        if last_name:
            data['last_name'] = last_name

        if password:
            data['password1'] = password
            data['password2'] = password

        latest = CustomUser.objects.order_by('created').values('pk').first()

        self.client.post(f'{type(self).BASE_URL}/add/', data)

        if password:
            data.pop('password1')
            data.pop('password2')

        return CustomUser.objects.filter(pk__gt=latest['pk'] if latest else -1, **data).first()

    def test_create_user(self):
        username = type(self).USERNAME
        email = type(self).EMAIL
        password = type(self).PASSWORD

        user = self.create_user(
            username=username,
            email=email,
            password=password
        )

        self.assertIsNotNone(user)

        self.assertEqual(user.username, username)

        self.assertEqual(user.email, email)

        self.assertTrue(user.check_password(password))

    def test_create_user_without_submitting_credentials(self):
        user = self.create_user()

        self.assertIsNone(user)

    def test_change_user(self):
        username = type(self).USERNAME
        email = type(self).EMAIL
        password = type(self).PASSWORD

        username_modified = type(self).USERNAME_MODIFIED
        email_modified = type(self).EMAIL_MODIFIED
        first_name = type(self).FIRST_NAME
        last_name = type(self).LAST_NAME

        user = self.create_user(
            username=username,
            email=email,
            password=password
        )

        self.assertIsNotNone(user)

        response = self.client.post(
            f'{type(self).BASE_URL}/{user.pk}/change/',
            {
                'username': username_modified,
                'email': email_modified,
                'first_name': first_name,
                'last_name': last_name,
                'is_active': user.is_active,
                'is_staff': user.is_staff,
                'is_superuser': user.is_superuser,
                'date_joined_0': user.date_joined.date(),
                'date_joined_1': user.date_joined.time(),
                'last_login_0': '',
                'last_login_1': ''
            }
        )

        print(str(response.content, encoding='utf-8'))

        user = CustomUser.objects.get(pk=user.pk)

        self.assertEqual(user.username, username_modified)

        self.assertEqual(user.email, email_modified)

        self.assertEqual(user.first_name, first_name)

        self.assertEqual(user.last_name, last_name)

        self.assertTrue(user.check_password(password))

    def test_delete_user(self):
        username = type(self).USERNAME
        email = type(self).EMAIL
        password = type(self).PASSWORD

        user = self.create_user(
            username=username,
            email=email,
            password=password
        )

        self.assertIsNotNone(user)

        self.client.post(
            f'{type(self).BASE_URL}/{user.pk}/delete/',
            {'post': 'yes'}
        )

        self.assertFalse(CustomUser.objects.filter(pk=user.pk).exists())
