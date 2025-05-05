// helper/todo_model.dart
class Todo {
  final String id;
  final String title;
  final String description;
  late final bool status;

  Todo({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "description": description,
      "is_completed": status,
      "is_deleted": false,
      "updated_at": DateTime.now().millisecondsSinceEpoch ~/ 1000,
      "creation": DateTime.now().millisecondsSinceEpoch ~/ 1000,
    };
  }
}
