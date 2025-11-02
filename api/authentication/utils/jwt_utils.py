import logging

from rest_framework_simplejwt.tokens import RefreshToken

logger = logging.getLogger(__name__)


def generate_jwt_tokens(user):
    """
    Gera tokens JWT (access e refresh) para um usuário.
    Retorna um dicionário com as chaves 'access' e 'refresh'.
    """
    try:
        refresh = RefreshToken.for_user(user)
        return {
            "access": str(refresh.access_token),
            "refresh": str(refresh),
        }
    except Exception as e:
        logger.error(f"Erro ao gerar tokens JWT: {e}")
        return {
            "access": None,
            "refresh": None,
        }
