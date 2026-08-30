import 'dart:convert';

import '../api/api_exception.dart';
import '../api/auth_api.dart';

class AuthService {
  final AuthApi _authApi;

  AuthService({AuthApi? authApi}) : _authApi = authApi ?? AuthApi();

  Future<Map<String, dynamic>> login({
    required String registration,
    required String password,
  }) async {
    final response = await _authApi.login(
      registration: registration,
      password: password,
    );

    if (response.statusCode == 200) {
      if (response.body.isEmpty) return <String, dynamic>{};
      final decoded = jsonDecode(response.body);
      if (decoded is Map<String, dynamic>) return decoded;
      return <String, dynamic>{'data': decoded};
    }

    if (response.statusCode == 422) {
      throw ApiException(_parseValidationError(response.body));
    }

    if (response.statusCode == 401 || response.statusCode == 403) {
      throw const ApiException('Matrícula ou senha inválidos.');
    }

    if (response.statusCode == 404) {
      throw const ApiException('Usuário não encontrado.');
    }

    throw ApiException(
      'Erro ao entrar (código ${response.statusCode}). Tente novamente.',
    );
  }

  String _parseValidationError(String body) {
    try {
      final decoded = jsonDecode(body);
      final detail = decoded is Map ? decoded['detail'] : null;
      if (detail is List && detail.isNotEmpty) {
        final messages = detail
            .map((e) => e is Map ? e['msg']?.toString() : null)
            .whereType<String>()
            .toList();
        if (messages.isNotEmpty) return messages.join('\n');
      }
    } catch (_) {
      // ignore parsing errors and fall through to the default message
    }
    return 'Verifique os dados informados e tente novamente.';
  }
}
