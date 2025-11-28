import 'package:blindds_app/presentation/screens/private/activity_code_screen.dart';
import 'package:blindds_app/presentation/screens/private/activity_history_screen.dart';
import 'package:blindds_app/presentation/screens/public/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:blindds_app/routes/app_routes.dart';
import 'package:blindds_app/presentation/screens/public/welcome_screen.dart';
import 'package:blindds_app/presentation/screens/public/login_screen.dart';
import 'package:blindds_app/presentation/screens/private/mode_selection_screen.dart';

class AppRoutePages {
  static Map<String, WidgetBuilder> routes = {
    AppRoutes.home: (context) => const WelcomeScreen(),
    AppRoutes.login: (context) => const LoginScreen(),
    AppRoutes.register: (context) => const RegisterScreen(),
    AppRoutes.userMood: (context) => const ModeSelectionScreen(),
    AppRoutes.activityCode: (context) => const ActivityCodeScreen(),
  };
}
