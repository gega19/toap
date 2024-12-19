import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toap/core/core.dart';
import 'package:toap/features/todo/presentation/presentation.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  void _showAddTaskModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (_) => AddTaskModal(
              onAddTask: (task) => context.read<TodoBloc>().add(AddTask(task)),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Column(
              children: [
                Gaps.vGap20,
                const AppBarTodoWidget(),
                const FiltersTodoWidget(),
                Expanded(
                  child: BlocBuilder<TodoBloc, TodoState>(
                    builder: (context, state) {
                      if (state.filteredTasks.isEmpty) {
                        return const Center(child: EmptyTasks());
                      }
                      return ListView.builder(
                        itemCount: state.filteredTasks.length,
                        itemBuilder: (context, index) {
                          final task = state.filteredTasks[index];
                          return CardTodo(
                            key: Key(task.id),
                            task: task,
                            onChanged: () {
                              context
                                  .read<TodoBloc>()
                                  .add(ToggleTaskStatus(task));
                            },
                            onDelete: () {
                              context.read<TodoBloc>().add(DeleteTask(task));
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => _showAddTaskModal(context),
              backgroundColor: ColorsApp.logoBackground,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 8,
              child: const Icon(
                Icons.add,
                size: 30,
                color: Colors.black,
              ),
            )));
  }
}
