import 'package:flutter/material.dart';

import '../../model/Task.dart';

class ToDoWidget extends StatefulWidget {
  const ToDoWidget({super.key, required this.task});

  final Task task;

  @override
  State<ToDoWidget> createState() => ToDoWidgetState();
}

class ToDoWidgetState extends State<ToDoWidget> {
  late FocusNode myFocusNode;
  late bool readOnly;
  final _taskDescriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    readOnly = true;
    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _taskDescriptionController.text = widget.task.description.toString();
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border(
            right: BorderSide(color: Colors.red.withOpacity(0.7), width: 2)),
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
        dense: true,
        horizontalTitleGap: 0.0,
        minLeadingWidth: 0,
        child: ExpansionTile(
          shape: const Border(),
          trailing: const SizedBox.shrink(),
          leading: IconButton(
            icon: Icon(widget.task.complete
                ? Icons.check_circle
                : Icons.circle_outlined),
            onPressed: () {},
          ),
          title: Text(widget.task.name ?? ''),
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                title: TextField(
                  readOnly: readOnly,
                  decoration: const InputDecoration(border: InputBorder.none),
                  controller: _taskDescriptionController,
                  focusNode: myFocusNode,
                  onTapOutside: (event) {
                    FocusManager.instance.primaryFocus?.unfocus();
                    setState(() {
                      readOnly = true;
                      widget.task.description = _taskDescriptionController.text;
                    });
                  },
                  onEditingComplete: () => {
                    setState(() {
                      readOnly = true;
                      widget.task.description = _taskDescriptionController.text;
                    })
                  },
                ),
                trailing: GestureDetector(
                  onTap: () => {
                    myFocusNode.requestFocus(),
                    setState(() {
                      readOnly = false;
                    })
                  },
                  child: Container(
                    height: 20,
                    width: 20,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
