from django.urls import path
from homework.views import (
    HomeworkCreateView,
    HomeworkListView,
    HomeworkRetrieveView,
    HomeworkUpdateView,
    HomeworkDeleteView,
)

urlpatterns = [
    path(
        "homework/<uuid:classroom_id>/",
        HomeworkCreateView.as_view(),
        name="homework_create",
    ),
    path(
        "homework/list/",
        HomeworkListView.as_view(),
        name="homework_list",
    ),
    path(
        "homework/<uuid:pk>/detail/",
        HomeworkRetrieveView.as_view(),
        name="homework_detail",
    ),
    path(
        "homework/<uuid:pk>/update/",
        HomeworkUpdateView.as_view(),
        name="homework_update",
    ),
    path(
        "homework/<uuid:pk>/delete/",
        HomeworkDeleteView.as_view(),
        name="homework_delete",
    ),
]
