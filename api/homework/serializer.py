from rest_framework import serializers
from homework.models import HomeworkModel


class HomeworkSerializer(serializers.ModelSerializer):
    user_id = serializers.UUIDField(source="user.id", read_only=True)
    classroom = serializers.UUIDField(source="classroom.id", read_only=True)

    class Meta:
        model = HomeworkModel
        fields = [
            "id",
            "name",
            "description",
            "deadline",
            "created_at",
            "updated_at",
            "user_id",
            "classroom",
        ]
        read_only_fields = [
            "id",
            "created_at",
            "updated_at",
            "user_id",
            "classroom",
        ]

    def validate_name(self, value):
        if len(value) < 3:
            raise serializers.ValidationError(
                "O nome deve ter pelo menos 3 caracteres."
            )
        return value

    def validate(self, attrs):
        user = self.context["request"].user
        name = attrs.get("name")
        if name and HomeworkModel.objects.filter(user=user, name=name).exists():
            raise serializers.ValidationError(
                {"name": "Você já possui uma atividade com esse nome."}
            )
        return attrs
