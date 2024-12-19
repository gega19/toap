import 'package:flutter/material.dart';
import 'injection_container.dart' as di;
import 'features/todo/presentation/bloc/todo_bloc.dart';
import 'features/todo/presentation/pages/todo_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initializes dependencies using the dependency injection container
  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di.sl<TodoBloc>()..add(LoadTasks()),
      child: const MaterialApp(
        title: 'TODO',
        debugShowCheckedModeBanner: false,
        home: TodoPage(),
      ),
    );
  }
}
