import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:toap/features/todo/presentation/presentation.dart';

import 'package:uuid/uuid.dart';

import 'features/todo/data/data.dart';
import 'features/todo/domain/domain.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  // Registers the TodoBloc with its dependencies
  sl.registerFactory(() => TodoBloc(
        getTasks: sl(),
        addTask: sl(),
        deleteTask: sl(),
        toggleTaskStatus: sl(),
      ));

  // Use cases
  // Registers use cases as lazy singletons
  sl.registerLazySingleton(() => GetTasks(sl()));
  sl.registerLazySingleton(() => AddTaskUseCase(sl()));
  sl.registerLazySingleton(() => DeleteTaskUseCase(sl()));
  sl.registerLazySingleton(() => ToggleTaskStatusUseCase(sl()));

  // Repository
  // Registers the TaskRepository implementation
  sl.registerLazySingleton<TaskRepository>(() => TaskRepositoryImpl(sl()));

  // External
  // Initializes Hive for local storage
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(TaskAdapter());
  final taskBox = await Hive.openBox<Task>('tasks');
  sl.registerLazySingleton(() => taskBox);
  sl.registerLazySingleton(() => const Uuid());
}
