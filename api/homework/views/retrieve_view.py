from rest_framework.generics import RetrieveAPIView
from homework.models import HomeworkModel
from homework.serializer import HomeworkSerializer
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from rest_framework import status
import logging

logger = logging.getLogger(__name__)


class HomeworkRetrieveView(RetrieveAPIView):
    queryset = HomeworkModel.objects.all()
    serializer_class = HomeworkSerializer
    permission_classes = [IsAuthenticated]

    def retrieve(self, request, *args, **kwargs):
        try:

            pk = kwargs.get("pk")

            try:
                homework = HomeworkModel.objects.get(id=pk)
            except HomeworkModel.DoesNotExist:
                return Response(
                    {"message": "Atividade não encontrada."},
                    status=status.HTTP_404_NOT_FOUND,
                )

            serializer = self.get_serializer(homework)

            return Response(
                {
                    "data": serializer.data,
                    "message": "Atividade encontrada com sucesso.",
                },
                status=status.HTTP_200_OK,
            )

        except Exception as e:
            logger.error(f"Erro ao recuperar atividade: {str(e)}")
            return Response(
                {"message": "Erro interno ao buscar atividade."},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR,
            )
