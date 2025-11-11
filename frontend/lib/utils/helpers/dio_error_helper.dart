import 'package:dio/dio.dart';

class DioErrorHelper {
  static String handle(DioException e) {
    if (e.response != null) {
      final data = e.response?.data;

      if (data is Map<String, dynamic>) {
        return data['detail'] ??
            data['error'] ??
            data['message'] ??
            'Ocorreu um erro inesperado.';
      }

      if (data is String) {
        return data;
      }

      return 'Erro desconhecido do servidor (${e.response?.statusCode}).';
    }

    // Conexão
    if (e.type == DioExceptionType.connectionError) {
      return 'Sem conexão com a internet.';
    }

    // Timeout
    if (e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout) {
      return 'Tempo de conexão esgotado. Verifique sua internet.';
    }

    // Cancelado
    if (e.type == DioExceptionType.cancel) {
      return 'Requisição cancelada.';
    }

    return 'Erro inesperado. Tente novamente mais tarde.';
  }
}
