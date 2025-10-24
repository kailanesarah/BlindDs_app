import 'package:blindds_app/pages/private/activity_code_screen.dart';
import 'package:blindds_app/pages/public/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:blindds_app/routes/app_routes.dart';
import 'package:blindds_app/pages/public/welcome_screen.dart';
import 'package:blindds_app/pages/public/login_screen.dart';
import 'package:blindds_app/pages/private/mode_selection_screen.dart';


class AppRoutePages {
  static Map<String, WidgetBuilder> routes = {
    AppRoutes.home: (context) => const WelcomeScreen(),
    AppRoutes.login: (context) => const LoginScreen(),
    AppRoutes.register: (context) => const RegisterScreen(),
    AppRoutes.userMood: (contex) => const ModeSelectionScreen(),
    AppRoutes.activityCode: (contex) => const ActivityCodeScreen(),
  };
}
