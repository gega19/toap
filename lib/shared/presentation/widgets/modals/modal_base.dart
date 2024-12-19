import 'package:flutter/material.dart';
import 'package:toap/core/core.dart';

class ModalBase extends StatelessWidget {
  const ModalBase({
    super.key,
    required this.child,
    required this.title,
    required this.icon,
    this.onClose,
  });
  final Widget child;
  final IconData icon;
  final String title;
  final void Function()? onClose;

  Widget _topInfo(BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        Gaps.hGap5,
        Expanded(
            child: Text(
          title,
          style: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87),
        )),
        GestureDetector(
          onTap: onClose ?? Navigator.of(context).pop,
          child: const Icon(Icons.close, size: 25),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          top: 20,
          left: 20,
          right: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_topInfo(context), Gaps.vGap25, child],
          ),
        ),
      ),
    );
  }
}
