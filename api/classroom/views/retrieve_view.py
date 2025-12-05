import logging

from classroom.models import ClassroomModel
from classroom.serializers import ClassroomSerializer
from rest_framework import status
from rest_framework.generics import RetrieveAPIView
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response

logger = logging.getLogger(__name__)


class ClassroomRetrieveView(RetrieveAPIView):
    queryset = ClassroomModel.objects.all()
    serializer_class = ClassroomSerializer
    permission_classes = [IsAuthenticated]

    def retrieve(self, request, *args, **kwargs):
        try:
            classroom = self.get_object()

            serializer = self.get_serializer(classroom)

            return Response(
                {
                    "data": serializer.data,
                    "message": "Sala de aula encontrada com sucesso.",
                },
                status=status.HTTP_200_OK,
            )

        except ClassroomModel.DoesNotExist:
            return Response(
                {"message": "Sala de aula não encontrada."},
                status=status.HTTP_404_NOT_FOUND,
            )
        except Exception as e:
            logger.error(f"Erro ao recuperar sala de aula: {str(e)}")
            return Response(
                {"message": "Erro interno ao buscar sala de aula."},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR,
            )
