import 'package:project/data/model/task.dart';

class User {
  late int? id;
  late String? username;
  late String? firstname;
  late String? lastname;
  late String? country;
  late List<Task>? tasks;

  User({this.username,this.firstname, this.lastname,this.country, this.id,this.tasks});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int?,
      username: json['username'] as String?,
      firstname: json['firstname'] as String?,
      lastname: json['lastname'] as String?,
      country: json['country'] as String?,
      tasks: json['tasks'] != null
        ? List<Task>.from(json['tasks'].map((taskJson) => Task.fromJson(taskJson)))
          :[],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'firstname': firstname,
      'lastname': lastname,
      'country': country,
      'tasks': tasks?.map((task) => task.toJson()).toList(),
    };
  }
}