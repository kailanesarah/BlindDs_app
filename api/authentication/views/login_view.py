import logging

from api.authentication.utils.jwt_utils import generate_jwt_tokens
from dj_rest_auth.views import LoginView
from rest_framework import status
from rest_framework.permissions import AllowAny
from rest_framework.response import Response
from api.users.serializers.user_serializer import CustomUserSerializer

logger = logging.getLogger(__name__)


class CustomLoginView(LoginView):
    permission_classes = [AllowAny]

    def get_response(self):
        try:
            user = self.user
            user_data = CustomUserSerializer(user).data

            tokens = generate_jwt_tokens(user)
            user_data.update(tokens)

            return Response(user_data, status=status.HTTP_200_OK)

        except Exception as e:
            logger.error(f"Erro no login: {e}")
            return Response(
                {"detail": "Erro ao processar login."},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR,
            )
