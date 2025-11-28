import 'package:blindds_app/controllers/login_controller.dart';
import 'package:blindds_app/controllers/login_google_controller.dart';
import 'package:blindds_app/controllers/register_controller.dart';
import 'package:blindds_app/controllers/token_controller.dart';
import 'package:blindds_app/controllers/validate_code_controller.dart';
import 'package:blindds_app/database/app_database.dart';
import 'package:blindds_app/database/datasources/homework_local_datasource.dart';

import 'package:blindds_app/providers/auth/login_provider.dart';
import 'package:blindds_app/providers/auth/login_with_google_provider.dart';
import 'package:blindds_app/providers/auth/register_provider.dart';
import 'package:blindds_app/providers/login_buttons_provider.dart';
import 'package:blindds_app/providers/theme/theme_provider.dart';
import 'package:blindds_app/providers/classroom/validate_code_provider.dart';

import 'package:blindds_app/services/api_client.dart';
import 'package:blindds_app/services/auth/login_service.dart';
import 'package:blindds_app/services/auth/login_google_service.dart';
import 'package:blindds_app/services/auth/login_firebase_service.dart';
import 'package:blindds_app/services/auth/register_service.dart';
import 'package:blindds_app/services/classroom/validate_code_service.dart';

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

  // Inicializa o banco Drift
  final db = AppDatabase();

  // Inicializa o TokenController (já cria Dio, RefreshService e ApiClient)
  final tokenController = TokenController(db: db);

  runApp(MyApp(
    tokenController: tokenController,
    apiClient: tokenController.apiClient,
    db: db,
  ));
}

class MyApp extends StatelessWidget {
  final TokenController tokenController;
  final ApiClient apiClient;
  final AppDatabase db;

  const MyApp({
    super.key,
    required this.tokenController,
    required this.apiClient,
    required this.db,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginButtonsProvider()),

        /// LOGIN COM EMAIL/SENHA
        ChangeNotifierProvider<LoginProvider>(
          create: (_) {
            final loginService = LoginService();
            final controller = LoginController(
              loginService: loginService,
              tokenController: tokenController,
            );
            final provider = LoginProvider(controller: controller);
            Future.microtask(() => provider.loadSession());
            return provider;
          },
        ),

        /// LOGIN COM GOOGLE
        ChangeNotifierProvider<LoginGoogleProvider>(
          create: (_) {
            final firebaseService = LoginFirebaseService();
            final googleService = LoginGoogleService();
            final controller = LoginGoogleController(
              firebaseService: firebaseService,
              googleService: googleService,
              tokenController: tokenController,
            );
            final provider = LoginGoogleProvider(controller: controller);
            Future.microtask(() => provider.loadSession());
            provider.init();
            return provider;
          },
        ),

        /// CADASTRO
        ChangeNotifierProvider<RegisterProvider>(
          create: (_) {
            final service = RegisterService(apiClient);
            final controller = RegisterController(service: service);
            return RegisterProvider(controller: controller);
          },
        ),

        /// VALIDAÇÃO DO CÓDIGO
        ChangeNotifierProvider<ValidateCodeProvider>(
          create: (_) {
            final service = ValidateCodeService(apiClient);
            final controller = ValidateCodeController(
              service: service,
              local: ClassroomLocalDataSource(db),
            );
            return ValidateCodeProvider(controller: controller);
          },
        ),

        /// TEMA
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
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
