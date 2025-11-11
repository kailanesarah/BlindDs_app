from rest_framework import serializers

from users.serializers.user_serializer import CustomUserSerializer


class FirebaseLoginSerializer(serializers.Serializer):
    firebase_id_token = serializers.CharField(required=True)
    user = CustomUserSerializer(read_only=True)
    tokens = serializers.DictField(read_only=True)
