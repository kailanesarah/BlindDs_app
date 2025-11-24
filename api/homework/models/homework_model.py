from django.db import models
import uuid
from users.models import CustomUser
from classroom.models import ClassroomModel


class HomeworkModel(models.Model):

    id = models.UUIDField(
        primary_key=True,
        default=uuid.uuid4,
        editable=False,
        verbose_name="ID da Atividade",
        help_text="Identificador único da atividade",
    )

    name = models.CharField(
        max_length=30,
        verbose_name="Nome da Atividade",
        help_text="Nome da atividade de homework",
    )

    description = models.CharField(
        max_length=255,
        blank=True,
        null=True,
        verbose_name="Descrição da Atividade",
        help_text="Descrição opcional da atividade de homework",
    )

    deadline = models.DateTimeField(
        null=True,
        blank=True,
        verbose_name="Data de Entrega",
        help_text="Data e hora limite para entrega da atividade",
    )

    created_at = models.DateTimeField(
        auto_now_add=True,
        verbose_name="Data de Criação",
        help_text="Data e hora em que a atividade foi criada",
    )

    updated_at = models.DateTimeField(
        auto_now=True,
        verbose_name="Data de Atualização",
        help_text="Data e hora da última atualização da atividade",
    )

    user = models.ForeignKey(
        CustomUser,
        on_delete=models.CASCADE,
        related_name="homeworks",
        verbose_name="Usuário",
        help_text="Usuário que criou a atividade",
    )

    classroom = models.ForeignKey(
        ClassroomModel,
        on_delete=models.CASCADE,
        related_name="homeworks",
        verbose_name="Sala",
        help_text="Sala à qual esta atividade pertence",
    )

    def __str__(self):
        return f"{self.name} ({self.id})"
