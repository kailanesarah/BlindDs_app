from classroom.models import ClassroomModel
from classroom.serializers import ClassroomSerializer
from rest_framework.generics import DestroyAPIView
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from rest_framework import status
import logging

logger = logging.getLogger(__name__)


class ClassroomDeleteView(DestroyAPIView):
    queryset = ClassroomModel.objects.all()
    serializer_class = ClassroomSerializer
    permission_classes = [IsAuthenticated]

    def destroy(self, request, *args, **kwargs):
        try:
            if request.user.user_type != "professor":
                return Response(
                    {
                        "message": "Acesso negado. "
                        + "Apenas professores podem criar atividades."
                    },
                )

            pk = kwargs.get("pk")

            try:
                classroom = ClassroomModel.objects.get(id=pk)
            except ClassroomModel.DoesNotExist:
                return Response(
                    {"message": "Sala de aula não encontrada."},
                    status=status.HTTP_404_NOT_FOUND,
                )

            # executa a exclusão padrão do DRF
            self.perform_destroy(classroom)

            return Response(
                {"message": "Sala de Aula excluída com sucesso."},
                status=status.HTTP_204_NO_CONTENT,
            )

        except Exception as e:
            logger.error(f"Erro ao excluir sala de aula: {str(e)}")
            return Response(
                {"message": "Erro interno ao excluir sala de aula."},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR,
            )
