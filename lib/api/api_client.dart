import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'api_config.dart';
import 'api_exception.dart';

class ApiClient {
  Future<http.Response> post(
    String path, {
    Map<String, dynamic>? body,
    Duration timeout = const Duration(seconds: 15),
  }) async {
    final uri = Uri.parse('${ApiConfig.baseUrl}$path');

    try {
      return await http
          .post(
            uri,
            headers: const {'Content-Type': 'application/json'},
            body: body != null ? jsonEncode(body) : null,
          )
          .timeout(timeout);
    } on SocketException {
      throw const ApiException(
        'Não foi possível conectar ao servidor. Verifique sua conexão.',
      );
    } on HttpException {
      throw const ApiException('Falha na comunicação com o servidor.');
    } catch (_) {
      throw const ApiException('Não foi possível conectar ao servidor.');
    }
  }
}
