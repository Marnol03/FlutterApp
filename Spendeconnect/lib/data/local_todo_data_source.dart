import 'package:myapp/data/todo_data_source.dart'; // Importez l'interface
import 'package:myapp/models/todo.dart';

class LocalTodoDataSource implements TodoDataSource {
  @override
  Future<List<Todo>> getTodos() async {
     
    return [];
  }

  @override
  Future<void> addTodo(Todo todo) async {

  }

  @override
  Future<void> deleteTodo(String todoId) async {

  }

  @override
  Future<void> updateTodo(Todo todo) async {

  }


}
