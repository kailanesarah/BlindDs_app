from authentication.views import (CustomLoginView, CustomLogoutView,
                                  CustomRegisterView, CustomTokenRefreshView,
                                  GoogleLoginView)
from django.urls import path

urlpatterns = [
    path("auth/login/", CustomLoginView.as_view(), name="auth_login"),
    path("auth/logout/", CustomLogoutView.as_view(), name="auth_logout"),
    path("auth/registration/", CustomRegisterView.as_view(), name="auth_register"),
    path("auth/social/", GoogleLoginView.as_view(), name="auth_google_login"),
    path(
        "auth/refresh/",
        CustomTokenRefreshView.as_view(),
        name="auth_token_refresh",
    ),
]
