import logging

from homework.models import HomeworkModel
from homework.serializer import HomeworkSerializer
from rest_framework import status
from rest_framework.generics import CreateAPIView
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response

logger = logging.getLogger(__name__)


class HomeworkCreateView(CreateAPIView):
    queryset = HomeworkModel.objects.all()
    serializer_class = HomeworkSerializer
    permission_classes = [IsAuthenticated]

    def perform_create(self, serializer):
        classroom_id = self.kwargs.get("pk")
        serializer.save(user=self.request.user, classroom_id=classroom_id)

    def create(self, request, *args, **kwargs):
        if request.user.user_type != "professor":
            return Response(
                {"message": "Apenas professores podem criar atividades."},
                status=status.HTTP_403_FORBIDDEN,
            )

        serializer = self.get_serializer(data=request.data)

        try:
            serializer.is_valid(raise_exception=True)
            self.perform_create(serializer)
            return Response(
                {"data": serializer.data, "message": "Atividade criada com sucesso."},
                status=status.HTTP_201_CREATED,
            )
        except Exception as e:
            logger.exception("Erro ao criar atividade: %s", e)
            return Response(
                {"message": "Erro ao criar atividade.", "error": str(e)},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR,
            )
