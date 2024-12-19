import 'package:flutter/material.dart';
import 'package:toap/features/todo/presentation/presentation.dart';

class FilterChoiceChip extends StatelessWidget {
  final String label;
  final TimeFilter filter;
  final TimeFilter? selectedFilter;
  final ValueChanged<TimeFilter?> onSelected;

  const FilterChoiceChip({
    super.key,
    required this.label,
    required this.filter,
    required this.selectedFilter,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = selectedFilter == filter;
    return ChoiceChip(
      label: Text(
        label,
        style: TextStyle(
          fontSize: 16,
          fontWeight: isSelected ? FontWeight.bold : null,
          color: isSelected ? Colors.white : Colors.black87,
        ),
      ),
      selected: isSelected,
      checkmarkColor: Colors.white,
      color: WidgetStatePropertyAll(isSelected ? Colors.black87 : Colors.white),
      onSelected: (selected) {
        onSelected(selected ? filter : null);
      },
    );
  }
}
