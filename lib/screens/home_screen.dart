import 'package:flutter/material.dart';
import '../consts/colors.dart';
import '../widgets/add_button_widget.dart';

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
