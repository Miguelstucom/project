import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

import '../model/task.dart';
import '../model/user.dart';

class UserProvider with ChangeNotifier {
  User? _user;

  User? get user => _user;

  Future<void> loadUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userJson = prefs.getString('user');

    if (userJson != null) {
      _user = User.fromJson(json.decode(userJson));
    } else {
      _user = User();
      prefs.setString('user', json.encode(_user?.toJson()));
    }

    notifyListeners();
  }
  void setUser(User? user) {
    _user = user;
    notifyListeners();
  }
  Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    await prefs.remove('user');
    _user = null;
    notifyListeners();
  }

  Future<void> saveTask(Task task) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userJson = prefs.getString('user');

    if (userJson != null) {
      final Map<String, dynamic> userMap = json.decode(userJson);
      final User user = User.fromJson(userMap);
      user.tasks = user.tasks ?? [];
      user.tasks?.add(task);
      await prefs.setString('user', json.encode(user.toJson()));
      notifyListeners();
      print('Task added and user updated');
    } else {
      print('No user found in SharedPreferences');
    }
  }

  Future<void> removeTask(Task task) async {
    if (_user != null) {
      _user!.tasks = _user!.tasks ?? [];
      _user!.tasks!.remove(task);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('user', json.encode(_user!.toJson()));
      notifyListeners();
    }
  }
  Future<void> saveSubTask(Task parentTask, Task subtask) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userJson = prefs.getString('user');

    if (userJson != null) {
      final Map<String, dynamic> userMap = json.decode(userJson);
      final User user = User.fromJson(userMap);
      user.tasks = user.tasks ?? [];
      for (var task in user.tasks!) {
        if (task.name == parentTask.name &&
            task.description == parentTask.description &&
            task.dueDate == parentTask.dueDate &&
            task.creationDate == parentTask.creationDate &&
            task.state == parentTask.state) {
          task.tasks = task.tasks ?? [];
          task.tasks?.add(subtask);
          break;
        }
      }

      await prefs.setString('user', json.encode(user.toJson()));
      print('Subtask added and user updated');
    } else {
      print('No user found in SharedPreferences');
    }
  }


}