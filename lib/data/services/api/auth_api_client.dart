import 'dart:io';

class AuthApiClient {
  AuthApiClient({
    String? host,
    int? port,
    HttpClient Function()? clientFactory,
  })  : _host = host ?? 'localhost',
        _port = port ?? 8080,
        _clientFactory = clientFactory ?? (() => HttpClient());

  final String _host;
  final int _port;
  final HttpClient Function() _clientFactory;
}
