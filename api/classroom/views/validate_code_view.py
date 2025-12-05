import logging

from classroom.models import ClassroomModel
from classroom.serializers import ClassroomSerializer
from rest_framework import status
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from rest_framework.views import APIView

logger = logging.getLogger(__name__)


class ClassroomSearchView(APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request):
        try:
            user = request.user
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

            if user.user_type != "student":
                return Response(
                    {"message": "Somente alunos podem entrar em salas usando código."},
                    status=status.HTTP_403_FORBIDDEN,
                )

            if classroom.students.filter(id=user.id).exists():
                already_added = True
            else:
                classroom.students.add(user)
                already_added = False

            serializer = ClassroomSerializer(classroom)

            return Response(
                {
                    "classroom": serializer.data,
                    "added_to_classroom": not already_added,
                    "message": (
                        "Aluno adicionado à sala."
                        if not already_added
                        else "Aluno já estava na sala."
                    ),
                },
                status=status.HTTP_200_OK,
            )

        except Exception as e:
            logger.error(f"Erro ao buscar sala: {str(e)}")
            return Response(
                {"message": "Erro interno ao buscar sala."},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR,
            )
