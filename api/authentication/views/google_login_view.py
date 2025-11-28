import logging

from rest_framework import status
from rest_framework.permissions import AllowAny
from rest_framework.response import Response
from rest_framework.views import APIView

from authentication.serializers import FirebaseLoginSerializer
from authentication.services.firebase_auth_service import FirebaseAuthService

logger = logging.getLogger(__name__)


class FirebaseLoginView(APIView):
    permission_classes = [AllowAny]

    def post(self, request, *args, **kwargs):
        try:
            logger.debug(f"Dados recebidos no backend: {request.data}")

            serializer = FirebaseLoginSerializer(data=request.data)
            serializer.is_valid(raise_exception=True)
            logger.debug("Serializer validado com sucesso")

            firebase_id_token = serializer.validated_data.get("firebase_id_token")
            logger.debug(f"Token recebido do cliente: {firebase_id_token}")

            decoded_token = FirebaseAuthService.verify_token(firebase_id_token)
            if not decoded_token:
                logger.warning("Token inválido ou expirado")
                return Response(
                    {"detail": "Token de autenticação inválido ou expirado."},
                    status=status.HTTP_401_UNAUTHORIZED,
                )
            logger.debug(f"Token decodificado: {decoded_token}")

            user = FirebaseAuthService.get_or_create_user(decoded_token)
            if not user:
                logger.error("Falha ao criar ou recuperar usuário")
                return Response(
                    {"detail": "Erro ao processar os dados do usuário."},
                    status=status.HTTP_500_INTERNAL_SERVER_ERROR,
                )
            logger.debug(f"Usuário autenticado: {user.email}")

            tokens = FirebaseAuthService.generate_tokens(user)
            if not tokens:
                logger.error("Falha ao gerar tokens")
                return Response(
                    {"detail": "Erro ao gerar tokens de autenticação."},
                    status=status.HTTP_500_INTERNAL_SERVER_ERROR,
                )
            logger.debug(f"Tokens gerados: {tokens}")

            return Response(
                {
                    "detail": "Login realizado com sucesso.",
                    "data": {
                        "user": {
                            "id": str(user.id),
                            "email": user.email,
                            "username": user.username,
                            "user_type": user.user_type,
                            "has_mfa": user.has_mfa,
                        },
                        "tokens": tokens,
                    },
                },
                status=status.HTTP_200_OK,
            )

        except Exception as e:
            logger.error(f"Erro inesperado no login com Firebase: {e}", exc_info=True)
            return Response(
                {"detail": "Erro interno ao processar login."},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR,
            )
