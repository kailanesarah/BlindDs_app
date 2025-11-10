from rest_framework import serializers
from api.users.models import CustomUser
from api.users.utils.username_utils import generate_username


class RegisterSerializer(serializers.ModelSerializer):
    password = serializers.CharField(write_only=True, required=True)

    class Meta:
        model = CustomUser
        fields = ["email", "name", "user_type", "password"]

    def create(self, validated_data):
        # Gera username automaticamente
        username = generate_username(validated_data["name"])
        user = CustomUser.objects.create_user(
            email=validated_data["email"],
            name=validated_data["name"],
            username=username,
            password=validated_data["password"],
        )
        if validated_data["user_type"] == "admin":
            user.is_staff = True
            user.is_superuser = True
        user.user_type = validated_data["user_type"]
        user.save()
        return user
