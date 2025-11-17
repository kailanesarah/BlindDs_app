import 'package:blindds_app/controllers/login_controller.dart';
import 'package:blindds_app/controllers/login_google_controller.dart';
import 'package:blindds_app/controllers/register_controller.dart';
import 'package:blindds_app/controllers/validate_code_controller.dart';

import 'package:blindds_app/providers/auth/login_provider.dart';
import 'package:blindds_app/providers/auth/login_with_google_provider.dart';
import 'package:blindds_app/providers/auth/register_provider.dart';
import 'package:blindds_app/providers/login_buttons_provider.dart';
import 'package:blindds_app/providers/theme/theme_provider.dart';
import 'package:blindds_app/providers/homework/validate_code_provider.dart';

import 'package:blindds_app/services/auth/login_service.dart';
import 'package:blindds_app/services/auth/login_google_service.dart';
import 'package:blindds_app/services/auth/login_firebase_service.dart';
import 'package:blindds_app/services/auth/register_service.dart';
import 'package:blindds_app/services/homework/validate_code_service.dart';

import 'package:blindds_app/routes/app_pages_routes.dart';
import 'package:blindds_app/routes/app_routes.dart';
import 'package:blindds_app/ui/style/theme/app_themes.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [

        ChangeNotifierProvider(
  create: (_) => LoginButtonsProvider(),
),

        /// -------------------------------------
        /// LOGIN COM EMAIL/SENHA
        /// -------------------------------------
        ChangeNotifierProvider(
          create: (_) {
            final controller = LoginController(
              loginService: LoginService(),
            );
            final provider = LoginProvider(controller: controller);
            provider.loadSession(); 
            return provider;
          },
        ),

        /// -------------------------------------
        /// LOGIN COM GOOGLE
        /// -------------------------------------
        ChangeNotifierProvider(
          create: (_) {
            final controller = LoginGoogleController(
              firebaseService: LoginFirebaseService(),
              googleService: LoginGoogleService(),
            );
            final provider = LoginGoogleProvider(controller: controller);
            provider.loadSession();
            return provider;
          },
        ),

        /// -------------------------------------
        /// CADASTRO
        /// -------------------------------------
        ChangeNotifierProvider(
          create: (_) {
            final controller = RegisterController(service: RegisterService());
            return RegisterProvider(controller: controller);
          },
        ),

        /// -------------------------------------
        /// VALIDAÇÃO DO CÓDIGO
        /// -------------------------------------
        ChangeNotifierProvider(
          create: (_) {
            final controller =
                ValidateCodeController(service: ValidateCodeService());
            return ValidateCodeProvider(controller: controller);
          },
        ),

        /// -------------------------------------
        /// TEMA
        /// -------------------------------------
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ),
      ],

      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            title: 'BlindDs',
            theme: AppThemes.lightTheme,
            darkTheme: AppThemes.darkTheme,
            themeMode: themeProvider.themeMode,

            builder: (context, child) {
              final mq = MediaQuery.of(context);
              return MediaQuery(
                data: mq.copyWith(
                  textScaler: mq.textScaler.clamp(
                    minScaleFactor: 0.8,
                    maxScaleFactor: 2.0,
                  ),
                ),
                child: child!,
              );
            },

            initialRoute: AppRoutes.home,
            routes: AppRoutePages.routes,
          );
        },
      ),
    );
  }
}
