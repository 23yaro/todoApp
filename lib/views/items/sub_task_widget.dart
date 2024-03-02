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
  State<SubTaskWidget> createState() => SubTaskWidgetState();
}

class SubTaskWidgetState extends State<SubTaskWidget> {
  late TextEditingController subTaskController;
  late FocusNode subTaskFocusNode;
  late bool lastStateUpdater;
  late bool lastState;

  @override
  void initState() {
    super.initState();
    lastStateUpdater = false;
    subTaskFocusNode = FocusNode();
    subTaskFocusNode.requestFocus();
    subTaskController = TextEditingController();
    subTaskController.addListener(_saveSubTaskName);
  }

  @override
  void dispose() {
    subTaskController.dispose();
    subTaskFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    subTaskController.text = widget.task.name.toString();
    saveCompleteState();
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
          controller: subTaskController,
          focusNode: subTaskFocusNode,
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
    return InputDecoration(
      hintStyle: TextStyle(color: Colors.black.withOpacity(0.4)),
      hintText: 'Новая подзадача',
      contentPadding: const EdgeInsets.symmetric(horizontal: 5),
      border: widget.readOnly ? InputBorder.none : const UnderlineInputBorder(),
    );
  }

  void _saveSubTaskName() {
    widget.task.name = subTaskController.text.toString().trim();
  }

  void saveCompleteState() {
    ///saves the lastState subTask complete.
    ///If mainTask complete, subTask = complete.
    ///If mainTask = false, subTask = lastState.
    if (widget.mainTaskComplete) {
      lastState = widget.task.complete;
      lastStateUpdater = true;
      widget.task.complete = widget.mainTaskComplete;
    } else if (lastStateUpdater) {
      widget.task.complete = lastState;
      lastStateUpdater = false;
    }
  }
}
