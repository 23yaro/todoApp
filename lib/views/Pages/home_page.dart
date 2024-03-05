import 'package:flutter/material.dart';
import '../items/task_widget.dart';
import '/../consts/colors.dart';
import '../../model/tasks.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: const ScrollBar(),
          ),
          const AddButton(),
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
            return Padding(
              padding: const EdgeInsets.only(top: 10),
              child: TaskWidget(
                key: ValueKey(tasks[index]),
                task: tasks[index],
                deleteTask: (int id) {},
              ),
            );
          },
          childCount: tasks.length,
        ),
      )
    ];
    return CustomScrollView(slivers: listChildren);
  }
}

class AddButton extends StatelessWidget {
  const AddButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        margin: const EdgeInsets.only(right: 10, bottom: 10),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: tdBlack,
            minimumSize: const Size(50, 60),
            elevation: 10,
          ),
          child: const Icon(
            Icons.add,
            color: tdWhite,
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}

class AppBar extends StatelessWidget {
  const AppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
