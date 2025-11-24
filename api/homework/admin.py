from django.contrib import admin
from homework.models import HomeworkModel


@admin.register(HomeworkModel)
class HomeworkAdmin(admin.ModelAdmin):
    list_display = (
        "name",
        "user",
        "created_at",
        "updated_at",
    )

    list_display_links = ("name",)

    search_fields = ("name", "user__username")

    list_filter = ("created_at", "user")

    readonly_fields = ("id", "created_at", "updated_at")

    fieldsets = (
        (
            "Identificação",
            {
                "fields": ("id",),
            },
        ),
        (
            "Informações da Atividade",
            {
                "fields": ("name", "description", "deadline"),
            },
        ),
        (
            "Usuário e Sala",
            {
                "fields": ("user", "classroom"),
            },
        ),
        (
            "Datas",
            {
                "fields": ("created_at", "updated_at"),
            },
        ),
    )

    ordering = ("-created_at",)
