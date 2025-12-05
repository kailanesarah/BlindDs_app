from classroom.views import (
    ClassroomCreateView,
    ClassroomDeleteView,
    ClassroomListView,
    ClassroomRetrieveView,
    ClassroomSearchView,
    ClassroomUpdateView,
    ListClassroomsByProfessorView,
    ListClassroomsByStudentView,
)
from django.urls import path

urlpatterns = [
    path("classroom/", ClassroomCreateView.as_view(), name="classroom_create"),
    path("classroom/list/", ClassroomListView.as_view(), name="classroom_list"),
    path(
        "classroom/student/list/",
        ListClassroomsByStudentView.as_view(),
        name="classroom_list_by_student",
    ),
    path(
        "classroom/professor/list/",
        ListClassroomsByProfessorView.as_view(),
        name="classroom_list_by_student",
    ),
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
