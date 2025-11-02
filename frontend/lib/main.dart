import 'package:blindds_app/providers/session/load_session_provider.dart';
import 'package:blindds_app/providers/session/register_session_provider.dart';
import 'package:blindds_app/providers/auth/login_provider.dart';
import 'package:blindds_app/providers/auth/register_provider.dart';
import 'package:blindds_app/services/login_service.dart';
import 'package:blindds_app/services/register_service.dart';
import 'package:blindds_app/routes/app_routes.dart';
import 'package:blindds_app/routes/app_pages_routes.dart';
import 'package:blindds_app/ui/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RegisterSessionProvider>(
          create: (_) => RegisterSessionProvider(),
        ),

        ChangeNotifierProvider<LoadSessionProvider>(
          create: (_) {
            final provider = LoadSessionProvider();
            provider.loadSession(); // carrega a sessão ao iniciar
            return provider;
          },
        ),

        ChangeNotifierProvider<LoginProvider>(
          create: (context) => LoginProvider(
            loginService: LoginService(),
            registerSessionProvider: context.read<RegisterSessionProvider>(),
          ),
        ),

        ChangeNotifierProvider<RegisterProvider>(
          create: (_) => RegisterProvider(registerService: RegisterService()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.bluePrimary),
        ),
        initialRoute: AppRoutes.home,
        routes: AppRoutePages.routes,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
