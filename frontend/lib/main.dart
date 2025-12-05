// -----------------------------------------------------------
// PACOTES FLUTTER / TERCEIROS
// -----------------------------------------------------------
import 'package:blindds_app/data/datasources/remote/classroom/classroom_remote_datasource.dart';
import 'package:blindds_app/data/datasources/remote/classroom/student_classrooms_remote_datasource.dart';
import 'package:blindds_app/data/repository/classroom/classroom_repository.dart';
import 'package:blindds_app/data/repository/classroom/student_classrooms_repository.dart';
import 'package:blindds_app/domain/services/classroom/classroom_service.dart';
import 'package:blindds_app/domain/services/classroom/student_classrooms_service.dart';
import 'package:blindds_app/presentation/providers/classroom/classroom_provider.dart';
import 'package:blindds_app/presentation/providers/classroom/student_classrooms_provider.dart';
import 'package:blindds_app/presentation/providers/classroom/student_classrooms_decision_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';

// -----------------------------------------------------------
// DATASOURCES REMOTOS
// -----------------------------------------------------------
import 'package:blindds_app/data/datasources/remote/api_client_remote_datasource.dart';
import 'package:blindds_app/data/datasources/remote/auth/auth_remote_datasource.dart';
import 'package:blindds_app/data/datasources/remote/auth/auth_google_remote_datasource.dart';
import 'package:blindds_app/data/datasources/remote/auth/auth_firebase_remote_datasource.dart';
import 'package:blindds_app/data/datasources/remote/auth/register_remote_datasource.dart';
import 'package:blindds_app/data/datasources/remote/classroom/validate_code_remote_datasource.dart';

// -----------------------------------------------------------
// DATASOURCES LOCAIS
// -----------------------------------------------------------
import 'package:blindds_app/data/datasources/local/app_database.dart';
import 'package:blindds_app/data/datasources/local/user/user_local_datasource.dart';
import 'package:blindds_app/data/datasources/local/classroom/classroom_local_datasource.dart';

// -----------------------------------------------------------
// REPOSITORIES
// -----------------------------------------------------------
import 'package:blindds_app/data/repository/auth/auth_repository.dart';
import 'package:blindds_app/data/repository/auth/auth_google_repository.dart';
import 'package:blindds_app/data/repository/auth/register_repository.dart';
import 'package:blindds_app/data/repository/classroom/validade_code_repository.dart';
import 'package:blindds_app/data/repository/auth/token_repository.dart';

// -----------------------------------------------------------
// SERVICES / DOMÍNIO
// -----------------------------------------------------------
import 'package:blindds_app/domain/services/auth/auth_service.dart';
import 'package:blindds_app/domain/services/auth/register_service.dart';
import 'package:blindds_app/domain/services/classroom/validate_code_service.dart';

// -----------------------------------------------------------
// PROVIDERS
// -----------------------------------------------------------
import 'package:blindds_app/presentation/providers/auth/login_provider.dart';
import 'package:blindds_app/presentation/providers/auth/register_provider.dart';
import 'package:blindds_app/presentation/providers/classroom/validate_code_provider.dart';
import 'package:blindds_app/presentation/providers/login_buttons_provider.dart';
import 'package:blindds_app/presentation/providers/theme/theme_provider.dart';

// -----------------------------------------------------------
// ROTAS
// -----------------------------------------------------------
import 'package:blindds_app/routes/app_routes.dart';
import 'package:blindds_app/routes/app_pages_routes.dart';

// -----------------------------------------------------------
// THEMES / UI
// -----------------------------------------------------------
import 'package:blindds_app/presentation/ui/style/theme/app_themes.dart';

// -----------------------------------------------------------
// CONFIGURAÇÕES FIREBASE
// -----------------------------------------------------------
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Inicializa o banco Drift
  final db = AppDatabase();
  final tokenRepository = TokenRepository(db: db);
  final apiClient = tokenRepository.apiClient;

  runApp(MyApp(tokenRepository: tokenRepository, apiClient: apiClient, db: db));
}

