from django.contrib import admin
from django.contrib.auth.admin import UserAdmin

from .models import CustomUser


@admin.register(CustomUser)
class CustomUserAdmin(UserAdmin):
    model = CustomUser
    list_display = ["email", "username", "user_type", "is_staff"]
    fieldsets = UserAdmin.fieldsets + ((None, {"fields": ("user_type", "has_mfa")}),)
