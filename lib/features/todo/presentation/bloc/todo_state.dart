part of 'todo_bloc.dart';

class TodoState extends Equatable {
  final List<Task> tasks;
  final TaskFilter filter;
  final List<Task> filteredTasks;
  final TimeFilter? timeFilter;

  const TodoState({
    this.tasks = const [],
    this.filter = TaskFilter.all,
    this.filteredTasks = const [],
    this.timeFilter,
  });

  TodoState copyWith({
    List<Task>? tasks,
    TaskFilter? filter,
    List<Task>? filteredTasks,
    TimeFilter? timeFilter,
  }) {
    return TodoState(
      tasks: tasks ?? this.tasks,
      filter: filter ?? this.filter,
      filteredTasks: filteredTasks ?? this.filteredTasks,
      timeFilter: timeFilter ?? this.timeFilter,
    );
  }

  @override
  List<Object?> get props => [tasks, filter, filteredTasks, timeFilter];
}