class MyApp extends StatelessWidget {
  final TokenRepository tokenRepository;
  final ApiClient apiClient;
  final AppDatabase db;

  const MyApp({
    super.key,
    required this.tokenRepository,
    required this.apiClient,
    required this.db,
  });

  @override
  Widget build(BuildContext context) {
    // -----------------------------
    // DATASOURCES
    // -----------------------------
    final userLocalDataSource = UserLocalDataSource(db);
    final authRemoteDataSource = AuthRemoteDataSource();
    final authGoogleRemoteDataSource = AuthGoogleRemoteDatasource();
    final authFirebaseRemoteDataSource = AuthFirebaseDataSource();

    // DATASOURCES CLASSROOM
    final classroomLocalDataSource = ClassroomLocalDataSource(db);
    final validateCodeDataSource = ValidateCodeDataSource(api: apiClient);
    final studentClassroomsRemoteDataSource = StudentClassroomsRemoteDataSource(
      api: apiClient,
    );
    final classroomRemoteDataSource = ClassroomRemoteDataSource(api: apiClient);

    // -----------------------------
    // REPOSITORIES
    // -----------------------------
    final authRepository = AuthRepository(
      remoteDataSource: authRemoteDataSource,
      localDataSource: userLocalDataSource,
    );

    final authGoogleRepository = AuthGoogleRepository(
      authFirebaseDataSource: authFirebaseRemoteDataSource,
      googleRemoteDataSource: authGoogleRemoteDataSource,
      localDataSource: userLocalDataSource,
    );

    final validateCodeRepository = ValidateCodeRepository(
      remoteDataSource: validateCodeDataSource,
    );

    final getStudentClassroomsRepository = StudentClassroomsRepository(
      remoteDataSource: studentClassroomsRemoteDataSource,
      localDataSource: classroomLocalDataSource,
    );

    final classroomRepository = ClassroomRepository(
      remoteDataSource: classroomRemoteDataSource,
      localDataSource: classroomLocalDataSource,
    );

    // -----------------------------
    // SERVICES (DOMÍNIO)
    // -----------------------------
    final authService = AuthService(authRepository, authGoogleRepository);
    final validateCodeService = ValidateCodeService(
      repository: validateCodeRepository,
    );
    final getStudentClassroomsService = StudentClassroomsService(
      repository: getStudentClassroomsRepository,
    );

    final classroomService = ClassroomService(repository: classroomRepository);

    // -----------------------------
    // MATERIAL APP WRAPPER
    // -----------------------------
    return MultiProvider(
      providers: [
        // PROVIDERS GERAIS
        ChangeNotifierProvider(create: (_) => LoginButtonsProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),

        // -----------------------------
        // AUTH
        // -----------------------------
        ChangeNotifierProvider<AuthProvider>(
          create: (_) {
            final provider = AuthProvider(authService: authService);
            Future.microtask(() => provider.init());
            return provider;
          },
        ),

        // -----------------------------
        // CADASTRO
        // -----------------------------
        ChangeNotifierProvider<RegisterProvider>(
          create: (_) {
            final registerRemoteDataSource = RegisterRemoteDataSource(
              apiClient,
            );
            final registerRepository = RegisterRepository(
              remote: registerRemoteDataSource,
            );
            final registerService = RegisterService(
              repository: registerRepository,
            );
            return RegisterProvider(service: registerService);
          },
        ),

        // -----------------------------
        // CLASSROOM
        // -----------------------------
        ChangeNotifierProvider<ValidateCodeProvider>(
          create: (_) => ValidateCodeProvider(service: validateCodeService),
        ),

        ChangeNotifierProvider<StudentClassroomsProvider>(
          create: (_) =>
              StudentClassroomsProvider(service: getStudentClassroomsService),
        ),

        ChangeNotifierProvider<StudentClassroomsDecisionProvider>(
          create: (_) => StudentClassroomsDecisionProvider(
            service: getStudentClassroomsService,
          ),
        ),
        ChangeNotifierProvider<ClassroomProvider>(
          create: (_) => ClassroomProvider(service: classroomService),
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
