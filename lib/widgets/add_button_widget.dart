import 'package:flutter/material.dart';

import '../consts/colors.dart';

class AddButton extends StatelessWidget {
  const AddButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
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
    );
  }
}