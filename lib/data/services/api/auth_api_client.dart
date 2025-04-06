import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:gymtrack/data/services/api/model/login_request_model.dart';
import 'package:gymtrack/data/services/api/model/signup_request_model.dart';
import 'package:gymtrack/data/services/api/model/token_api_model.dart';
import 'package:gymtrack/domain/exceptions/exception.dart';
import 'package:result_dart/result_dart.dart';

class AuthApiClient {
  AuthApiClient({
    String? host,
    int? port,
    HttpClient Function()? clientFactory,
  })  : _host = host ?? 'localhost',
        _port = port ?? 3000,
        _clientFactory = clientFactory ?? (() => HttpClient());

  final String _host;
  final int _port;
  final HttpClient Function() _clientFactory;

  Future<Result> signup(SignupRequestModel data) async {
    final client = _clientFactory();

    try {
      final req = await client.post(_host, _port, "/user");
      req.headers.set(
        HttpHeaders.contentTypeHeader,
        'application/json; charset=utf-8',
      );
      req.headers.set(
        HttpHeaders.acceptHeader,
        'application/json; charset=utf-8',
      );
      req.add(utf8.encode(jsonEncode(data.toJson())));

      final res = await req.close();

      if (res.statusCode == 201) {
        return Success.unit();
      } else {
        return Failure(HttpException(""));
      }
    } catch (e) {
      return Failure(Exception(e));
    } finally {
      client.close();
    }
  }

  Future<Result<T>> makeRequest<T extends Object>(
      Future<Result<T>> Function(HttpClient client) func) async {
    final client = _clientFactory();

    try {
      return await func(client);
    } on SocketException {
      return Failure(NetworkException());
    } on FormatException {
      return Failure(FormatException());
    } on TimeoutException {
      return Failure(TimeoutException("Tempo limite de conexão excedido."));
    } catch (e) {
      return Failure(Exception(e));
    } finally {
      client.close();
    }
  }

  Future<Result<String>> login(LoginRequestModel data) async {
    return makeRequest<String>((client) async {
      final req = await client.post(_host, _port, "/user/login");
      req.headers.set(
          HttpHeaders.contentTypeHeader, 'application/json; charset=utf-8');
      req.headers
          .set(HttpHeaders.acceptHeader, 'application/json; charset=utf-8');
      req.add(utf8.encode(jsonEncode(data.toJson())));

      final res = await req.close();
      final stringData = await res.transform(utf8.decoder).join();

      if (res.statusCode == 201) {
        return Success(TokenApiModel.fromJson(jsonDecode(stringData)).token);
      }

      return Failure(handleHttpError(res.statusCode));
    });
  }
}
