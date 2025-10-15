import logging

from allauth.socialaccount.models import SocialAccount
from allauth.socialaccount.providers.google.views import GoogleOAuth2Adapter
from allauth.socialaccount.providers.oauth2.client import OAuth2Client
from authentication.serializers import CustomRegisterSerializer
from dj_rest_auth.registration.views import RegisterView, SocialLoginView
from dj_rest_auth.views import LoginView, LogoutView
from rest_framework import status
from rest_framework.permissions import AllowAny, IsAuthenticated
from rest_framework.response import Response
from rest_framework_simplejwt.tokens import RefreshToken
from users.serializers import CustomUserSerializer

logger = logging.getLogger(__name__)


class CustomLoginView(LoginView):
    permission_classes = [AllowAny]

    def get_response(self):
        try:
            user = self.user  # usuário autenticado
            user_data = CustomUserSerializer(user).data

            # JWT
            refresh = RefreshToken.for_user(user)
            user_data["access"] = str(refresh.access_token)
            user_data["refresh"] = str(refresh)

            return Response(user_data, status=status.HTTP_200_OK)

        except Exception as e:
            logger.error(f"Erro no login: {e}")

            return Response(
                {"detail": "Erro ao processar login."},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR,
            )


class CustomRegisterView(RegisterView):
    permission_classes = [AllowAny]
    serializer_class = CustomRegisterSerializer

    def get_response_data(self, user):

        try:
            user_data = CustomUserSerializer(user).data
            return user_data

        except Exception as e:

            logger.error(f"Erro ao gerar dados do usuário: {e}")
            return {"detail": "Erro ao gerar dados do usuário."}

    def create(self, request, *args, **kwargs):
        try:

            serializer = self.get_serializer(data=request.data)
            serializer.is_valid(raise_exception=True)
            user = self.perform_create(serializer)
            data = self.get_response_data(user)
            headers = self.get_success_headers(serializer.data)

            return Response(data, status=status.HTTP_201_CREATED, headers=headers)

        except Exception as e:

            logger.error(f"Erro no registro: {e}")

            return Response(
                {"detail": "Erro ao registrar usuário."},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR,
            )


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
            {"detail": "Logout realizado com sucesso."}, status=status.HTTP_200_OK
        )


class GoogleLogin(SocialLoginView):
    adapter_class = GoogleOAuth2Adapter
    client_class = OAuth2Client

    def get_response(self):
        try:
            user = self.user
            user_data = CustomUserSerializer(user).data

            # JWT
            refresh = RefreshToken.for_user(user)
            user_data["access"] = str(refresh.access_token)
            user_data["refresh"] = str(refresh)

            # Informação de login social
            try:
                social_account = SocialAccount.objects.filter(
                    user=user, provider="google"
                ).first()
                user_data["social_login"] = bool(social_account)

            except Exception as e:

                logger.warning(f"Erro ao verificar SocialAccount: {e}")
                user_data["social_login"] = False

            return Response(user_data, status=status.HTTP_200_OK)

        except Exception as e:

            logger.error(f"Erro no login social Google: {e}")
            return Response(
                {"detail": "Erro ao processar login social."},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR,
            )
