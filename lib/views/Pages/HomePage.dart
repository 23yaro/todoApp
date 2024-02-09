import 'package:flutter/material.dart';
import 'package:tutr/views/items/ToDoWidget.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            child: const ToDoScroll(),
          ),
          Container(
            child: const AddButton(),
          )
        ],
      ),
    );
  }
}

class ToDoScroll extends StatefulWidget {
  const ToDoScroll({super.key});

  @override
  State<ToDoScroll> createState() => _ToDoScrollState();
}

class _ToDoScrollState extends State<ToDoScroll> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView(children: const [ToDoWidget()])
      ],
    );
  }
}

class AddButton extends StatelessWidget {
  const AddButton({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class AppBar extends StatelessWidget {
  const AppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
