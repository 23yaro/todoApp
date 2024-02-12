import 'package:flutter/material.dart';
import '../items/ToDoWidget.dart';
import '../items/proxyDecorator.dart';
import '/../consts/colors.dart';


class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: tdBGColor,
      body: Stack(
        children: [ScrollBar()],
      ),
    );
  }
}

class ScrollBar extends StatefulWidget {
  const ScrollBar({super.key});

  @override
  State<ScrollBar> createState() => _ScrollBarState();
}

class _ScrollBarState extends State<ScrollBar> {

  @override
  Widget build(BuildContext context) {
    return ReorderableListView(
      proxyDecorator: proxyDecorator,
      children: [ToDoWidget(key: UniqueKey()), ToDoWidget(key: UniqueKey()), ToDoWidget(key: UniqueKey())],
      onReorder: (int oldIndex, int newIndex) {},
    );
  }
}

class AddButton extends StatelessWidget {
  const AddButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class AppBar extends StatelessWidget {
  const AppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
