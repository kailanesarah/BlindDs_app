from classroom.models import ClassroomModel
from django.contrib import admin


@admin.register(ClassroomModel)
class ClassroomAdmin(admin.ModelAdmin):
    list_display = (
        "name",
        "code",
        "professor",
        "status",
        "created_at",
    )

    list_display_links = ("name",)

    search_fields = (
        "name",
        "code",
        "professor__username",
    )

    list_filter = (
        "status",
        "created_at",
        "professor",
    )

    readonly_fields = ("id", "code", "created_at", "updated_at")

    fieldsets = (
        (
            "Identificação",
            {
                "fields": ("id", "code"),
            },
        ),
        (
            "Informações da Sala",
            {
                "fields": ("name", "description", "status"),
            },
        ),
        (
            "Professor e Alunos",
            {
                "fields": ("professor", "students"),
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
