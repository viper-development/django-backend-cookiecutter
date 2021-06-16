from django.contrib.auth.models import AnonymousUser as DefaultAnonymousUser

from authemail.models import EmailUserManager, EmailAbstractUser


class AnonymousUser(DefaultAnonymousUser):
    pass


class User(EmailAbstractUser):
    # Required by authemail
    objects = EmailUserManager()
