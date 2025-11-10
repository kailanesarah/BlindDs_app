import logging

from dj_rest_auth.views import LogoutView
from rest_framework import status
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from rest_framework_simplejwt.tokens import RefreshToken, TokenError

logger = logging.getLogger(__name__)


class CustomLogoutView(LogoutView):
    permission_classes = [IsAuthenticated]

    def post(self, request, *args, **kwargs):
        refresh_token = request.data.get("refresh")

        if not refresh_token:
            logger.warning("Logout solicitado sem refresh token.")
            return Response(
                {"detail": "Refresh token não fornecido."},
                status=status.HTTP_400_BAD_REQUEST,
            )

        try:
            token = RefreshToken(refresh_token)
            token.blacklist()
            return Response(
                {"detail": "Logout realizado com sucesso."},
                status=status.HTTP_200_OK,
            )
        except TokenError as te:
            # Erros relacionados a tokens inválidos ou expirados
            logger.warning(f"Erro ao invalidar refresh token: {te}")
            return Response(
                {"detail": "Refresh token inválido ou expirado."},
                status=status.HTTP_400_BAD_REQUEST,
            )
        except Exception as e:
            # Erros inesperados
            logger.error(f"Erro no logout: {e}")
            return Response(
                {"detail": "Erro interno ao realizar logout."},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR,
            )
