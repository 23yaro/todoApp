import 'package:flutter/material.dart';
import '../../model/tasks.dart';
import 'sub_task_widget.dart';

class ToDoWidget extends StatefulWidget {
  const ToDoWidget({super.key, required this.task});

  final Task task;

  @override
  State<ToDoWidget> createState() => TaskWidget();
}

class TaskWidget extends State<ToDoWidget> {
  late bool disabledEditing;
  final _taskController = TextEditingController();
  final _subTaskController = TextEditingController();


  @override
  void initState() {
    super.initState();
    disabledEditing = true;
    _taskController.text = widget.task.name.toString();
    _subTaskController.text = widget.task.description.toString();
    widget.task.subTasks = [Task(id: 1), Task(id: 2), Task(id: 3)];
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: _boxDecoration(),
      child: ListTileTheme(
        contentPadding: EdgeInsets.zero,
        horizontalTitleGap: 0.0,
        child: TapRegion(
          onTapOutside: (event) => _editingComplete(widget.task),
          child: ExpansionTile(
            iconColor: Colors.black,
            textColor: Colors.black,
            shape: const Border(),
            leading: IconButton(
              iconSize: 28,
              icon: Icon(widget.task.complete
                  ? Icons.check_box
                  : Icons.check_box_outline_blank),
              onPressed: () => _taskComplete(widget.task),
            ),
            title: TextField(
              controller: _taskController,
              enabled: !disabledEditing,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
              onEditingComplete: () => _editingComplete(widget.task),
            ),
            trailing: _editButton(widget.task),
            children: [
              ListView.builder(
                itemCount: widget.task.subTasks.length,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemBuilder: (BuildContext context, int index) {
                  return SubTaskWidget(
                    task: widget.task.subTasks[index],
                    readOnly: disabledEditing,
                    taskComplete: _taskComplete,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Decoration _boxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      border: Border(
          right: BorderSide(color: Colors.red.withOpacity(0.7), width: 2)),
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 2,
          blurRadius: 6,
        )
      ],
    );
  }

  Widget _editButton(Task task) {
    return IconButton(
      icon: disabledEditing ? const Icon(Icons.edit) : const Icon(Icons.check),
      color: disabledEditing ? null : Colors.green.withOpacity(0.9),
      onPressed: () {
        if (disabledEditing) {
          setState(() {
            disabledEditing = false;
          });
        } else {
          _editingComplete(task);
        }
      },
    );
  }

  void _taskComplete(Task task) {
    task.complete = !task.complete;
    setState(() {});
  }

  void _editingComplete(Task task) {
    if (!disabledEditing) {
      setState(() {
        task.name = _taskController.text;
        FocusManager.instance.primaryFocus?.unfocus();
        disabledEditing = true;
      });
    }
  }
}
