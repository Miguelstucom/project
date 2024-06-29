class User {
  late String? name;
  late String? lastname;
  late int? id;

  User({this.name, this.lastname, this.id});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['username'] as String?,
      lastname: json['lastname'] as String?,
      id: json['id'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': name,
      'lastname': lastname,
      'id': id,
    };
  }
}