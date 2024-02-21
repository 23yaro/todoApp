import 'package:flutter/material.dart';
import '../../consts/colors.dart';

class SubTaskWidget extends StatefulWidget {
  final bool readOnly;
  final Function editingComplete;
  final Widget checkIconButton;

  const SubTaskWidget({
    super.key,
    required this.readOnly,
    required this.editingComplete,
    required this.checkIconButton,
  });

  @override
  State<SubTaskWidget> createState() => _SubTaskWidgetState();
}

class _SubTaskWidgetState extends State<SubTaskWidget> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: widget.checkIconButton,
      title: Container(
        decoration: BoxDecoration(
          color: tdBGColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: TextField(
          //controller: _taskDescriptionController,
          //focusNode: myFocusNode,
          readOnly: widget.readOnly,
          decoration: widget.readOnly
              ? const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 5))
              : const InputDecoration(
                  border: UnderlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 5)),
          style: const TextStyle(
            fontSize: 14,
          ),
          onEditingComplete: ()=> widget.editingComplete,
        ),
      ),
      trailing: const SizedBox(),
    ); //sub tasks
  }
}
