from django.urls import path

from homework.views import (
    HomeworkCreateView,
    HomeworkListView,
    HomeworkRetrieveView,
    HomeworkUpdateView,
    HomeworkDeleteView,
    HomeworkSearchView,
)


urlpatterns = [
    path(
        "homework/validate_code/",
        HomeworkSearchView.as_view(),
        name="homework_validate_code",
    ),
    path("homework/", HomeworkCreateView.as_view(), name="homework_create"),
    path("homework/", HomeworkListView.as_view(), name="homework_list"),
    path("homework/<int:pk>/", HomeworkRetrieveView.as_view(), name="homework_detail"),
    path(
        "homework/<int:pk>/update/",
        HomeworkUpdateView.as_view(),
        name="homework_update",
    ),
    path(
        "homework/<int:pk>/delete/",
        HomeworkDeleteView.as_view(),
        name="homework_delete",
    ),
]
