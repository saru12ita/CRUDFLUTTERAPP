// helper/api_helper.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'todo_model.dart';


const String baseUrl = "http://10.0.2.2:8000";

Future<List<Todo>> fetchTodos() async {
  final response = await http.get(Uri.parse('$baseUrl/'));

  if (response.statusCode == 200) {
    try {
      final List data = jsonDecode(response.body);
      return data.map((json) => Todo.fromJson(json)).toList();
    } catch (e) {
      throw Exception("Failed to parse todos: $e");
    }
  } else {
    throw Exception("Failed to fetch todos, status code: ${response.statusCode}");
  }
}

Future<bool> addTodo(Todo todo) async {
  final response = await http.post(
    Uri.parse('$baseUrl/'),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode(todo.toJson()),
  );
  if (response.statusCode == 200) {
    return true;
  } else {
    throw Exception("Failed to add todo, status code: ${response.statusCode}");
  }
}

Future<bool> updateTodo(String id, Todo todo) async {
  final response = await http.put(
    Uri.parse('$baseUrl/$id'),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode(todo.toJson()),
  );
  if (response.statusCode == 200) {
    return true;
  } else {
    throw Exception("Failed to update todo, status code: ${response.statusCode}");
  }
}

Future<bool> deleteTodo(String id) async {
  final response = await http.delete(Uri.parse('$baseUrl/$id'));
  if (response.statusCode == 200) {
    return true;
  } else {
    throw Exception("Failed to delete todo, status code: ${response.statusCode}");
  }
}
