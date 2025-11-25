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

  /// -------------------------------
  /// 🔍 VALIDAR CÓDIGO
  /// -------------------------------
  Future<Map<String, dynamic>> validateCode(String code) async {
    log("🔵 [CONTROLLER] Iniciando validação do código: $code");
    log("🔵 Service: $_service");
    log("🔵 Hash do Dio dentro do service: ${_service.apiClient.dio.hashCode}");

    try {
      final response = await _service.validateCode(code: code);

      log("🟢 [CONTROLLER] StatusCode: ${response.statusCode}");
      log("🟢 [CONTROLLER] Response.data: ${response.data}");

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
      log("🔴 [CONTROLLER] DioException: ${e.message}");
      throw Exception(DioErrorHelper.handle(e));

    } catch (e) {
      log("🔴 [CONTROLLER] Erro genérico: $e");
      throw Exception(GenericErrorHelper.handle(e));
    }
  }

  /// -------------------------------
  /// 💾 SALVAR DADOS LOCALMENTE
  /// -------------------------------
  Future<void> saveClassroomData({
    required String code,
    required String name,
    required String description,
    required String id,
  }) async {
    log("🟡 [CONTROLLER] Salvando dados da sala localmente...");
    await local.saveClassroom(
      code: code,
      name: name,
      description: description,
      id: id,
    );
    log("🟢 [CONTROLLER] Dados salvos com sucesso!");
  }

  /// -------------------------------
  /// 📦 RECUPERAR DADOS DO DRIFT
  /// -------------------------------
  Future<Map<String, dynamic>> getClassroomData() async {
    log("🔵 [CONTROLLER] Buscando dados da sala localmente...");
    return await local.getClassroom();
  }

  /// -------------------------------
  /// 🧹 LIMPAR DADOS DO DRIFT
  /// -------------------------------
  Future<void> clearClassroomData() async {
    log("🟠 [CONTROLLER] Limpando dados locais da sala...");
    await local.clear();
  }
}
