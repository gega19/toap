import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toap/features/todo/domain/domain.dart';

part 'todo_event.dart';
part 'todo_state.dart';

// BLoC for managing Todo tasks
class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final GetTasks getTasks; // Use case for retrieving tasks
  final AddTaskUseCase addTask; // Use case for adding a task
  final DeleteTaskUseCase deleteTask; // Use case for deleting a task
  final ToggleTaskStatusUseCase
      toggleTaskStatus; // Use case for toggling task status

  TodoBloc({
    required this.getTasks,
    required this.addTask,
    required this.deleteTask,
    required this.toggleTaskStatus,
  }) : super(const TodoState()) {
    // Event handlers
    on<LoadTasks>(_onLoadTasks);
    on<AddTask>(_onAddTask);
    on<DeleteTask>(_onDeleteTask);
    on<ToggleTaskStatus>(_onToggleTaskStatus);
    on<FilterTasks>(_onFilterTasks);
    on<FilterByTime>(_onFilterByTime);
  }

  // Handler for loading tasks
  Future<void> _onLoadTasks(LoadTasks event, Emitter<TodoState> emit) async {
    // Retrieve tasks
    final tasks = await getTasks.call();
    // Apply filters
    final filtered = _applyFilters(tasks, state.filter, state.timeFilter);
    emit(state.copyWith(tasks: tasks, filteredTasks: filtered));
  }

  // Handler for adding a task
  Future<void> _onAddTask(AddTask event, Emitter<TodoState> emit) async {
    // Add task
    final task = await addTask.call(event.task);
    // Update task list
    final updatedTasks = List<Task>.from(state.tasks)..add(task);
    // Apply filters
    final filtered =
        _applyFilters(updatedTasks, state.filter, state.timeFilter);
    // Emit new state
    emit(state.copyWith(tasks: updatedTasks, filteredTasks: filtered));
  }

// Handler for deleting a task
  Future<void> _onDeleteTask(DeleteTask event, Emitter<TodoState> emit) async {
    // Delete task
    await deleteTask.call(event.task);
    // Update task list
    final updatedTasks = List<Task>.from(state.tasks)
      ..removeWhere((task) => task.id == event.task.id);
    // Apply filters
    final filtered =
        _applyFilters(updatedTasks, state.filter, state.timeFilter);
    emit(state.copyWith(tasks: updatedTasks, filteredTasks: filtered));
  }

// Handler for toggling task status
  Future<void> _onToggleTaskStatus(
      ToggleTaskStatus event, Emitter<TodoState> emit) async {
    // Toggle status
    final updatedTask =
        event.task.copyWith(isCompleted: !event.task.isCompleted);

    // Update task status
    await toggleTaskStatus.call(updatedTask);

    // Update task list
    final updatedTasks = state.tasks.map((task) {
      return task.id == updatedTask.id ? updatedTask : task;
    }).toList();

    // Apply filters
    final filtered =
        _applyFilters(updatedTasks, state.filter, state.timeFilter);
    emit(state.copyWith(tasks: updatedTasks, filteredTasks: filtered));
  }

// Handler for filtering tasks
  void _onFilterTasks(FilterTasks event, Emitter<TodoState> emit) {
    // Apply filters
    final filtered = _applyFilters(state.tasks, event.filter, state.timeFilter);
    emit(state.copyWith(filter: event.filter, filteredTasks: filtered));
  }

  // Handler for filtering tasks by time
  void _onFilterByTime(FilterByTime event, Emitter<TodoState> emit) {
    // Apply filters
    final filtered = _applyFilters(state.tasks, state.filter, event.timeFilter);
    emit(state.copyWith(timeFilter: event.timeFilter, filteredTasks: filtered));
  }

  // Applies filters to the list of tasks
  List<Task> _applyFilters(
      List<Task> tasks, TaskFilter filter, TimeFilter? timeFilter) {
    List<Task> filtered = tasks;

    // Filter by task status
    switch (filter) {
      case TaskFilter.completed:
        filtered = filtered.where((task) => task.isCompleted).toList();
        break;
      case TaskFilter.pending:
        filtered = filtered.where((task) => !task.isCompleted).toList();
        break;
      case TaskFilter.all:
      default:
        break;
    }

    // Filter by time
    if (timeFilter != null) {
      final now = DateTime.now();
      switch (timeFilter) {
        case TimeFilter.yesterday:
          final yesterday = now.subtract(const Duration(days: 1));
          filtered = filtered.where((task) {
            return task.createdAt.year == yesterday.year &&
                task.createdAt.month == yesterday.month &&
                task.createdAt.day == yesterday.day;
          }).toList();
          break;
        case TimeFilter.thisWeek:
          final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
          filtered = filtered.where((task) {
            return task.createdAt.isAfter(DateTime(
                    startOfWeek.year, startOfWeek.month, startOfWeek.day)) &&
                task.createdAt.isBefore(
                    DateTime(now.year, now.month, now.day, 23, 59, 59));
          }).toList();
          break;
        case TimeFilter.thisMonth:
          filtered = filtered.where((task) {
            return task.createdAt.year == now.year &&
                task.createdAt.month == now.month;
          }).toList();
          break;
        case TimeFilter.last3Months:
          final threeMonthsAgo = DateTime(now.year, now.month - 3, now.day);
          filtered = filtered.where((task) {
            return task.createdAt.isAfter(threeMonthsAgo) &&
                task.createdAt.isBefore(
                    DateTime(now.year, now.month, now.day, 23, 59, 59));
          }).toList();
          break;
        case TimeFilter.all:
          break;
      }
    }

    return filtered;
  }
}
