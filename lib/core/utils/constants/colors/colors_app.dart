import 'package:flutter/material.dart';
import 'package:toap/core/core.dart';

class ColorsApp {
  static const Color logoBackground = Color.fromRGBO(253, 250, 111, 1);

  static const Map<String, Color> colorsPriority = {
    PriorityStrings.low: Colors.green,
    PriorityStrings.medium: Colors.blue,
    PriorityStrings.high: Colors.orange,
    PriorityStrings.urgent: Colors.red
  };
}
