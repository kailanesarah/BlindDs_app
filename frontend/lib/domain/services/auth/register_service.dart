import 'package:blindds_app/data/repository/auth/register_repository.dart';

class RegisterService {
  final RegisterRepository _repository;

  RegisterService({required RegisterRepository repository})
    : _repository = repository;

  Future<bool> register({
    required String name,
    required String email,
    required String password,
    required String userType,
  }) async {
    return await _repository.register(
      name: name,
      email: email,
      password: password,
      userType: userType,
    );
  }
}
