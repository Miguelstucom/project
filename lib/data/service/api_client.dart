import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient {
  String baseUrl="http://localhost:8080/";
  final http.Client httpClient;

  ApiClient({required this.httpClient});

  Future<http.Response> get(String endpoint) async {
    final token = await _getToken();
    final response = await httpClient.get(
      Uri.parse('$baseUrl$endpoint'),
      headers: _headers(token),
    );
    return response;
  }

  Future<http.Response> post(String endpoint, {Map<String, String>? body}) async {
    final token = await _getToken();
    final response = await httpClient.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: _headers(token),
      body: body,
    );
    return response;
  }

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  Map<String, String> _headers(String? token) {
    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }
}
