import 'package:flutter/material.dart';
import 'package:toap/core/core.dart';
import 'package:toap/features/todo/domain/domain.dart';
import 'package:toap/features/todo/presentation/presentation.dart';

// A widget that represents a card for displaying a task
class CardTodo extends StatefulWidget {
  final Task task;
  final void Function()? onChanged;
  final void Function()? onDelete;

  const CardTodo({
    super.key,
    required this.task,
    this.onChanged,
    this.onDelete,
  });

  @override
  State<CardTodo> createState() => _CardTodoState();
}

class _CardTodoState extends State<CardTodo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller; // Controls the animation for the line
  late Animation<double> _lineAnimation; // Animation for the line through text

  bool isCompleted = false; // Tracks if the task is completed

  @override
  void initState() {
    super.initState();
    isCompleted = widget.task.isCompleted;
    // Initialize the animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    // Define the animation for the line
    _lineAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);
    if (isCompleted) {
      _controller.value = 1.0; // Set animation to complete if task is completed
    }
  }

  // Toggles the completion status of the task
  void toggleCompleted() {
    setState(() {
      isCompleted = !isCompleted;
      if (isCompleted) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });

    if (widget.onChanged != null) widget.onChanged!();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(widget.task.id.toString()),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        if (widget.onDelete != null) widget.onDelete!();
      },
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        color: Colors.red,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 45,
        ),
      ),
      child: Container(
        margin: const EdgeInsets.all(10),
        constraints: const BoxConstraints(minHeight: 100),
        decoration: BoxDecoration(
          color:
              ColorsApp.colorsPriority[widget.task.priority]?.withOpacity(0.8),
          borderRadius: BorderRadius.circular(15),
          border: Border(
            left: BorderSide(
              width: 10,
              color: ColorsApp.colorsPriority[widget.task.priority]!,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AnimatedBuilder(
                          animation: _lineAnimation,
                          builder: (context, child) {
                            return Stack(
                              children: [
                                Text(
                                  widget.task.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    decoration: isCompleted
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none,
                                  ),
                                ),
                                Positioned(
                                  top: 10,
                                  left: 0,
                                  child: SizedBox(
                                    width: _lineAnimation.value *
                                        MediaQuery.of(context).size.width,
                                    child: Container(
                                      height: 2,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        Gaps.hGap10,
                        Text(
                          widget.task.description,
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 16, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Gaps.hGap10,
                  PriorityChoiceChip(
                    label: PriorityStrings.labels[widget.task.priority] ?? '',
                    priority: widget.task.priority,
                    selectedPriority: widget.task.priority,
                  ),
                ],
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Checkbox(
                  value: isCompleted,
                  onChanged: (value) {
                    toggleCompleted();
                  },
                  activeColor: Colors.green,
                  checkColor: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
