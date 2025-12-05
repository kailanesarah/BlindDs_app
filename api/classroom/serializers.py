from classroom.models import ClassroomModel
from rest_framework import serializers


class ClassroomSerializer(serializers.ModelSerializer):
    user_email = serializers.EmailField(source="user.email", read_only=True)
    user_id = serializers.UUIDField(source="user.id", read_only=True)

    class Meta:
        model = ClassroomModel
        fields = [
            "id",
            "code",
            "name",
            "description",
            "created_at",
            "updated_at",
            "status",
            "professor",
            "user_id",
            "user_email",
        ]

        read_only_fields = [
            "id",
            "code",
            "created_at",
            "updated_at",
            "status",
            "professor",
        ]

    def validate_name(self, value):
        if len(value.strip()) == 0:
            raise serializers.ValidationError("O nome da sala não pode estar vazio.")
        return value
