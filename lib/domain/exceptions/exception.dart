import 'dart:io';

class NetworkException implements Exception {
  final String message;
  NetworkException([this.message = "Sem conexão com a internet."]);

  @override
  String toString() {
    return message;
  }
}

class BadRequestException implements Exception {
  final String message;
  BadRequestException(
      [this.message = "Erro ao processar resposta do servidor."]);
  @override
  String toString() {
    return message;
  }
}

class UnauthorizedException implements Exception {
  final String message;
  UnauthorizedException([this.message = "Tempo limite de conexão excedido."]);
  @override
  String toString() {
    return message;
  }
}

class ServerException implements Exception {
  final String message;
  ServerException(Object e) : message = "Erro inesperado: $e";
  @override
  String toString() {
    return message;
  }
}

Exception handleHttpError(int statusCode) {
  switch (statusCode) {
    case 400:
      return BadRequestException(
        "Dados inválidos. Verifique suas credenciais.",
      );
    case 401:
      return UnauthorizedException(
        "Usuário ou senha incorretos.",
      );
    case 500:
      return ServerException(
        "Erro interno no servidor. Tente novamente mais tarde.",
      );
    default:
      return HttpException("Erro desconhecido: $statusCode");
  }
}
