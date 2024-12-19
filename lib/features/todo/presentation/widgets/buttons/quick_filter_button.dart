import 'package:flutter/material.dart';
import 'package:toap/features/todo/presentation/presentation.dart';

class QuickFilterButton extends StatelessWidget {
  final String label;
  final TaskFilter filter;
  final bool isSelected;
  final void Function()? onTap;

  const QuickFilterButton(
      {super.key,
      required this.label,
      required this.filter,
      this.onTap,
      this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey),
              color: isSelected ? Colors.black : null),
          child: Text(
            label,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : Colors.black87),
          )),
    );
  }
}
