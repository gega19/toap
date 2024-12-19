import 'package:toap/features/todo/domain/domain.dart';

class DeleteTaskUseCase {
  final TaskRepository repository;

  DeleteTaskUseCase(this.repository);

  Future<void> call(Task task) async {
    await repository.deleteTask(task);
  }
}
