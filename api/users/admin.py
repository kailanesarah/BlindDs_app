from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from users.models import CustomUser


@admin.register(CustomUser)
class CustomUserAdmin(UserAdmin):
    model = CustomUser
    list_display = (
        "username",
        "email",
        "user_type",
        "is_active",
        "is_staff",
        "has_mfa",
    )
    list_filter = ("user_type", "is_staff", "is_active")
    search_fields = ("username", "email")
    ordering = ("username",)

    fieldsets = (
        ("Informações de Login", {"fields": ("email", "password")}),
        ("Informações Pessoais", {"fields": ("username", "name", "user_type")}),
        (
            "Permissões",
            {
                "fields": (
                    "is_active",
                    "is_staff",
                    "is_superuser",
                    "groups",
                    "user_permissions",
                )
            },
        ),
        ("Segurança", {"fields": ("has_mfa",)}),
        ("Datas Importantes", {"fields": ("last_login", "date_joined")}),
    )

    add_fieldsets = (
        (
            "Criação de Novo Usuário",
            {
                "classes": ("wide",),
                "fields": ("email", "username", "password1", "password2", "user_type"),
            },
        ),
    )
