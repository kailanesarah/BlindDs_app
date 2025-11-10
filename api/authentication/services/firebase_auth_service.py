import logging
from firebase_admin import auth
from api.users.models import CustomUser
from api.users.utils.username_utils import generate_username
from api.authentication.utils.jwt_utils import generate_jwt_tokens
from api.users.serializers.register_serializer import RegisterSerializer

logger = logging.getLogger(__name__)


class FirebaseAuthService:
    @staticmethod
    def verify_token(firebase_id_token):
        try:
            decoded = auth.verify_id_token(firebase_id_token)
            if not decoded.get("uid") or not decoded.get("email"):
                raise ValueError("Token inválido.")
            return decoded
        except Exception as e:
            logger.error(f"Falha na verificação do token Firebase: {e}")
            return None

    @staticmethod
    def get_or_create_user(decoded_token):
        try:
            email = decoded_token.get("email")
            display_name = decoded_token.get("name") or email.split("@")[0]
            username = generate_username(display_name)

            user, created = CustomUser.objects.get_or_create(
                email=email,
                defaults={"name": display_name, "username": username},
            )

            if not created and not user.name:
                user.name = display_name
                user.save()

            return user
        except Exception as e:
            logger.error(f"Erro ao criar ou atualizar usuário: {e}")
            return None

    @staticmethod
    def generate_tokens(user):
        try:
            return generate_jwt_tokens(user)
        except Exception as e:
            logger.error(f"Erro ao gerar tokens JWT: {e}")
            return None

    @staticmethod
    def build_response(user, tokens):
        try:
            user_data = RegisterSerializer(user).data
            user_data["name"] = user.name
            return {"user": user_data, "tokens": tokens}
        except Exception as e:
            logger.error(f"Erro ao montar resposta do login: {e}")
            return None
