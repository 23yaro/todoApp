import 'package:flutter/material.dart';

class ToDoWidget extends StatelessWidget {
  const ToDoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Material(
        child: ListTile(
          title: const Text('Text'),
          subtitle: const Text('time'),
          leading: const Text('accept'),
        ),
      ),
    );
  }
}
