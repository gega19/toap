import 'package:flutter/material.dart';
import 'package:toap/core/core.dart';

class ButtonBase extends StatelessWidget {
  const ButtonBase(
      {super.key,
      this.onPressed,
      this.title = 'Continuar',
      this.backgroundColor = ColorsApp.logoBackground});
  final void Function()? onPressed;
  final String title;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
      child: Text(title.toUpperCase(),
          style: const TextStyle(
              fontSize: 18,
              color: Colors.black87,
              fontWeight: FontWeight.bold)),
    );
  }
}
