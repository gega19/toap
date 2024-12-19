import 'package:toap/features/todo/domain/domain.dart';

class ToggleTaskStatusUseCase {
  final TaskRepository repository;

  ToggleTaskStatusUseCase(this.repository);

  Future<void> call(Task task) async {
    await repository.updateTask(task);
  }
}
