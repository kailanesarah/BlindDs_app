from django.db import models
import uuid
from users.models import CustomUser


class ClassroomModel(models.Model):

    STATE_CHOICES = [
        ("active", "Active"),
        ("inactive", "Inactive"),
    ]

    id = models.UUIDField(
        primary_key=True,
        default=uuid.uuid4,
        editable=False,
        verbose_name="ID da Sala",
        help_text="Identificador único da sala",
    )

    code = models.IntegerField(
        unique=True,
        blank=True,
        null=True,
        verbose_name="Código da Sala",
        help_text="Código único de 6 dígitos para a sala",
    )

    name = models.CharField(
        max_length=100, verbose_name="Nome da Sala", help_text="Nome da sala de aula"
    )

    description = models.TextField(
        blank=True,
        null=True,
        verbose_name="Descrição da Sala",
        help_text="Descrição opcional da sala de aula",
    )

    created_at = models.DateTimeField(
        auto_now_add=True,
        verbose_name="Data de Criação",
        help_text="Data e hora em que a sala foi criada",
    )

    updated_at = models.DateTimeField(
        auto_now=True,
        verbose_name="Data de Atualização",
        help_text="Data e hora da última atualização da sala",
    )

    user = models.ForeignKey(
        CustomUser,
        on_delete=models.CASCADE,
        related_name="classrooms",
        verbose_name="Usuário",
        help_text="Usuário que criou a sala",
    )

    status = models.CharField(
        max_length=10,
        choices=STATE_CHOICES,
        default="active",
        verbose_name="Status da Sala",
        help_text="Status atual da sala (ativa ou inativa)",
    )

    def save(self, *args, **kwargs):
        if not self.code:
            self.code = int(str(uuid.uuid4().int)[:6])
        super().save(*args, **kwargs)

    def __str__(self):
        return f"{self.name} ({self.code})"
