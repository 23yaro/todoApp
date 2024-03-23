import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../block/tsk_bloc.dart';
import '../consts/colors.dart';
import '../widgets/task_widget.dart';


class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: tdBGColor,
      floatingActionButton: AddButton(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: ScrollBar(),
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
  final _tasksListBloc = TskBloc();

  @override
  void initState() {
    super.initState();
    _tasksListBloc.add(LoadTaskList());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TskBloc, TskState>(
        bloc: _tasksListBloc,
        builder: (context, state) {
          if (state is TskLoaded) {
            return CustomScrollView(
              slivers: <SliverList>[
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: TaskWidget(
                          key: ValueKey(state.tasksList[index]),
                          task: state.tasksList[index],
                          deleteTask: (int id) {},
                        ),
                      );
                    },
                    childCount: state.tasksList.length,
                  ),
                )
              ],
            );
          }
          return Container();
        });
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
