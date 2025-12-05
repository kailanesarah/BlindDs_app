import 'package:blindds_app/presentation/screens/private/classroom_details_screen.dart';
import 'package:blindds_app/presentation/screens/private/classrooms_screen.dart';
import 'package:blindds_app/presentation/screens/private/student_classrooms_decision_screen.dart';
import 'package:flutter/material.dart';

import 'package:blindds_app/routes/app_routes.dart';

import 'package:blindds_app/presentation/screens/public/login_screen.dart';
import 'package:blindds_app/presentation/screens/public/register_screen.dart';
import 'package:blindds_app/presentation/screens/public/welcome_screen.dart';

import 'package:blindds_app/presentation/screens/private/user_home_screen.dart';
import 'package:blindds_app/presentation/screens/private/mode_selection_screen.dart';
import 'package:blindds_app/presentation/screens/private/activity_code_screen.dart';

class AppRoutePages {
  static Map<String, WidgetBuilder> routes = {
    // ---------- Auth ----------
    AppRoutes.login: (context) => const LoginScreen(),
    AppRoutes.register: (context) => const RegisterScreen(),

    // ---------- Public / Primeiro acesso ----------
    AppRoutes.home: (context) => const WelcomeScreen(),

    // ---------- User (área autenticada) ----------
    AppRoutes.userHome: (context) => const UserHomeScreen(),
    AppRoutes.userMood: (context) => const ModeSelectionScreen(),

    // ---------- Activities ----------
    AppRoutes.activityCode: (context) => const ActivityCodeScreen(),

    // ---------- Sala de aula ----------
    AppRoutes.classroomsList: (context) => const ClassroomsScreen(),
    AppRoutes.classroomDetails: (context) => const ClassroomDetailsScreen(),
    AppRoutes.studentClassroomsDecision: (context) =>
        const StudentClassroomsDecisionScreen(),
  };
}
