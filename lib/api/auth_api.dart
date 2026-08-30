import 'package:http/http.dart' as http;

import 'api_client.dart';

class AuthApi {
  final ApiClient _apiClient;

  AuthApi({ApiClient? apiClient}) : _apiClient = apiClient ?? ApiClient();

  Future<http.Response> login({
    required String registration,
    required String password,
  }) {
    return _apiClient.post(
      '/users/login',
      body: {'registration': registration, 'password': password},
    );
  }
}
