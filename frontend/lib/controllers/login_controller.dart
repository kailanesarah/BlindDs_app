import 'package:blindds_app/controllers/token_controller.dart';
import 'package:blindds_app/services/auth/login_service.dart';
import 'package:blindds_app/utils/helpers/dio_error_helper.dart';
import 'package:blindds_app/utils/helpers/generic_error_helper.dart';
import 'package:dio/dio.dart';

class LoginController {
  final LoginService loginService;
  final TokenController tokenController;

  LoginController({
    required this.loginService,
    required this.tokenController,
  });

  /// Login via API e salva no Drift
  Future<void> login(String email, String password) async {
    try {
      final response = await loginService.loginUser(
        email: email,
        password: password,
      );

      final id = response.data['id']?.toString();
      final name = response.data['username'];
      final emailResp = response.data['email'];
      final userType = response.data['user_type'];
      final access = response.data['access'];
      final refresh = response.data['refresh'];

      if (id == null || access == null || refresh == null) {
        throw Exception("Login retornou dados inválidos");
      }

      await tokenController.local.saveUser(
        id: id,
        name: name ?? '',
        email: emailResp ?? '',
        userType: userType ?? '',
        access: access,
        refresh: refresh,
      );

      // Print para debug
      await printUserData();
    } on DioException catch (e) {
      throw Exception(DioErrorHelper.handle(e));
    } catch (e) {
      throw Exception(GenericErrorHelper.handle(e));
    }
  }

  /// Recupera dados do Drift
  Future<Map<String, String>> getUserData() async {
    final data = await tokenController.local.getUser(); // Map<String, String?>?

    if (data == null || data.isEmpty) {
      return {
        'id': '',
        'name': '',
        'email': '',
        'userType': '',
        'access': '',
        'refresh': '',
      };
    }

    return {
      'id': data['id'] ?? '',
      'name': data['name'] ?? '',
      'email': data['email'] ?? '',
      'userType': data['userType'] ?? '',
      'access': data['access'] ?? '',
      'refresh': data['refresh'] ?? '',
    };
  }

  /// Imprime dados no console
  Future<void> printUserData() async {
    final userData = await getUserData();
    if (userData['id']!.isEmpty) {
      print("Nenhum usuário encontrado no Drift");
      return;
    }

    print(
      "ID: ${userData['id']}, "
      "Name: ${userData['name']}, "
      "Email: ${userData['email']}, "
      "UserType: ${userData['userType']}, "
      "Access: ${userData['access']}, "
      "Refresh: ${userData['refresh']}"
    );
  }

  Future<void> updateTokens({required String access, String? refresh}) async {
    await tokenController.local.updateTokens(access: access, refresh: refresh);
  }

  Future<void> clearUserData() async {
    await tokenController.local.clear();
  }
}
