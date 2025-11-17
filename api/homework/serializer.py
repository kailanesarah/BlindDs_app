from rest_framework import serializers
from homework.models import HomeworkModel


class HomeworkSerializer(serializers.ModelSerializer):
    # Mostra dados do usuário relacionado
    user_id = serializers.UUIDField(source="user.id", read_only=True)

    class Meta:
        model = HomeworkModel
        fields = [
            "atv_id",
            "atv_code",
            "atv_name",
            "atv_description",
            "atv_created_at",
            "atv_updated_at",
            "user_id",  # removido "user"
        ]
        read_only_fields = [
            "atv_id",
            "atv_code",
            "atv_created_at",
            "atv_updated_at",
            "user_id",
        ]

    def validate_atv_name(self, value):
        if len(value) < 3:
            raise serializers.ValidationError(
                "O nome deve ter pelo menos 3 caracteres."
            )
        return value

    def validate(self, attrs):
        user = self.context["request"].user
        name = attrs.get("atv_name")
        if name and HomeworkModel.objects.filter(user=user, atv_name=name).exists():
            raise serializers.ValidationError(
                {"atv_name": "Você já possui uma atividade com esse nome."}
            )
        return attrs

    def create(self, validated_data):
        validated_data["user"] = self.context["request"].user
        return super().create(validated_data)
