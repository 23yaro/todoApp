import 'package:flutter/material.dart';
import '../../consts/colors.dart';
import '../../model/tasks.dart';

class SubTaskWidget extends StatefulWidget {
  final Task task;
  final bool readOnly;
  final bool mainTaskComplete;
  final void Function(Task) taskComplete;
  final void Function(int) deleteSubTask;

  const SubTaskWidget({
    super.key,
    required this.task,
    required this.readOnly,
    required this.mainTaskComplete,
    required this.taskComplete,
    required this.deleteSubTask,
  });

  @override
  State<SubTaskWidget> createState() => _SubTaskWidgetState();
}

class _SubTaskWidgetState extends State<SubTaskWidget> {
  final _subTaskController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _subTaskController.addListener(_saveSubTaskName);
  }

  @override
  void dispose() {
    _subTaskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _subTaskController.text = widget.task.name.toString();
    if (widget.mainTaskComplete){
      widget.task.complete = true;
    }
    else {
      widget.task.complete = false;
    }// bug
    return ListTile(
      leading: IconButton(
        icon: Icon(
            widget.task.complete ? Icons.check_circle : Icons.circle_outlined),
        onPressed: () {
          widget.taskComplete(widget.task);
        },
      ),
      title: Container(
        decoration: BoxDecoration(
          color: tdBGColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: TextField(
          enabled: !widget.task.complete,
          controller: _subTaskController,
          readOnly: widget.readOnly,
          decoration: _inputDecoration(),
          maxLines: null,
          style: const TextStyle(
            fontSize: 14,
          ),
        ),
      ),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () {
          widget.deleteSubTask(widget.task.id);
        },
      ),
    );
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

  void _saveSubTaskName() {
    widget.task.name = _subTaskController.text.toString();
  }
}
