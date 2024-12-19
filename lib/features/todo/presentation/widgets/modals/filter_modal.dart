import 'package:flutter/material.dart';
import 'package:toap/core/core.dart';
import 'package:toap/features/todo/presentation/presentation.dart';
import 'package:toap/shared/shared.dart';

class FilterModal extends StatefulWidget {
  const FilterModal({super.key, this.selectedFilter, this.onFilterChange});
  final TimeFilter? selectedFilter;
  final void Function(TimeFilter?)? onFilterChange;

  @override
  State<FilterModal> createState() => _FilterModalState();
}

class _FilterModalState extends State<FilterModal> {
  TimeFilter? selectedFilter;
  @override
  void initState() {
    super.initState();
    selectedFilter = widget.selectedFilter;
  }

  @override
  Widget build(BuildContext context) {
    return ModalBase(
      title: "Filtrar",
      icon: Icons.tune,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Filtrar por fecha',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 5.0,
                children: [
                  FilterChoiceChip(
                    label: 'Ayer',
                    filter: TimeFilter.yesterday,
                    selectedFilter: selectedFilter,
                    onSelected: (filter) {
                      setState(() {
                        selectedFilter = filter;
                      });
                    },
                  ),
                  FilterChoiceChip(
                    label: 'Esta Semana',
                    filter: TimeFilter.thisWeek,
                    selectedFilter: selectedFilter,
                    onSelected: (filter) {
                      setState(() {
                        selectedFilter = filter;
                      });
                    },
                  ),
                  FilterChoiceChip(
                    label: 'Este Mes',
                    filter: TimeFilter.thisMonth,
                    selectedFilter: selectedFilter,
                    onSelected: (filter) {
                      setState(() {
                        selectedFilter = filter;
                      });
                    },
                  ),
                  FilterChoiceChip(
                    label: 'Últimos 3 Meses',
                    filter: TimeFilter.last3Months,
                    selectedFilter: selectedFilter,
                    onSelected: (filter) {
                      setState(() {
                        selectedFilter = filter;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
          Gaps.vGap30,
          Center(
              child: ButtonBase(
            onPressed: selectedFilter != widget.selectedFilter
                ? () {
                    widget.onFilterChange?.call(selectedFilter);
                    Navigator.pop(context);
                  }
                : null,
            title: 'Aplicar Filtros',
          )),
        ],
      ),
    );
  }
}
