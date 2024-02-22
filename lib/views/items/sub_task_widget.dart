import 'package:flutter/material.dart';
import '../../consts/colors.dart';
import '../../model/tasks.dart';

class SubTaskWidget extends StatefulWidget {
  final Task task;
  final bool readOnly;

  //final Function editingComplete;
  final void Function(Task) taskComplete;

  const SubTaskWidget({
    super.key,
    required this.task,
    required this.readOnly,
    //required this.editingComplete,
    required this.taskComplete,
  });

  @override
  State<SubTaskWidget> createState() => _SubTaskWidgetState();
}

class _SubTaskWidgetState extends State<SubTaskWidget> {
  final _subTaskController = TextEditingController();

  @override
  void initState() {
    super.initState();
    widget.task.name = 'sub';
    _subTaskController.text = widget.task.name.toString();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: IconButton(
        icon: Icon(widget.task.complete
            ? Icons.check_circle
            : Icons.circle_outlined),
        onPressed: () => widget.taskComplete(widget.task),
      ),
      title: Container(
        decoration: BoxDecoration(
          color: tdBGColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: TextField(
          controller: _subTaskController,
          readOnly: widget.readOnly,
          decoration: _inputDecoration(),
          style: const TextStyle(
            fontSize: 14,
          ),
          //onEditingComplete: () => widget.editingComplete,
          //onTapOutside: (tap) => widget.editingComplete,
        ),
      ),
      trailing: const SizedBox(),
    ); //sub tasks
  }

  InputDecoration _inputDecoration() {
    return widget.readOnly
        ? const InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 5))
        : const InputDecoration(
            border: UnderlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 5));
  }
}
