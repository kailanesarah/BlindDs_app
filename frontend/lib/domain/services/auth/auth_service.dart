import 'package:blindds_app/data/repository/auth_google_repository.dart';
import 'package:blindds_app/data/repository/auth_repository.dart';
import 'package:blindds_app/domain/entities/user_entity.dart';

class AuthService {
  final AuthRepository _repository;
  final AuthGoogleRepository _googleRepository;

  AuthService(this._repository, this._googleRepository);

  Future<UserEntity> signIn(String email, String password) async {
    final user = await _repository.login(email, password);
    return user;
  }

  Future<UserEntity> signInWithGoogle() async {
    final user = await _googleRepository.loginWithGoogle();
    return user;
  }

  Future<UserEntity?> getCurrentUser() async {
    return _repository.getUser();
  }

  Future<void> signOut() async {
    await _repository.clearUserData();
  }
}
