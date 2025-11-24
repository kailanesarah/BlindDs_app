from classroom.models import ClassroomModel
from classroom.serializers import ClassroomSerializer
from rest_framework.generics import UpdateAPIView
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from rest_framework import status
import logging

logger = logging.getLogger(__name__)


class ClassroomUpdateView(UpdateAPIView):
    queryset = ClassroomModel.objects.all()
    serializer_class = ClassroomSerializer
    permission_classes = [IsAuthenticated]

    def update(self, request, *args, **kwargs):
        try:
            pk = kwargs.get("pk")

            # Verifica permissão
            if request.user.user_type != "professor":
                return Response(
                    {
                        "message": "Acesso negado."
                        + "Apenas professores podem atualizar "
                        + "informações de uma sala de aula."
                    },
                    status=status.HTTP_403_FORBIDDEN,
                )

            # Verifica se o ID existe
            try:
                classroom = ClassroomModel.objects.get(id=pk)
            except ClassroomModel.DoesNotExist:
                return Response(
                    {"message": "Sala de aula não encontrada."},
                    status=status.HTTP_404_NOT_FOUND,
                )

            serializer = self.get_serializer(classroom, data=request.data, partial=True)
            serializer.is_valid(raise_exception=True)
            self.perform_update(serializer)
            data = serializer.data

            return Response(
                {"data": data, "message": "Sala de aula atualizada com sucesso."},
                status=status.HTTP_200_OK,
            )

        except Exception as e:
            logger.error(f"Erro ao atualizar sala de aula: {str(e)}")
            return Response(
                {"message": "Erro interno ao atualizar sala de aula."},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR,
            )
