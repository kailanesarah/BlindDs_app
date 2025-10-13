# users/serializers.py
from dj_rest_auth.registration.serializers import RegisterSerializer
from rest_framework import serializers
from users.models import CustomUser


class CustomUserSerializer(serializers.ModelSerializer):
    class Meta:
        model = CustomUser
        fields = ["id", "email", "username", "user_type", "has_mfa"]


class CustomRegisterSerializer(RegisterSerializer):
    user_type = serializers.ChoiceField(choices=CustomUser.TYPE_USERS, required=False)
    has_mfa = serializers.BooleanField(required=False)

    def get_cleaned_data(self):
        data = super().get_cleaned_data()
        data["user_type"] = self.validated_data.get("user_type", "student")
        data["has_mfa"] = self.validated_data.get("has_mfa", False)
        return data

    def save(self, request):
        user = super().save(request)
        user.user_type = self.cleaned_data.get("user_type")
        user.has_mfa = self.cleaned_data.get("has_mfa")

        # Ajusta permissões se for admin
        if user.user_type == "admin":
            user.is_staff = True
            user.is_superuser = True
        else:
            user.is_staff = False
            user.is_superuser = False

        user.save()
        return user
