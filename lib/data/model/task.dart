class Task{
  late int? id;
  late String? description;
  late DateTime? creationDate;
  late DateTime? dueDate;

Task({this.id,this.description,this.creationDate,this.dueDate});

factory Task.fromJson(Map<String, dynamic> json){
  return Task(
    id: json['id'] as int?,
    description: json['description'] as String?,
    creationDate: DateTime.parse(json['creationDate']),
    dueDate: DateTime.parse(json['dueDate']),
  );
}

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'creationDate': creationDate,
      'dueDate': dueDate,
      'id': id,
    };
  }


}