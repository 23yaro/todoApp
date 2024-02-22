import 'package:flutter/material.dart';
import '../../consts/colors.dart';
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
  late FocusNode myFocusNode;
  final _taskNameController = TextEditingController();
  final _taskDescriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    disabledEditing = true;
    myFocusNode = FocusNode();
    _taskNameController.text = widget.task.name.toString();
    _taskDescriptionController.text = widget.task.description.toString();
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
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
          onTapOutside: (event) => _editingComplete(),
          child: ExpansionTile(
            iconColor: Colors.black,
            textColor: Colors.black,
            shape: const Border(),
            leading: _checkIconButton(
                Icons.check_box, Icons.check_box_outline_blank, 28.0),
            title: TextField(
              controller: _taskNameController,
              enabled: !disabledEditing,
              focusNode: myFocusNode,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
              onEditingComplete: () => _editingComplete(),
            ),
            trailing: _editButton(),
            children: [
              SubTaskWidget(
                readOnly: disabledEditing,
                editingComplete: _editingComplete,
                checkIconButton:
                    _checkIconButton(Icons.check_circle, Icons.circle_outlined),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Decoration _boxDecoration(){
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

  Widget _checkIconButton(IconData complete, IconData uncompleted,
      [double? size]) {
    return IconButton(
      iconSize: size,
      icon: Icon(widget.task.complete ? complete : uncompleted),
      onPressed: () => _taskComplete(),
    );
  }

  Widget _editButton() {
    return IconButton(
      icon: disabledEditing ? const Icon(Icons.edit) : const Icon(Icons.check),
      color: disabledEditing ? null : Colors.green.withOpacity(0.9),
      onPressed: () {
        if (disabledEditing) {
          setState(() {
            disabledEditing = false;
          });
        } else {
          _editingComplete();
        }
      },
    );
  }

  void _taskComplete() {
    setState(() {
      widget.task.complete
          ? widget.task.complete = false
          : widget.task.complete = true;
    });
  }

  void _editingComplete() {
    if (!disabledEditing) {
      setState(() {
        widget.task.description = _taskNameController.text;
        FocusManager.instance.primaryFocus?.unfocus();
        disabledEditing = true;
      });
    }
  }
}
