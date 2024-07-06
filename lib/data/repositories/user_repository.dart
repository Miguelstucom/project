import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/task.dart';
import '../model/user.dart';
import '../provider/user_provider.dart';
import '../service/api_client.dart';
import 'package:provider/provider.dart';

class UserRepository {
  final ApiClient apiClient;

  UserRepository({required this.apiClient});

  Future<User> login(BuildContext context, String username, String password) async {
    final response = await apiClient.post(
      'auth/login',
      body: {'username': username, 'password': password},
    );

    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        final data = json.decode(response.body);
        final token = data['token'];
        final userMap = data['user'];
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', token);

        final user = User.fromJson(userMap);

        final tasksResponse = await apiClient.get('api/tasks/${user.id}');

        if (tasksResponse.statusCode == 200) {
          final tasksData = json.decode(tasksResponse.body);
          if (tasksData['tasks'] != null) {
            user.tasks = (tasksData['tasks'] as List)
                .map((task) => Task.fromJson(task))
                .toList();
          } else {
            print('No tasks found');
          }
        } else {
          print('Error loading tasks: ${tasksResponse.body}');
          throw Exception('Failed to load tasks');
        }
        await prefs.setString('user', json.encode(user.toJson()));

        final userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(user);

        return user;
      } else {
        throw Exception('Response body is empty');
      }
    } else {
      throw Exception('Failed to log in');
    }
  }



  Future<User?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('user');
    if (userData != null) {
      return User.fromJson(json.decode(userData));
    }
    return null;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    await prefs.remove('user');
  }
}
