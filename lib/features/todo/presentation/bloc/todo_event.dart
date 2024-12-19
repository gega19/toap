part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object?> get props => [];
}

class LoadTasks extends TodoEvent {}

class AddTask extends TodoEvent {
  final Task task;

  const AddTask(this.task);

  @override
  List<Object?> get props => [task];
}

class DeleteTask extends TodoEvent {
  final Task task;

  const DeleteTask(this.task);

  @override
  List<Object?> get props => [task];
}

class ToggleTaskStatus extends TodoEvent {
  final Task task;

  const ToggleTaskStatus(this.task);

  @override
  List<Object?> get props => [task];
}

class FilterTasks extends TodoEvent {
  final TaskFilter filter;

  const FilterTasks(this.filter);

  @override
  List<Object?> get props => [filter];
}

class FilterByTime extends TodoEvent {
  final TimeFilter timeFilter;

  const FilterByTime(this.timeFilter);

  @override
  List<Object?> get props => [timeFilter];
}

enum TaskFilter { all, completed, pending }

enum TimeFilter { yesterday, thisWeek, thisMonth, last3Months, all }
