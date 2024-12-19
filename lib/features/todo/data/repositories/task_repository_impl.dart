import 'package:hive/hive.dart';
import 'package:toap/features/todo/domain/domain.dart';

class TaskRepositoryImpl implements TaskRepository {
  final Box<Task> taskBox;

  TaskRepositoryImpl(this.taskBox);

  @override
  Future<void> addTask(Task task) async {
    await taskBox.put(
        task.id,
        Task(
          id: task.id,
          title: task.title,
          description: task.description,
          priority: task.priority,
          isCompleted: task.isCompleted,
          createdAt: task.createdAt,
        ));
  }

  @override
  Future<void> deleteTask(Task task) async {
    await taskBox.delete(task.id);
  }

  @override
  Future<List<Task>> getTasks() async {
    return taskBox.values.toList();
  }

  @override
  Future<void> updateTask(Task task) async {
    await taskBox.put(
        task.id,
        Task(
            id: task.id,
            title: task.title,
            isCompleted: task.isCompleted,
            createdAt: task.createdAt,
            description: task.description,
            priority: task.priority));
  }
}
