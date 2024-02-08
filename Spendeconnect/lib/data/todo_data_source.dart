import 'package:myapp/models/todo.dart';

abstract class TodoDataSource {
  Future<List<Todo>> getTodos();
  Future<void> addTodo(Todo todo);
  Future<void> updateTodo(Todo todo);
  Future<void> deleteTodo(String todoId);
}