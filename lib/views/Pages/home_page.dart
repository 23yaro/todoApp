import 'package:flutter/material.dart';
import '../items/task_widget.dart';
import '../items/proxy_decorator.dart';
import '/../consts/colors.dart';
import '../../model/tasks.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: tdBGColor,
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          ScrollBar(),
        ],
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
      shrinkWrap: true,
      proxyDecorator: proxyDecorator,
      children: [
        ToDoWidget(
          key: UniqueKey(),
          task: Task(id: 200,),
          deleteTask: (int ) {  },
        )
      ],
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
