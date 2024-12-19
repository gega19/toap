import 'package:flutter/material.dart';
import 'package:toap/core/core.dart';
import 'package:toap/features/todo/domain/domain.dart';
import 'package:toap/features/todo/presentation/presentation.dart';
import 'package:toap/shared/shared.dart';
import 'package:uuid/uuid.dart';

class AddTaskModal extends StatefulWidget {
  const AddTaskModal({super.key, this.onAddTask});
  final void Function(Task)? onAddTask;

  @override
  State<AddTaskModal> createState() => _FilterModalState();
}

class _FilterModalState extends State<AddTaskModal> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  String priority = PriorityStrings.low;

  final ValueNotifier<bool> isButtonEnabled = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    titleController.addListener(_updateButtonState);
    descriptionController.addListener(_updateButtonState);
  }

  void _updateButtonState() {
    isButtonEnabled.value = titleController.text.trim().isNotEmpty &&
        descriptionController.text.trim().isNotEmpty;
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    isButtonEnabled.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
    );
    final focusedBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: const BorderSide(color: Colors.green),
    );
    const focusedLabelStyle = TextStyle(color: Colors.black);
    return ModalBase(
      title: "Agregar Tarea",
      icon: Icons.add_task,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                  filled: true,
                  border: border,
                  focusedBorder: focusedBorder,
                  labelText: 'Título de la tarea',
                  floatingLabelStyle: focusedLabelStyle,
                  fillColor: Colors.white),
            ),
            Gaps.vGap10,
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                  labelText: 'Descripción de la tarea',
                  border: border,
                  filled: true,
                  focusedBorder: focusedBorder,
                  floatingLabelStyle: focusedLabelStyle,
                  fillColor: Colors.white),
            ),
            Gaps.vGap25,
            const Text(
              'Prioridad',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            Gaps.vGap10,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 5.0,
                  children: [
                    PriorityChoiceChip(
                      label: 'Baja',
                      priority: PriorityStrings.low,
                      selectedPriority: priority,
                      onSelected: (p) {
                        if (p != priority && p != null) {
                          setState(() {
                            priority = p;
                          });
                        }
                      },
                    ),
                    PriorityChoiceChip(
                      label: 'Media',
                      priority: PriorityStrings.medium,
                      selectedPriority: priority,
                      onSelected: (p) {
                        if (p != priority && p != null) {
                          setState(() {
                            priority = p;
                          });
                        }
                      },
                    ),
                    PriorityChoiceChip(
                      label: 'Alta',
                      priority: PriorityStrings.high,
                      selectedPriority: priority,
                      onSelected: (p) {
                        if (p != priority && p != null) {
                          setState(() {
                            priority = p;
                          });
                        }
                      },
                    ),
                    PriorityChoiceChip(
                      label: 'Urgente',
                      priority: PriorityStrings.urgent,
                      selectedPriority: priority,
                      onSelected: (p) {
                        if (p != priority && p != null) {
                          setState(() {
                            priority = p;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
            Gaps.vGap30,
            Center(
              child: ValueListenableBuilder<bool>(
                valueListenable: isButtonEnabled,
                builder: (context, isEnabled, child) {
                  return ButtonBase(
                    onPressed: isEnabled
                        ? () {
                            final title = titleController.text.trim();
                            final description =
                                descriptionController.text.trim();
                            if (title.isNotEmpty && description.isNotEmpty) {
                              final Task task = Task(
                                id: const Uuid().v4(),
                                title: title,
                                description: description,
                                priority: priority,
                                isCompleted: false,
                                createdAt: DateTime.now(),
                              );
                              widget.onAddTask?.call(task);
                            }
                            Navigator.pop(context);
                          }
                        : null,
                    title: 'Agregar',
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
