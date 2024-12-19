import 'package:toap/features/todo/domain/domain.dart';

class AddTaskUseCase {
  final TaskRepository repository;

  AddTaskUseCase(this.repository);

  Future<Task> call(Task task) async {
    await repository.addTask(task);
    return task;
  }
}
