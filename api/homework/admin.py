from django.contrib import admin
from homework.models import HomeworkModel


@admin.register(HomeworkModel)
class HomeworkAdmin(admin.ModelAdmin):
    list_display = (
        "name",
        "professor",
        "classroom",
        "deadline",
        "created_at",
    )

    list_display_links = ("name",)

    search_fields = (
        "name",
        "professor__username",
        "classroom__name",
    )

    list_filter = (
        "created_at",
        "professor",
        "classroom",
        "deadline",
    )

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
            "Professor e Sala",
            {
                "fields": ("professor", "classroom"),
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
