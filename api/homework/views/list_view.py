from rest_framework.generics import ListAPIView
from homework.models import HomeworkModel
from homework.serializer import HomeworkSerializer
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from rest_framework import status
import logging

logger = logging.getLogger(__name__)


class HomeworkListView(ListAPIView):
    queryset = HomeworkModel.objects.all()
    serializer_class = HomeworkSerializer
    permission_classes = [
        IsAuthenticated,
    ]

    def list(self, request, *args, **kwargs):
        try:

            queryset = self.get_queryset()
            data = self.get_serializer(queryset, many=True).data

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
