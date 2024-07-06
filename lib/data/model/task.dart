class Task {
  final String? name;
  final String description;
  final String dueDate;
  final String creationDate;
  final bool state;
  late List<Task>? tasks;

  Task({
    this.name,
    required this.description,
    required this.dueDate,
    required this.creationDate,
    required this.state,
    this.tasks,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      name: json['name'],
      description: json['description'],
      dueDate: json['dueDate'],
      creationDate: json['creationDate'],
      state: json['state'],
      tasks: json['tasks'] != null
          ? List<Task>.from(json['tasks'].map((taskJson) => Task.fromJson(taskJson)))
          :[],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'dueDate': dueDate,
      'creationDate': creationDate,
      'state': state,
      'tasks': tasks?.map((task) => task.toJson()).toList(),
    };
  }


}