import logging

from classroom.models import ClassroomModel
from classroom.serializers import ClassroomSerializer
from rest_framework import status
from rest_framework.generics import ListAPIView
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response

logger = logging.getLogger(__name__)


class ClassroomListView(ListAPIView):
    queryset = ClassroomModel.objects.all()
    serializer_class = ClassroomSerializer
    permission_classes = [
        IsAuthenticated,
    ]

    def list(self, request, *args, **kwargs):
        try:
            if request.user.user_type != "admin":
                return Response(
                    {
                        "message": "Acesso negado. "
                        + "Apenas administradores do sistema"
                        + "podem listar as salas de aula."
                    },
                    status=status.HTTP_403_FORBIDDEN,
                )

            queryset = self.get_queryset()
            data = self.get_serializer(queryset, many=True).data

            return Response(
                {
                    "data": data,
                    "message": "Salas de aula listadas com sucesso.",
                },
                status=status.HTTP_200_OK,
            )

        except Exception as e:
            logger.error(f"Erro ao listar salas de aula: {str(e)}")
            return Response(
                {"message": "Erro interno ao listar salas de aula."},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR,
            )
