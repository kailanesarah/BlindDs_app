from datetime import timedelta
from pathlib import Path
from dotenv import load_dotenv
import os
import firebase_admin
from firebase_admin import credentials
import dj_database_url

load_dotenv()
DJANGO_AUTH_HOST = os.getenv("DJANGO_AUTH_HOST")
DJANGO_AUTH_ORIGIN = os.getenv("DJANGO_AUTH_ORIGIN")

BASE_DIR = Path(__file__).resolve().parent.parent
SECRET_KEY = "django-insecure-tm_^3s2*dgbcf&2=_=$ekyj4n_jdsbg9gzckb8g688savwn$!"
DEBUG = True

ALLOWED_HOSTS = [
    "localhost",
    "127.0.0.1",
    "10.0.2.2",
    os.getenv("DJANGO_AUTH_HOST"),
]

CSRF_TRUSTED_ORIGINS = [
    os.getenv("DJANGO_AUTH_ORIGIN"),
]

# Modelo customizado
AUTH_USER_MODEL = "users.CustomUser"

# -----------------------------
# Configurações do dj-rest-auth / JWT
# -----------------------------
REST_USE_JWT = True  # Habilita JWT


# -----------------------------
# Apps instaladas
# -----------------------------
INSTALLED_APPS = [
    "django.contrib.admin",
    "django.contrib.auth",
    "django.contrib.contenttypes",
    "django.contrib.sessions",
    "django.contrib.messages",
    "django.contrib.staticfiles",
    "users",
    "authentication",
    # DRF + autenticação
    "rest_framework",
    "rest_framework.authtoken",  # Mantém para Key
    "dj_rest_auth",
    "dj_rest_auth.registration",
    # Allauth
    "allauth",
    "allauth.account",
    "allauth.socialaccount",
    "allauth.socialaccount.providers.google",
    "corsheaders",
    "django.contrib.sites",
]

# -----------------------------
# Middleware
# -----------------------------
MIDDLEWARE = [
    "corsheaders.middleware.CorsMiddleware",
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
CORS_ALLOW_ALL_ORIGINS = True

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
if os.getenv(
    "RENDER"
):  # Ambiente de produção (Render define essa variável automaticamente)
    DATABASES = {
        "default": dj_database_url.config(
            default=os.getenv("DATABASE_URL"),
            conn_max_age=600,
        )
    }
else:
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
    "REGISTER_SERIALIZER": "authentication.serializers.CustomRegisterSerializer",
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


# settings.py

# -----------------------------
# Configurações do Social Account Google
# -----------------------------


FIREBASE_CREDENTIALS_PATH = os.path.join(BASE_DIR, "config", "serviceAccountKey.json")

if os.path.exists(FIREBASE_CREDENTIALS_PATH):
    cred = credentials.Certificate(FIREBASE_CREDENTIALS_PATH)
    firebase_admin.initialize_app(cred)
else:
    # Lógica para ambiente de produção (usando variáveis de ambiente, se necessário)
    pass
