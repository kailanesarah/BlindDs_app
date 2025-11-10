class GenericErrorHelper {
  static String handle(Object e) {
    if (e is FormatException) return 'Erro ao processar os dados.';
    if (e is TypeError) return 'Erro de tipo inesperado.';
    if (e.toString().contains('SocketException')) {
      return 'Falha de rede. Verifique sua conexão.';
    }
    return 'Erro inesperado: ${e.toString()}';
  }
}
