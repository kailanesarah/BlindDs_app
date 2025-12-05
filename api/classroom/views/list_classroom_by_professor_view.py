import logging

from classroom.serializers import ClassroomSerializer
from rest_framework import status
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from rest_framework.views import APIView

logger = logging.getLogger(__name__)


class ListClassroomsByProfessorView(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request):
        try:
            user = request.user

            if user.user_type != "professor":
                return Response(
                    {"message": "Apenas professores podem visualizar suas salas."},
                    status=status.HTTP_403_FORBIDDEN,
                )

            classrooms = user.classrooms.all()
            has_classrooms = classrooms.exists()

            serializer = ClassroomSerializer(classrooms, many=True)

            return Response(
                {
                    "has_classrooms": has_classrooms,
                    "classrooms": serializer.data,
                },
                status=status.HTTP_200_OK,
            )

        except Exception as e:
            logger.error(f"Erro ao listar salas criadas pelo professor: {str(e)}")
            return Response(
                {"message": "Erro interno ao listar salas criadas pelol professor."},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR,
            )
