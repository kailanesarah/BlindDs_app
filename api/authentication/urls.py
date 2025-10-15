from authentication.views import (CustomLoginView, CustomLogoutView,
                                  CustomRegisterView, GoogleLogin)
from django.urls import path

urlpatterns = [
    path("auth/login/", CustomLoginView.as_view(), name="custom_login"),
    path("auth/logout/", CustomLogoutView.as_view(), name="custom_logout"),
    path("auth/registration/", CustomRegisterView.as_view(), name="custom_register"),
    path("auth/social/", GoogleLogin.as_view(), name="Google-login"),
]
