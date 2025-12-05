import 'package:blindds_app/data/repository/classroom/validade_code_repository.dart';
import 'package:blindds_app/utils/helpers/dio_error_helper.dart';
import 'package:blindds_app/utils/helpers/generic_error_helper.dart';
import 'package:dio/dio.dart';

class ValidateCodeService {
  final ValidateCodeRepository _repository;

  ValidateCodeService({required ValidateCodeRepository repository})
    : _repository = repository;

  Future<bool> validateCode(String code) async {
    try {
      final classroom = await _repository.verifyClassroomCode(code: code);
      if (classroom == false) {
        return false;
      }
      return true;
    } on DioException catch (e) {
      throw Exception(DioErrorHelper.handle(e));
    } catch (e) {
      throw Exception(GenericErrorHelper.handle(e));
    }
  }
}
