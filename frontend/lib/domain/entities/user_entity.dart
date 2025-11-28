
import 'package:blindds_app/data/datasources/local/app_database.dart';

class UserEntity {
  final String id;
  final String email;
  final String username;
  final String userType;
  final String accessToken; 
  final String refreshToken;

  UserEntity({
    required this.id,
    required this.email,
    required this.username,
    required this.userType,
    required this.accessToken,
    required this.refreshToken,
  });

  @override
  String toString() {
  return 'UserEntity(id: $id, email: $email, username: $username, userType: $userType, access: $accessToken, refresh: $refreshToken)';
    }


  factory UserEntity.fromJson(json) {
    return UserEntity(
      id: json['id'] as String,
      email: json['email'] as String,
      username: json['username'] as String,
      userType:
          json['user_type']
              as String, 
      accessToken:
          json['access'] as String, 
      refreshToken:
          json['refresh'] as String, 
    );
    
  }

  factory UserEntity.fromDrift(UserData data) {
    return UserEntity(
      id: data.id,
      email: data.email,
      username: data.username,
      userType: data.userType,
      accessToken: data.access,
      refreshToken: data.refresh,
    );
  }
}
