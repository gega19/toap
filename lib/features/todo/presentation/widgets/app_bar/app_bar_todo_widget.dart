import 'package:flutter/material.dart';
import 'package:toap/core/core.dart';

class AppBarTodoWidget extends StatelessWidget {
  const AppBarTodoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          _logoApp(),
          Gaps.hGap10,
          _welcome(user: "User451"),
          Gaps.hGap10,
          // _actions()
        ],
      ),
    );
  }

  Widget _logoApp() {
    return Container(
        padding: const EdgeInsets.all(3),
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: ColorsApp.logoBackground,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Image.asset(Assets.icont1));
  }

  Widget _welcome({String user = ''}) {
    return Expanded(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Hola! Bienvenido',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(user, style: const TextStyle(fontSize: 14)),
      ],
    ));
  }

  // //
  // Widget _actions() {
  //   return Row(
  //     mainAxisSize: MainAxisSize.min,
  //     children: [
  //       GestureDetector(
  //         onTap: () {},
  //         child: const Icon(Icons.search, size: 30, color: Colors.grey),
  //       ),
  //       Gaps.hGap5,
  //       GestureDetector(
  //         onTap: () {},
  //         child: const Icon(
  //           Icons.settings,
  //           size: 30,
  //           color: Colors.grey,
  //         ),
  //       ),
  //     ],
  //   );
  // }
}
