from django.core.management.base import BaseCommand
from homework.models import HomeworkModel


class Command(BaseCommand):
    help = "Cria seeds iniciais para o app homework"

    def handle(self, *args, **kwargs):
        atividade, created = HomeworkModel.objects.get_or_create(
            atv_name="Estrutura de dados fila",
            defaults={"atv_description": "Revisar pilha, viewsets e autenticação JWT."},
        )

        if created:
            self.stdout.write(self.style.SUCCESS(f"Seed gerado: {atividade.atv_name}"))
        else:
            self.stdout.write("Seed já existente, nada criado.")
