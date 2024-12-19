import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:toap/features/todo/domain/domain.dart';
import 'package:toap/features/todo/presentation/presentation.dart';

@GenerateMocks([
  GetTasks,
  AddTaskUseCase,
  DeleteTaskUseCase,
  ToggleTaskStatusUseCase,
])
import 'todo_bloc_test.mocks.dart';

// Fecha fija para usar en los tests
final fixedDateTime = DateTime(2024, 12, 18, 23, 27, 40);

void main() {
  // Variables necesarias para los tests
  late TodoBloc bloc;
  late MockGetTasks mockGetTasks;
  late MockAddTaskUseCase mockAddTask;
  late MockDeleteTaskUseCase mockDeleteTask;
  late MockToggleTaskStatusUseCase mockToggleTaskStatus;

  // Configuración antes de cada prueba
  setUp(() {
    mockGetTasks = MockGetTasks();
    mockAddTask = MockAddTaskUseCase();
    mockDeleteTask = MockDeleteTaskUseCase();
    mockToggleTaskStatus = MockToggleTaskStatusUseCase();

    bloc = TodoBloc(
      getTasks: mockGetTasks,
      addTask: mockAddTask,
      deleteTask: mockDeleteTask,
      toggleTaskStatus: mockToggleTaskStatus,
    );
  });

  // Crear un ejemplo de tarea
  final task = Task(
    id: '1',
    title: 'Test Task',
    isCompleted: false,
    createdAt: fixedDateTime,
  );

  group('TodoBloc', () {
    /// Test: Carga de tareas (`LoadTasks`)
    blocTest<TodoBloc, TodoState>(
      'emits [TodoState] with tasks and filteredTasks when LoadTasks is added',
      build: () {
        when(mockGetTasks.call()).thenAnswer((_) async => [task]);
        return bloc;
      },
      act: (bloc) => bloc.add(LoadTasks()),
      expect: () => [
        TodoState(tasks: [task], filter: TaskFilter.all, filteredTasks: [task]),
      ],
      verify: (_) {
        verify(mockGetTasks.call()).called(1);
      },
    );

    /// Test: Agregar tarea (`AddTask`)
    blocTest<TodoBloc, TodoState>(
      'emits updated TodoState with added task when AddTask is added',
      build: () {
        when(mockAddTask.call(any)).thenAnswer((_) async => task);
        return bloc;
      },
      act: (bloc) => bloc.add(AddTask(task)),
      expect: () => [
        TodoState(tasks: [task], filter: TaskFilter.all, filteredTasks: [task]),
      ],
      verify: (_) {
        verify(mockAddTask.call(task)).called(1);
      },
    );

    /// Test: Eliminar tarea (`DeleteTask`)
    blocTest<TodoBloc, TodoState>(
      'emits updated TodoState without the deleted task when DeleteTask is added',
      build: () {
        when(mockDeleteTask.call(any)).thenAnswer((_) async => {});
        bloc.emit(TodoState(
          tasks: [task],
          filter: TaskFilter.all,
          filteredTasks: [task],
        ));
        return bloc;
      },
      act: (bloc) => bloc.add(DeleteTask(task)),
      expect: () => [
        const TodoState(tasks: [], filter: TaskFilter.all, filteredTasks: []),
      ],
      verify: (_) {
        verify(mockDeleteTask.call(task)).called(1);
      },
    );

    /// Test: Cambiar estado de una tarea (`ToggleTaskStatus`)
    blocTest<TodoBloc, TodoState>(
      'emits updated TodoState with toggled task status when ToggleTaskStatus is added',
      build: () {
        when(mockToggleTaskStatus.call(any)).thenAnswer((_) async => {});
        bloc.emit(TodoState(
            tasks: [task], filter: TaskFilter.all, filteredTasks: [task]));
        return bloc;
      },
      act: (bloc) => bloc.add(ToggleTaskStatus(task)),
      expect: () => [
        TodoState(
          tasks: [
            task.copyWith(isCompleted: true),
          ],
          filter: TaskFilter.all,
          filteredTasks: [
            task.copyWith(isCompleted: true),
          ],
        ),
      ],
      verify: (_) {
        verify(mockToggleTaskStatus.call(task.copyWith(isCompleted: true)))
            .called(1);
      },
    );

    /// Test: Filtrar por estado (`FilterTasks`)
    blocTest<TodoBloc, TodoState>(
      'emits updated TodoState with filteredTasks when FilterTasks is added',
      build: () {
        final completedTask = task.copyWith(isCompleted: true);
        bloc.emit(TodoState(
            tasks: [completedTask, task],
            filter: TaskFilter.all,
            filteredTasks: [completedTask, task]));
        return bloc;
      },
      act: (bloc) => bloc.add(const FilterTasks(TaskFilter.completed)),
      expect: () => [
        TodoState(
          tasks: [task.copyWith(isCompleted: true), task],
          filter: TaskFilter.completed,
          filteredTasks: [task.copyWith(isCompleted: true)],
        ),
      ],
    );

    /// Test: Filtrar por tiempo (`FilterByTime`)
    blocTest<TodoBloc, TodoState>(
      'emits updated TodoState with filteredTasks when FilterByTime is added',
      build: () {
        final taskThisWeek = task.copyWith(
            createdAt: fixedDateTime.subtract(const Duration(days: 2)));
        final taskLastMonth = task.copyWith(
            createdAt: fixedDateTime.subtract(const Duration(days: 40)));
        bloc.emit(TodoState(
            tasks: [taskThisWeek, taskLastMonth],
            filter: TaskFilter.all,
            filteredTasks: [taskThisWeek, taskLastMonth]));
        return bloc;
      },
      act: (bloc) => bloc.add(const FilterByTime(TimeFilter.thisWeek)),
      expect: () => [
        TodoState(
          tasks: [
            task.copyWith(
                createdAt: fixedDateTime.subtract(const Duration(days: 2))),
            task.copyWith(
                createdAt: fixedDateTime.subtract(const Duration(days: 40)))
          ],
          filter: TaskFilter.all,
          timeFilter: TimeFilter.thisWeek,
          filteredTasks: [
            task.copyWith(
                createdAt: fixedDateTime.subtract(const Duration(days: 2)))
          ],
        ),
      ],
    );
  });
}
