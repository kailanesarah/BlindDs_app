from classroom.models import ClassroomModel
from classroom.serializers import ClassroomSerializer
from rest_framework.generics import CreateAPIView
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from rest_framework import status
import logging

logger = logging.getLogger(__name__)


class ClassroomCreateView(CreateAPIView):
    queryset = ClassroomModel.objects.all()
    serializer_class = ClassroomSerializer
    permission_classes = [
        IsAuthenticated,
    ]

    def perform_create(self, serializer):
        serializer.save(user=self.request.user)

    def create(self, request, *args, **kwargs):
        if request.user.user_type != "professor":
            return Response(
                {
                    "message": "Acesso negado. Apenas professores"
                    + " podem criar uma sala de aula."
                },
                status=status.HTTP_403_FORBIDDEN,
            )

        serializer = self.get_serializer(data=request.data)
        try:
            serializer.is_valid(raise_exception=True)
            self.perform_create(serializer)
            return Response(
                {
                    "data": serializer.data,
                    "message": "Sala de aula criada com sucesso.",
                },
                status=status.HTTP_201_CREATED,
            )
        except Exception as e:
            logger.exception("Erro ao criar sala de aula: %s", e)
            return Response(
                {
                    "message": "Ocorreu um erro ao criar a sala de aula.",
                    "error": str(e),
                },
                status=status.HTTP_500_INTERNAL_SERVER_ERROR,
            )
