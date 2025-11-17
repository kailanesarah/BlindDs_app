from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from homework.models import HomeworkModel
from homework.serializer import HomeworkSerializer
from rest_framework.permissions import IsAuthenticated
import logging

logger = logging.getLogger(__name__)


class HomeworkSearchView(APIView):
    permission_classes = [IsAuthenticated]

    queryset = HomeworkModel.objects.all()
    serializer_class = HomeworkSerializer

    def post(self, request):
        try:
            code = request.data.get("atv_code")

            if not code:
                return Response(
                    {"message": "Informe o código."}, status=status.HTTP_400_BAD_REQUEST
                )

            # Busca a atividade
            homework = self.queryset.filter(atv_code=code).first()

            if not homework:
                return Response(
                    {"message": "Atividade não encontrada."},
                    status=status.HTTP_404_NOT_FOUND,
                )

            serializer = self.serializer_class(homework)
            return Response({"data": serializer.data}, status=status.HTTP_200_OK)

        except Exception as e:
            logger.error(f"Erro ao buscar atividade: {str(e)}")
            return Response(
                {"message": "Erro interno ao buscar atividade."},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR,
            )
