import 'package:flutter/material.dart';
import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import '../items/ToDoWidget.dart';
import '/../consts/colors.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: tdBGColor,
      body: Stack(
        children: [ToDoScroll()],
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
    return DragAndDropLists(
        onItemReorder: (int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {},
        onListReorder: (int oldListIndex, int newListIndex) {},
        children: [
          DragAndDropList(children: [
            DragAndDropItem(child: ToDoWidget()),
          ])
        ]);
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
