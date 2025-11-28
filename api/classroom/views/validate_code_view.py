from classroom.models import ClassroomModel
from classroom.serializers import ClassroomSerializer
from rest_framework.views import APIView
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from rest_framework import status
import logging

logger = logging.getLogger(__name__)


class ClassroomSearchView(APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request):
        try:
            code = request.data.get("code", "").strip().upper()

            if not code:
                return Response(
                    {"message": "Informe o código."},
                    status=status.HTTP_400_BAD_REQUEST,
                )

            classroom = ClassroomModel.objects.filter(code=code).first()

            if not classroom:
                return Response(
                    {"message": "Sala de aula não encontrada."},
                    status=status.HTTP_404_NOT_FOUND,
                )

            """ # Criar ou recuperar o histórico (impede duplicação) -> 
            Historico de quais alunos entreram na sala?
            created = ClassroomModel.objects.get_or_create(
                user=user, homework=homework
            )

            serializer = ClassroomSerializer(homework)

            return Response(
                {"activity": serializer.data, "added_to_history": created},
                status=status.HTTP_200_OK,
            )
            """

            serializer = ClassroomSerializer(classroom)
            return Response(
                {"classroom": serializer.data},
                status=status.HTTP_200_OK,
            )

        except Exception as e:
            logger.error(f"Erro ao buscar sala: {str(e)}")
            return Response(
                {"message": "Erro interno ao buscar sala."},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR,
            )
