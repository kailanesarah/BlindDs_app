import 'package:blindds_app/data/datasources/remote/auth/register_remote_datasource.dart';
import 'package:blindds_app/utils/helpers/dio_error_helper.dart';
import 'package:blindds_app/utils/helpers/generic_error_helper.dart';
import 'package:dio/dio.dart';


class RegisterRepository {
  final RegisterRemoteDataSource _remote;

  RegisterRepository({required RegisterRemoteDataSource remote})
    : _remote = remote;

  Future<bool> register({
  required String name,
  required String email,
  required String password,
  required String userType,
}) async {
  try {

    final response = await _remote.registerUser(
      name: name,
      email: email,
      password: password,
      userType: userType,
    );

    return response.statusCode == 200 || response.statusCode == 201;

  } on DioException catch (e) {
    throw Exception(DioErrorHelper.handle(e));
  } catch (e) {
    throw Exception(GenericErrorHelper.handle(e));
  }
}

}
