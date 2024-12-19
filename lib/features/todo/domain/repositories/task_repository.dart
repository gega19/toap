import 'package:toap/features/todo/domain/domain.dart';

abstract class TaskRepository {
  Future<List<Task>> getTasks();
  Future<void> addTask(Task task);
  Future<void> deleteTask(Task task);
  Future<void> updateTask(Task task);
}
