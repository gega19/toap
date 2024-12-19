// lib/features/todo/presentation/widgets/filter_section.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toap/core/core.dart';
import 'package:toap/features/todo/presentation/presentation.dart';

class FiltersTodoWidget extends StatelessWidget {
  const FiltersTodoWidget({super.key});

  void _showFilterModal(BuildContext context, {TimeFilter? timeFilter}) {
    showModalBottomSheet(
      context: context,
      builder: (_) => FilterModal(
        selectedFilter: timeFilter,
        onFilterChange: (filter) => context
            .read<TodoBloc>()
            .add(FilterByTime(filter ?? TimeFilter.all)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final TodoBloc todoBloc = context.read();

    return BlocBuilder<TodoBloc, TodoState>(
        buildWhen: (p, c) =>
            p.filter != c.filter || p.timeFilter != c.timeFilter,
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(12),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(
                  decelerationRate: ScrollDecelerationRate.fast),
              child: Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: () =>
                        _showFilterModal(context, timeFilter: state.timeFilter),
                    icon: const Icon(Icons.filter_list_alt),
                    label: const Text('Filtrar'),
                  ),
                  Gaps.hGap10,
                  QuickFilterButton(
                    label: 'Todas',
                    filter: TaskFilter.all,
                    isSelected: state.filter == TaskFilter.all,
                    onTap: () =>
                        todoBloc.add(const FilterTasks(TaskFilter.all)),
                  ),
                  Gaps.hGap10,
                  QuickFilterButton(
                    label: 'Completadas',
                    filter: TaskFilter.completed,
                    isSelected: state.filter == TaskFilter.completed,
                    onTap: () =>
                        todoBloc.add(const FilterTasks(TaskFilter.completed)),
                  ),
                  Gaps.hGap10,
                  QuickFilterButton(
                    label: 'Pendientes',
                    filter: TaskFilter.pending,
                    isSelected: state.filter == TaskFilter.pending,
                    onTap: () =>
                        todoBloc.add(const FilterTasks(TaskFilter.pending)),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
