import 'dart:convert';
import 'package:blindds_app/services/homework/validate_code_service.dart';
import 'package:blindds_app/utils/helpers/dio_error_helper.dart';
import 'package:blindds_app/utils/helpers/generic_error_helper.dart';
import 'package:dio/dio.dart';

class ValidateCodeController {
  final ValidateCodeService _service;

  ValidateCodeController({required ValidateCodeService service})
      : _service = service;

  Future<Map<String, dynamic>> validateCode(String code) async {
    try {
      final response = await _service.validateCode(atvCode: code);

      if (response.statusCode == 200) {
        final rawData = response.data is Map
            ? response.data
            : jsonDecode(response.data);

        // Extrai apenas o conteúdo de "data"
        final activityData = rawData['data'];

        if (activityData == null) {
          throw Exception("Erro interno: dados da atividade não encontrados.");
        }

        // Retorna os campos que vamos usar no provider
        return {
          "atv_code": activityData['atv_code']?.toString() ?? code,
          "atv_name": activityData['atv_name'] ?? "Atividade",
          "atv_description": activityData['atv_description'] ?? "Sem descrição",
          "atv_deadline": activityData['atv_deadline'] ?? "Sem prazo",
        };
      } else {
        final errorData = response.data is Map
            ? response.data
            : jsonDecode(response.data);

        throw Exception(errorData['message'] ?? "Código inválido");
      }
    } on DioException catch (e) {
      throw Exception(DioErrorHelper.handle(e));
    } catch (e) {
      throw Exception(GenericErrorHelper.handle(e));
    }
  }
}
