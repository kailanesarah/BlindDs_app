import logging

from homework.models import HomeworkModel
from homework.serializer import HomeworkSerializer
from rest_framework import status
from rest_framework.generics import ListAPIView
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response

logger = logging.getLogger(__name__)


class HomeworkListView(ListAPIView):
    queryset = HomeworkModel.objects.all()
    serializer_class = HomeworkSerializer
    permission_classes = [
        IsAuthenticated,
    ]

    def list(self, request, *args, **kwargs):
        try:
            pk = kwargs.get("pk")

            try:
                classroom = HomeworkModel.objects.filter(classroom=pk)
            except HomeworkModel.DoesNotExist:
                return Response(
                    {"message": "Atividade não encontrada."},
                    status=status.HTTP_404_NOT_FOUND,
                )

            data = self.get_serializer(classroom, many=True).data

            return Response(
                {
                    "data": data,
                    "message": "Atividades listadas com sucesso.",
                },
                status=status.HTTP_200_OK,
            )

        except Exception as e:
            logger.error(f"Erro ao listar atividades: {str(e)}")
            return Response(
                {"message": "Erro interno ao listar atividades."},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR,
            )
