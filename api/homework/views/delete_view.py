import logging

from homework.models import HomeworkModel
from homework.serializer import HomeworkSerializer
from rest_framework import status
from rest_framework.generics import DestroyAPIView
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response

logger = logging.getLogger(__name__)


class HomeworkDeleteView(DestroyAPIView):
    queryset = HomeworkModel.objects.all()
    serializer_class = HomeworkSerializer
    permission_classes = [IsAuthenticated]

    def destroy(self, request, *args, **kwargs):
        try:
            if request.user.user_type != "professor":
                return Response(
                    {
                        "message": "Acesso negado. "
                        "Apenas professores podem criar atividades."
                    },
                )

            pk = kwargs.get("pk")

            try:
                homework = HomeworkModel.objects.get(id=pk)
            except HomeworkModel.DoesNotExist:
                return Response(
                    {"message": "Atividade não encontrada."},
                    status=status.HTTP_404_NOT_FOUND,
                )

            self.perform_destroy(homework)

            return Response(
                {"message": "Atividade excluída com sucesso."},
                status=status.HTTP_204_NO_CONTENT,
            )

        except Exception as e:
            logger.error(f"Erro ao excluir atividade: {str(e)}")
            return Response(
                {"message": "Erro interno ao excluir atividade."},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR,
            )
