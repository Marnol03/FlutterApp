
import 'package:myapp/data/todo_data_source.dart';
import 'package:myapp/models/todo.dart';

class TodoRepository {
  final TodoDataSource localDataSource;

  TodoRepository({required this.localDataSource});

  Future<List<Todo>> getTodos() async {

    List<Todo> todos = [];
    return Future.value(todos);
  }


  Future<void> addTodo(Todo todo) async {

  }

  Future<void> updateTodo(Todo todo) async {

  }

  Future<void> deleteTodo(String todoId) async {

  }
}
