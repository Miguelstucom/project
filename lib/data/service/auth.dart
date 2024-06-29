import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'api_client.dart';

class AuthRepo {
  final ApiClient apiClient;

  AuthRepo({required this.apiClient});

  Future<void> login(String username, String password) async {
    final response = await apiClient.post(
      '/login',
      body: {'username': username, 'password': password},
    );

    if (response.statusCode == 200) {
      final token = json.decode(response.body)['token'];
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', token);
    } else {
      throw Exception('Failed to log in');
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }
}