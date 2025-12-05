import secrets
import string
import uuid

from django.db import models

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

    code = models.CharField(
        max_length=6,
        unique=True,
        blank=True,
        null=True,
        verbose_name="Código da Sala",
        help_text="Código único de 6 caracteres para a sala",
    )

    name = models.CharField(
        max_length=100,
        verbose_name="Nome da Sala",
        help_text="Nome da sala de aula",
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

    professor = models.ForeignKey(
        CustomUser,
        on_delete=models.CASCADE,
        related_name="classrooms",
        verbose_name="Professor Criador",
        help_text="Usuário que criou a sala",
    )

    students = models.ManyToManyField(
        CustomUser,
        related_name="enrolled_classrooms",
        blank=True,
        verbose_name="Alunos da Sala",
        help_text="Lista de alunos matriculados na sala",
    )

    status = models.CharField(
        max_length=10,
        choices=STATE_CHOICES,
        default="active",
        verbose_name="Status da Sala",
        help_text="Status atual da sala (ativa ou inativa)",
    )

    class Meta:
        ordering = ["-created_at"]
        verbose_name = "Sala"
        verbose_name_plural = "Salas"

    @staticmethod
    def generate_unique_code():
        """Gera um código único de 6 caracteres."""
        alphabet = string.ascii_uppercase + string.digits
        return "".join(secrets.choice(alphabet) for _ in range(6))

    def save(self, *args, **kwargs):
        if not self.code:
            for _ in range(10):  # tenta 10 códigos diferentes
                new_code = self.generate_unique_code()
                if not ClassroomModel.objects.filter(code=new_code).exists():
                    self.code = new_code
                    break
            else:
                raise ValueError("Não foi possível gerar um código único para a sala.")

        super().save(*args, **kwargs)

    def __str__(self):
        return f"{self.name} ({self.code})"
