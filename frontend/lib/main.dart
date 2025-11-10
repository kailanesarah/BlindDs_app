import 'package:blindds_app/providers/auth/login_with_google_provider.dart';
import 'package:blindds_app/providers/session/load_session_provider.dart';
import 'package:blindds_app/providers/session/register_session_provider.dart';
import 'package:blindds_app/providers/auth/login_provider.dart';
import 'package:blindds_app/providers/auth/register_provider.dart';
import 'package:blindds_app/services/login_google_service.dart';
import 'package:blindds_app/services/login_service.dart';
import 'package:blindds_app/services/register_service.dart';
import 'package:blindds_app/routes/app_routes.dart';
import 'package:blindds_app/routes/app_pages_routes.dart';
import 'package:blindds_app/ui/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await dotenv.load(fileName: ".env");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RegisterSessionProvider()),
        ChangeNotifierProvider(
          create: (_) {
            final provider = LoadSessionProvider();
            provider.loadSession();
            return provider;
          },
        ),
        ChangeNotifierProxyProvider<RegisterSessionProvider, LoginProvider>(
          create: (context) => LoginProvider(
            loginService: LoginService(),
            registerSessionProvider: context.read<RegisterSessionProvider>(),
          ),
          update: (_, registerSessionProvider, __) => LoginProvider(
            loginService: LoginService(),
            registerSessionProvider: registerSessionProvider,
          ),
        ),
        ChangeNotifierProxyProvider<
          RegisterSessionProvider,
          LoginGoogleProvider
        >(
          create: (context) => LoginGoogleProvider(
            loginGoogleService: LoginGoogleService(),
            registerSessionProvider: context.read<RegisterSessionProvider>(),
          ),
          update: (_, registerSessionProvider, __) => LoginGoogleProvider(
            loginGoogleService: LoginGoogleService(),
            registerSessionProvider: registerSessionProvider,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => RegisterProvider(registerService: RegisterService()),
        ),
      ],
      child: MaterialApp(
        title: 'BlindDs',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.bluePrimary),
          useMaterial3: true,
        ),

        // 🔹 ESSA É A PARTE QUE FAZ O ZOOM FUNCIONAR
        builder: (context, child) {
          final mediaQuery = MediaQuery.of(context);
          return MediaQuery(
            data: mediaQuery.copyWith(
              textScaler: mediaQuery.textScaler.clamp(
                minScaleFactor: 0.8,
                maxScaleFactor: 2.0,
              ),
            ),
            child: child!,
          );
        },

        initialRoute: AppRoutes.home,
        routes: AppRoutePages.routes,
      ),
    );
  }
}
