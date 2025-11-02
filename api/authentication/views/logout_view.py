import logging

from dj_rest_auth.views import LogoutView
from rest_framework import status
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from rest_framework_simplejwt.tokens import RefreshToken

logger = logging.getLogger(__name__)


class CustomLogoutView(LogoutView):
    permission_classes = [IsAuthenticated]

    def post(self, request, *args, **kwargs):
        try:
            refresh_token = request.data.get("refresh")
            if refresh_token:
                try:
                    token = RefreshToken(refresh_token)
                    token.blacklist()
                except Exception as e:
                    logger.warning(f"Erro ao invalidar refresh token: {e}")
        except Exception as e:
            logger.error(f"Erro no logout: {e}")

        return Response(
            {"detail": "Logout realizado com sucesso."},
            status=status.HTTP_200_OK,
        )
