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
            serializer = FirebaseLoginSerializer(data=request.data)
            serializer.is_valid(raise_exception=True)

            firebase_id_token = serializer.validated_data.get("firebase_id_token")
            decoded_token = FirebaseAuthService.verify_token(firebase_id_token)
            if not decoded_token:
                return Response(
                    {"detail": "Token de autenticação inválido ou expirado."},
                    status=status.HTTP_401_UNAUTHORIZED,
                )

            user = FirebaseAuthService.get_or_create_user(decoded_token)
            if not user:
                return Response(
                    {"detail": "Erro ao processar os dados do usuário."},
                    status=status.HTTP_500_INTERNAL_SERVER_ERROR,
                )

            tokens = FirebaseAuthService.generate_tokens(user)
            if not tokens:
                return Response(
                    {"detail": "Erro ao gerar tokens de autenticação."},
                    status=status.HTTP_500_INTERNAL_SERVER_ERROR,
                )

            response_data = FirebaseAuthService.build_response(user, tokens)
            if not response_data:
                return Response(
                    {"detail": "Erro interno ao montar a resposta do servidor."},
                    status=status.HTTP_500_INTERNAL_SERVER_ERROR,
                )

            return Response(response_data, status=status.HTTP_200_OK)

        except Exception as e:
            logger.error(f"Erro inesperado no login com Firebase: {e}")
            return Response(
                {"detail": "Erro interno ao processar login."},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR,
            )
