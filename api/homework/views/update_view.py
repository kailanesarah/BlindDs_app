import logging

from homework.models import HomeworkModel
from homework.serializer import HomeworkSerializer
from rest_framework import status
from rest_framework.generics import UpdateAPIView
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response

logger = logging.getLogger(__name__)


class HomeworkUpdateView(UpdateAPIView):
    queryset = HomeworkModel.objects.all()
    serializer_class = HomeworkSerializer
    permission_classes = [IsAuthenticated]

    def update(self, request, *args, **kwargs):
        try:
            pk = kwargs.get("pk")

            if request.user.user_type != "professor":
                return Response(
                    {
                        "message": "Acesso negado."
                        "Apenas professores podem atualizar atividades."
                    },
                    status=status.HTTP_403_FORBIDDEN,
                )

            try:
                homework = HomeworkModel.objects.get(id=pk)
            except HomeworkModel.DoesNotExist:
                return Response(
                    {"message": "Atividade não encontrada."},
                    status=status.HTTP_404_NOT_FOUND,
                )

            serializer = self.get_serializer(homework, data=request.data, partial=True)
            serializer.is_valid(raise_exception=True)
            self.perform_update(serializer)
            data = serializer.data

            return Response(
                {"data": data, "message": "Atividade atualizada com sucesso."},
                status=status.HTTP_200_OK,
            )

        except Exception as e:
            logger.error(f"Erro ao atualizar atividade: {str(e)}")
            return Response(
                {"message": "Erro interno ao atualizar atividade."},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR,
            )
