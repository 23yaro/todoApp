import 'package:flutter/material.dart';
import '../items/task_widget.dart';
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final listChildren = <SliverList>[
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return TaskWidget(
              key: ValueKey(tasks[index]),
              task: tasks[index],
              deleteTask: (int id) {},
              taskFocusNode: FocusNode(), ///debug
            );
          },
          childCount: tasks.length,
        ),
      )
    ];
    return Expanded(child: CustomScrollView(slivers: listChildren));
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
