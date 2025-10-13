from datetime import timedelta
from pathlib import Path

BASE_DIR = Path(__file__).resolve().parent.parent

SECRET_KEY = "django-insecure-tm_^3s2*dgbcf&2=_=$ekyj4n_jdsbg9gzckb8g688savwn$!"
DEBUG = True
ALLOWED_HOSTS = []

# Modelo customizado
AUTH_USER_MODEL = "users.CustomUser"

# -----------------------------
# Configurações do dj-rest-auth / JWT
# -----------------------------
REST_USE_JWT = True  # Habilita JWT
# Não desabilitar TokenModel se quiser Key também
# REST_AUTH_TOKEN_MODEL = None  # Comentado, pois queremos manter a Key também

# -----------------------------
# Aplicativos instalados
# -----------------------------
INSTALLED_APPS = [
    "django.contrib.admin",
    "django.contrib.auth",
    "django.contrib.contenttypes",
    "django.contrib.sessions",
    "django.contrib.messages",
    "django.contrib.staticfiles",
    "users",
    # DRF + autenticação
    "rest_framework",
    "rest_framework.authtoken",  # Mantém para Key
    "dj_rest_auth",
    "dj_rest_auth.registration",
    # Allauth
    "allauth",
    "allauth.account",
    "allauth.socialaccount",
]

# -----------------------------
# Middleware
# -----------------------------
MIDDLEWARE = [
    "django.middleware.security.SecurityMiddleware",
    "django.contrib.sessions.middleware.SessionMiddleware",
    "django.middleware.common.CommonMiddleware",
    "django.middleware.csrf.CsrfViewMiddleware",
    "django.contrib.auth.middleware.AuthenticationMiddleware",
    "allauth.account.middleware.AccountMiddleware",
    "django.contrib.messages.middleware.MessageMiddleware",
    "django.middleware.clickjacking.XFrameOptionsMiddleware",
]

ROOT_URLCONF = "cors.urls"

TEMPLATES = [
    {
        "BACKEND": "django.template.backends.django.DjangoTemplates",
        "DIRS": [],
        "APP_DIRS": True,
        "OPTIONS": {
            "context_processors": [
                "django.template.context_processors.request",
                "django.contrib.auth.context_processors.auth",
                "django.contrib.messages.context_processors.messages",
            ],
        },
    },
]

WSGI_APPLICATION = "cors.wsgi.application"

# -----------------------------
# Banco de dados
# -----------------------------
DATABASES = {
    "default": {
        "ENGINE": "django.db.backends.sqlite3",
        "NAME": BASE_DIR / "db.sqlite3",
    }
}

# -----------------------------
# Validação de senhas
# -----------------------------
AUTH_PASSWORD_VALIDATORS = [
    {
        "NAME": "django.contrib.auth.password_validation.UserAttributeSimilarityValidator"
    },
    {"NAME": "django.contrib.auth.password_validation.MinimumLengthValidator"},
    {"NAME": "django.contrib.auth.password_validation.CommonPasswordValidator"},
    {"NAME": "django.contrib.auth.password_validation.NumericPasswordValidator"},
]

# -----------------------------
# Internacionalização
# -----------------------------
LANGUAGE_CODE = "en-us"
TIME_ZONE = "UTC"
USE_I18N = True
USE_TZ = True

# -----------------------------
# Arquivos estáticos
# -----------------------------
STATIC_URL = "static/"
DEFAULT_AUTO_FIELD = "django.db.models.BigAutoField"

# -----------------------------
# Configuração DRF para suportar ambos JWT + Key
# -----------------------------
REST_FRAMEWORK = {
    "DEFAULT_AUTHENTICATION_CLASSES": (
        "rest_framework.authentication.TokenAuthentication",
        "rest_framework_simplejwt.authentication.JWTAuthentication",
    ),
    "DEFAULT_PERMISSION_CLASSES": ("rest_framework.permissions.IsAuthenticated",),
}

# -----------------------------
# Serializer customizado para registro
# -----------------------------
REST_AUTH_REGISTER_SERIALIZERS = {
    "REGISTER_SERIALIZER": "users.serializers.CustomRegisterSerializer",
}

# -----------------------------
# Configurações Simple JWT
# -----------------------------
SIMPLE_JWT = {
    "ACCESS_TOKEN_LIFETIME": timedelta(minutes=30),
    "REFRESH_TOKEN_LIFETIME": timedelta(days=1),
    "ROTATE_REFRESH_TOKENS": True,
    "BLACKLIST_AFTER_ROTATION": True,
}

# -----------------------------
# Configuração mínima do allauth
# -----------------------------
SITE_ID = 1
ACCOUNT_EMAIL_REQUIRED = True
ACCOUNT_USERNAME_REQUIRED = True
ACCOUNT_AUTHENTICATION_METHOD = "email"
ACCOUNT_EMAIL_VERIFICATION = "none"
