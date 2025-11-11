import 'package:flutter_dotenv/flutter_dotenv.dart';

// Variáveis estáticas lidas APENAS UMA VEZ.
class AppConfig {
  static final String baseURL = dotenv.env['DJANGO_API_URL'] ?? '';
  AppConfig._();
}
