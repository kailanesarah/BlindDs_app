import logging

from rest_framework import status
from rest_framework.generics import CreateAPIView
from rest_framework.permissions import AllowAny
from rest_framework.response import Response

from users.serializers.register_serializer import RegisterSerializer

logger = logging.getLogger(__name__)


class CustomRegisterView(CreateAPIView):
    serializer_class = RegisterSerializer
    permission_classes = [AllowAny]

    def create(self, request, *args, **kwargs):
        try:
            serializer = self.get_serializer(data=request.data)
            serializer.is_valid(raise_exception=True)
            user = serializer.save()

            data = {
                "id": user.id,
                "email": user.email,
                "name": user.name,
                "user_type": user.user_type,
            }
            return Response(data, status=status.HTTP_201_CREATED)

        except Exception as e:
            logger.error(f"Erro ao registrar usuário: {e}")
            return Response(
                {"detail": f"Ocorreu um erro ao criar o usuário. {e}"},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR,
            )
