import 'package:flutter/material.dart';
import 'package:toap/core/utils/utils.dart';

class EmptyTasks extends StatelessWidget {
  const EmptyTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(Assets.withoutTasks),
          const Text('No tienes tareas',
              style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold)),
          const Text('Empieza creando tus primeras tareas',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black54,
                  fontWeight: FontWeight.normal)),
        ],
      ),
    );
  }
}
