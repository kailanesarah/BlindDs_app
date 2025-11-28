import sys
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
            msg = f"Seed gerado: {atividade.atv_name}"
            self.stdout.write(self.style.SUCCESS(msg))
            print(msg, file=sys.stderr)  # garante que o Render capture
        else:
            msg = "Seed já existente, nada criado."
            self.stdout.write(self.style.WARNING(msg))
            print(msg, file=sys.stderr)  # garante que o Render capture
