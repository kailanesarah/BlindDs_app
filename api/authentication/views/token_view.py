import logging

from rest_framework import status
from rest_framework.response import Response
from rest_framework_simplejwt.views import TokenRefreshView
from rest_framework_simplejwt.exceptions import TokenError

logger = logging.getLogger(__name__)


class CustomTokenRefreshView(TokenRefreshView):

    def post(self, request, *args, **kwargs):
        try:
            return super().post(request, *args, **kwargs)
        except TokenError as te:
            logger.warning(f"Erro ao atualizar token: {te}")
            return Response(
                {"detail": "Token inválido ou expirado."},
                status=status.HTTP_401_UNAUTHORIZED,
            )
        except Exception as e:
            logger.error(f"Erro inesperado ao atualizar token: {e}")
            return Response(
                {"detail": "Erro interno ao atualizar token."},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR,
            )
