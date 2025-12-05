import 'package:blindds_app/data/datasources/remote/classroom/validate_code_remote_datasource.dart';

class ValidateCodeRepository {
  final ValidateCodeDataSource _remoteDataSource;

  ValidateCodeRepository({required ValidateCodeDataSource remoteDataSource})
    : _remoteDataSource = remoteDataSource;

  Future<bool> verifyClassroomCode({required String code}) async {
    final rawData = await _remoteDataSource.validateCode(code: code);

    if (rawData.data['added_to_classroom'] == false) {
      return false;
    }
    return true;
  }
}
