import 'package:validators/validators.dart' as v;

class Validators {
  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) return "Email obrigatório";
    if (!v.isEmail(email)) return "Email inválido";
    return null;
  }

  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) return "Senha obrigatória";
    if (password.length < 6) return "Senha muito curta";
    return null;
  }

  static String? validateUsername(String? username) {
    if (username == null || username.isEmpty) return "Nome obrigatório";
    if (username.length < 3) return "Nome muito curto";
    return null;
  }
}
