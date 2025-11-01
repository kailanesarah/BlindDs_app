import logging

from allauth.socialaccount.models import SocialAccount
from allauth.socialaccount.providers.google.views import GoogleOAuth2Adapter
from allauth.socialaccount.providers.oauth2.client import OAuth2Client
from authentication.utils.jwt_utils import generate_jwt_tokens
from dj_rest_auth.registration.views import SocialLoginView
from rest_framework import status
from rest_framework.response import Response
from users.serializers.user_serializer import CustomUserSerializer

logger = logging.getLogger(__name__)


class GoogleLoginView(SocialLoginView):
    adapter_class = GoogleOAuth2Adapter
    client_class = OAuth2Client

    def get_response(self):
        try:
            user = self.user
            user_data = CustomUserSerializer(user).data

            tokens = generate_jwt_tokens(user)
            user_data.update(tokens)

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
