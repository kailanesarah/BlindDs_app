import uuid

from django.contrib.auth.models import AbstractUser, BaseUserManager
from django.db import models


class CustomUserManager(BaseUserManager):
    """
    Manager customizado para o modelo CustomUser.
    """

    def create_user(self, email, username, password=None, **extra_fields):
        if not email:
            raise ValueError("O email é obrigatório")
        if not username:
            raise ValueError("O username é obrigatório")

        email = self.normalize_email(email)
        user = self.model(email=email, username=username, **extra_fields)
        user.set_password(password)
        user.save(using=self._db)
        return user

    def create_superuser(self, email, username, password=None, **extra_fields):
        extra_fields.setdefault("is_staff", True)
        extra_fields.setdefault("is_superuser", True)
        extra_fields.setdefault("is_active", True)
        extra_fields.setdefault("user_type", "admin")

        if extra_fields.get("is_staff") is not True:
            raise ValueError("Superuser precisa ter is_staff=True.")
        if extra_fields.get("is_superuser") is not True:
            raise ValueError("Superuser precisa ter is_superuser=True.")

        return self.create_user(email=email, username=username, password=password)


class CustomUser(AbstractUser):
    """
    Modelo de usuário customizado.
    """

    TYPE_USERS = (
        ("student", "student"),
        ("professor", "professor"),
        ("admin", "admin"),
    )

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    email = models.EmailField(unique=True)
    user_type = models.CharField(max_length=20, choices=TYPE_USERS, default="student")
    has_mfa = models.BooleanField(default=False)

    USERNAME_FIELD = "email"  # login será pelo email
    REQUIRED_FIELDS = ["username"]  # obrigatório ao criar superuser

    objects = CustomUserManager()

    def __str__(self):
        return self.username
