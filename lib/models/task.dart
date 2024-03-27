import 'dart:convert';

class Task {
  String title;
  String description;
  DateTime deadline;

  Task({
    required this.title,
    required this.description,
    required this.deadline,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'deadline': deadline.toIso8601String(),
    };
  }

  factory Task.fromJson(String json) {
    Map<String, dynamic> map = jsonDecode(json);
    return Task(
      title: map['title'],
      description: map['description'],
      deadline: DateTime.parse(map['deadline']),
    );
  }
}
