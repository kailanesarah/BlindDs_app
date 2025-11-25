import 'dart:convert';
import 'dart:developer';

import 'package:blindds_app/database/datasources/homework_local_datasource.dart';
import 'package:blindds_app/services/classroom/validate_code_service.dart';
import 'package:blindds_app/utils/helpers/dio_error_helper.dart';
import 'package:blindds_app/utils/helpers/generic_error_helper.dart';
import 'package:dio/dio.dart';

class ValidateCodeController {
  final ValidateCodeService _service;
  final ClassroomLocalDataSource local;

  ValidateCodeController({
    required ValidateCodeService service,
    required this.local,
  }) : _service = service;

  Future<Map<String, dynamic>> validateCode(String code) async {
    try {
      final response = await _service.validateCode(code: code);

      if (response.statusCode != 200) {
        final errorData = (response.data is Map)
            ? response.data
            : jsonDecode(response.data);

        throw Exception(errorData['message'] ?? "Código inválido");
      }

      final rawData = response.data is Map
          ? response.data
          : jsonDecode(response.data);

      final classroom = rawData['classroom'];

      if (classroom == null) {
        throw Exception("Erro interno: dados da sala de aula não encontrados.");
      }

      return {
        "id": classroom['id'],
        "code": classroom['code'],
        "name": classroom['name'],
        "description": classroom['description'],
      };

    } on DioException catch (e) {
      throw Exception(DioErrorHelper.handle(e));

    } catch (e) {
      throw Exception(GenericErrorHelper.handle(e));
    }
  }

  Future<void> saveClassroomData({
    required String code,
    required String name,
    required String description,
    required String id,
  }) async {
    await local.saveClassroom(
      code: code,
      name: name,
      description: description,
      id: id,
    );
  }
  Future<Map<String, dynamic>> getClassroomData() async {
    return await local.getClassroom();
  }

  Future<void> clearClassroomData() async {
    await local.clear();
  }
}
