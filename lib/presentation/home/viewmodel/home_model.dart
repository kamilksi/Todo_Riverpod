import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_riverpod/utils/db_helper.dart';

import '../../../model/task_model.dart';

part 'home_model.g.dart';

@riverpod
class Todo extends _$Todo {
  final dbHelper = DatabaseHelper.instance;
  Future<List<Task>> _fetchTasks() async {
    state = const AsyncValue.loading();
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> todos = await db.query('todo');
    return todos.map(Task.fromJson).toList();
  }

  @override
  FutureOr<List<Task>> build() async {
    return _fetchTasks();
  }

  Future<void> add(Task task) async {
    final db = await dbHelper.database;
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      await Future.delayed(
          const Duration(seconds: 1),
          () => db.insert(
                'todo',
                task.toJson(),
                conflictAlgorithm: ConflictAlgorithm.replace,
              ));
      return _fetchTasks();
    });
  }

  Future<void> toggle(int taskID) async {
    final db = await dbHelper.database;
    state = await AsyncValue.guard(() async {
      db.update('todo', {'completed': 1}, where: 'id = ?', whereArgs: [taskID]);
      return _fetchTasks();
    });
  }

  Future<void> delete(int taskID) async {
    final db = await dbHelper.database;
    state = await AsyncValue.guard(() async {
      db.delete('todo', where: 'id = ?', whereArgs: [taskID]);
      return _fetchTasks();
    });
  }

  Future<void> updateTask(Task task) async {
    final db = await dbHelper.database;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      db.update('todo', task.toJson(), where: 'id = ?', whereArgs: [task.id]);
      return _fetchTasks();
    });
  }
}
