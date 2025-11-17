from django.contrib import admin
from homework.models import HomeworkModel


@admin.register(HomeworkModel)
class HomeworkAdmin(admin.ModelAdmin):
    list_display = (
        "atv_code",
        "atv_name",
        "user",
        "atv_created_at",
        "atv_updated_at",
    )

    list_display_links = ("atv_code", "atv_name")

    search_fields = ("atv_code", "atv_name", "user__username")

    list_filter = ("atv_created_at", "user")

    readonly_fields = ("atv_id", "atv_code", "atv_created_at", "atv_updated_at")

    fieldsets = (
        ("Identificação", {"fields": ("atv_id", "atv_code")}),
        ("Informações da Atividade", {"fields": ("atv_name", "atv_description")}),
        ("Usuário Responsável", {"fields": ("user",)}),
        ("Datas", {"fields": ("atv_created_at", "atv_updated_at")}),
    )

    # Ordenação padrão
    ordering = ("-atv_created_at",)
