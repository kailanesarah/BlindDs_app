import logging

from rest_framework import status
from rest_framework.response import Response
from rest_framework_simplejwt.views import TokenRefreshView

logger = logging.getLogger(__name__)


class CustomTokenRefreshView(TokenRefreshView):

    def handle_exception(self, exc):
        logger.error(f"Erro ao atualizar token: {exc}")

        if hasattr(exc, "detail"):
            detail = exc.detail
        else:
            detail = "Não foi possível atualizar o token."

        return Response(
            {"detail": detail},
            status=status.HTTP_401_UNAUTHORIZED,
        )
