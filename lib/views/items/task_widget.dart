import 'package:flutter/material.dart';
import '../../consts/colors.dart';
import '../../model/tasks.dart';
import 'sub_task_widget.dart';

class ToDoWidget extends StatefulWidget {
  const ToDoWidget({super.key, required this.task});

  final Task task;

  @override
  State<ToDoWidget> createState() => ToDoWidgetState();
}

class ToDoWidgetState extends State<ToDoWidget> {
  late FocusNode myFocusNode;
  late bool readOnly;
  final _taskNameController = TextEditingController();
  final _taskDescriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
    readOnly = true;
    _taskNameController.text = widget.task.name.toString();
    _taskDescriptionController.text = widget.task.description.toString();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
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
      ),
      child: ListTileTheme(
        contentPadding: EdgeInsets.zero,
        horizontalTitleGap: 0.0,
        child: TapRegion(
          onTapOutside: (event) => {
            FocusManager.instance.primaryFocus?.unfocus(),
            editingComplete(),
          },
          child: ExpansionTile(
            iconColor: Colors.black,
            textColor: Colors.black,
            shape: const Border(),
            leading: checkIconButton(
                Icons.check_box, Icons.check_box_outline_blank, 28.0),
            title: Theme(
              data: ThemeData(disabledColor: Colors.black),
              child: TextField(
                controller: _taskNameController,
                focusNode: myFocusNode,
                enabled: !readOnly,
                decoration: readOnly
                    ? const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 5))
                    : const InputDecoration(
                    border: UnderlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 5)),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
                onEditingComplete: () => {editingComplete()},
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Visibility(
                  visible: !readOnly,
                  child: IconButton(
                    icon: const Icon(Icons.check),
                    color: Colors.green.withOpacity(0.7),
                    onPressed: () {
                      editingComplete();
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    //myFocusNode.requestFocus();
                    if (readOnly) {
                      setState(() {
                        readOnly = false;
                      });
                    }
                  },
                ),
              ],
            ),
            children: [
              ListTile(
                leading:
                    checkIconButton(Icons.check_circle, Icons.circle_outlined),
                title: Container(
                  decoration: BoxDecoration(
                    color: tdBGColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: TextField(
                    controller: _taskDescriptionController,
                    //focusNode: myFocusNode,
                    readOnly: readOnly,
                    decoration: readOnly
                        ? const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: 5))
                        : const InputDecoration(
                            border: UnderlineInputBorder(),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 5)),
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                    onEditingComplete: () => {editingComplete()},
                  ),
                ),
                trailing: const SizedBox(),
              ), //sub tasks
            ],
          ),
        ),
      ),
    );
  }

  Widget checkIconButton(IconData complete, IconData uncompleted, [size]) {
    return IconButton(
      iconSize: size,
      icon: Icon(widget.task.complete ? complete : uncompleted),
      onPressed: () {
        setState(() {
          widget.task.complete
              ? widget.task.complete = false
              : widget.task.complete = true;
        });
      },
    );
  }

  void editingComplete() {
    setState(() {
      readOnly = true;
      widget.task.description = _taskNameController.text;
    });
  }
}
