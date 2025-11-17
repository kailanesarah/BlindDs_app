import os
import django

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "cors.settings")
django.setup()

from homework.models import HomeworkModel


def run():
    atividade, created = HomeworkModel.objects.get_or_create(
        atv_name="Estrutura de dados fila",
        defaults={"atv_description": "Revisar pilha, viewsets e autenticação JWT."},
    )

    if created:
        print("--------------- SEED GERADO ---------------")
        print("Atividade criada:")
        print(f"Nome: {atividade.atv_name}")
        print(f"Descrição: {atividade.atv_description}")
        print(f"Código gerado: {atividade.atv_code}")
        print("-------------------------------------------")
    else:
        print("Seed já existente, nada criado.")


if __name__ == "__main__":
    run()
