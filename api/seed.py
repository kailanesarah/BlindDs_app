import os
import django
from homework.models import HomeworkModel

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "cors.settings")
django.setup()


def run():
    atividade = HomeworkModel.objects.create(
        atv_name="Estrutura de dados fila",
        atv_description="Revisar pilha, viewsets e autenticação JWT.",
    )

    print("--------------- SEED GERADO ---------------")
    print("Atividade criada:")
    print(f"Nome: {atividade.atv_name}")
    print(f"Descrição: {atividade.atv_description}")
    print(f"Código gerado: {atividade.atv_code}")
    print("-------------------------------------------")


if __name__ == "__main__":
    run()
