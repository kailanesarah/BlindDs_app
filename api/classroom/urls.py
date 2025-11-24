from django.urls import path
from classroom.views import (
    ClassroomSearchView,
    ClassroomListView,
    ClassroomRetrieveView,
    ClassroomCreateView,
    ClassroomUpdateView,
    ClassroomDeleteView,
)

urlpatterns = [
    path("classroom/", ClassroomCreateView.as_view(), name="classroom_create"),
    path("classroom/list/", ClassroomListView.as_view(), name="classroom_list"),
    path(
        "classroom/<uuid:pk>/", ClassroomRetrieveView.as_view(), name="classroom_detail"
    ),
    path(
        "classroom/<uuid:pk>/update/",
        ClassroomUpdateView.as_view(),
        name="classroom_update",
    ),
    path(
        "classroom/<uuid:pk>/delete/",
        ClassroomDeleteView.as_view(),
        name="classroom_delete",
    ),
    path(
        "classroom/validate-code/",
        ClassroomSearchView.as_view(),
        name="classroom_search",
    ),
]
