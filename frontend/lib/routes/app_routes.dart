class AppRoutes {
  // ---------- Public / Inicial ----------
  static const String home = '/home';

  // ---------- Auth ----------
  static const String login = '/auth/login';
  static const String register = '/auth/register';

  // ---------- User ----------
  static const String userHome = '/user/home';
  static const String userProfile = '/user/profile';
  static const String userMood = '/user/mood';

  // ---------- Activities ----------
  static const String activityCode = '/user/activity/code';
  static const String activityHistory = '/user/activity/history';

  // ---------- Classrooms ----------
  static const String classroomsList = '/classrooms'; // lista de salas
  static const String classroomDetails =
      '/classrooms/details'; // detalhes de uma sala
  static const String classroomView = '/classrooms/view'; // sala aberta

  // ---------- Classrooms Decision ----------
  static const String studentClassroomsDecision = '/user/classrooms/decision';
}
