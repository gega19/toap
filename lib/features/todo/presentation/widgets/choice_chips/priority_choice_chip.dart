import 'package:flutter/material.dart';
import 'package:toap/core/core.dart';

class PriorityChoiceChip extends StatelessWidget {
  final String label;
  final String priority;
  final String? selectedPriority;
  final ValueChanged<String?>? onSelected;

  const PriorityChoiceChip({
    super.key,
    required this.label,
    this.priority = '',
    this.selectedPriority,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = selectedPriority == priority;
    final chipColor = ColorsApp.colorsPriority[priority];

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
      selectedColor: chipColor,
      backgroundColor: Colors.white,
      onSelected: (selected) {
        onSelected?.call(selected ? priority : null);
      },
    );
  }
}
