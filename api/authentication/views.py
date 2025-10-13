# users/views.py
from authentication.serializers import CustomRegisterSerializer
from dj_rest_auth.registration.views import RegisterView
from dj_rest_auth.views import LoginView, LogoutView
from rest_framework import status
from rest_framework.permissions import AllowAny, IsAuthenticated
from rest_framework.response import Response
from rest_framework_simplejwt.tokens import RefreshToken
from users.serializers import CustomUserSerializer


class CustomLoginView(LoginView):
    permission_classes = [AllowAny]

    def get_response(self):
        user = self.user  # usuário autenticado
        user_data = CustomUserSerializer(user).data

        # JWT
        refresh = RefreshToken.for_user(user)
        user_data["access"] = str(refresh.access_token)
        user_data["refresh"] = str(refresh)

        return Response(user_data, status=status.HTTP_200_OK)


class CustomRegisterView(RegisterView):
    permission_classes = [AllowAny]
    serializer_class = CustomRegisterSerializer

    def get_response_data(self, user):
        user_data = CustomUserSerializer(user).data
        return user_data

    def create(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        user = self.perform_create(serializer)
        data = self.get_response_data(user)
        headers = self.get_success_headers(serializer.data)
        return Response(data, status=status.HTTP_201_CREATED, headers=headers)


class CustomLogoutView(LogoutView):
    permission_classes = [IsAuthenticated]

    def post(self, request, *args, **kwargs):
        try:
            refresh_token = request.data.get("refresh")
            if refresh_token:
                token = RefreshToken(refresh_token)
                token.blacklist()
        except Exception:
            pass
        return Response(
            {"detail": "Logout realizado com sucesso."}, status=status.HTTP_200_OK
        )
