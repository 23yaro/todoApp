import 'package:flutter/material.dart';
import '../../consts/colors.dart';
import '../../consts/strings.dart';
import '../../model/tasks.dart';
import 'sub_task_widget.dart';

class TaskWidget extends StatefulWidget {
  final Task task;
  final void Function(int) deleteTask;

  const TaskWidget({
    super.key,
    required this.task,
    required this.deleteTask,
  });

  @override
  State<TaskWidget> createState() => TaskWidgetState();
}

class TaskWidgetState extends State<TaskWidget> {
  late bool _enabledEditing;
  late TextEditingController taskController;
  late FocusNode taskFocusNode;

  @override
  void initState() {
    super.initState();
    _enabledEditing = true;
    taskController = TextEditingController();
    taskController.addListener(_saveTaskName);
    taskFocusNode = FocusNode();
    taskFocusNode.requestFocus();
    widget.task.subTasks = [];
  }

  @override
  void dispose() {
    taskController.dispose();
    taskFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    taskController.text = widget.task.name.toString();
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: _boxDecoration(),
      child: ListTileTheme(
        contentPadding: EdgeInsets.zero,
        horizontalTitleGap: 0.0,
        child: TapRegion(
          onTapOutside: (event) {
            if (!_enabledEditing) {
              _switchEditing();
            }
          },
          child: ExpansionTile(
            iconColor: tdBlack,
            textColor: tdBlack,
            shape: const Border(),
            leading: IconButton(
              iconSize: 28,
              icon: Icon(widget.task.complete
                  ? Icons.check_box
                  : Icons.check_box_outline_blank),
              onPressed: () => _taskComplete(widget.task),
            ),
            title: TextField(
              controller: taskController,
              enabled: !_enabledEditing,
              focusNode: taskFocusNode,
              maxLines: null,
              style: const TextStyle(
                color: tdBlack,
                fontSize: 16,
              ),
              decoration: const InputDecoration(hintText: taskWidget),
              onEditingComplete: () => _switchEditing(),
            ),
            trailing: _editButton(widget.task),
            children: [
              ListView.builder(
                itemCount: widget.task.subTasks.length,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return SubTaskWidget(
                    task: widget.task.subTasks[index],
                    readOnly: _enabledEditing,

                    ///debug
                    mainTaskComplete: widget.task.complete,
                    taskComplete: _taskComplete,
                    deleteSubTask: _deleteSubTask,
                  );
                },
              ),
              _underTile(),
            ],
          ),
        ),
      ),
    );
  }

  Decoration _boxDecoration() {
    return BoxDecoration(
      color: tdWhite,
      border: Border(
        right: BorderSide(
          color: widget.task.complete
              ? tdGreen
              : tdRed,
          width: 2,
        ),
      ),
      borderRadius: BorderRadius.circular(10),
      boxShadow: const [
        BoxShadow(
          color: tdGrey,
          spreadRadius: 2,
          blurRadius: 6,
        )
      ],
    );
  }

  Widget _underTile() {
    return ListTile(
      leading: Visibility(
        visible: !widget.task.complete,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: _addSubTask,
            ),
            const Text(
              textAlign: TextAlign.end,
              style:
                  TextStyle(color: tdBlack, fontSize: 10),
              taskWidgetAdd,
            ),
          ],
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            textAlign: TextAlign.start,
            style:
                TextStyle(color: tdBlack, fontSize: 10),
            taskWidgetRemove,
          ),
          IconButton(
            icon: const Icon(Icons.cancel),
            onPressed: () {
              widget.deleteTask(widget.task.id);
            },
          ),
        ],
      ),
    );
  }

  Widget _editButton(Task task) {
    return IconButton(
      icon: _enabledEditing ? const Icon(Icons.edit) : const Icon(Icons.check),
      color: _enabledEditing ? null : tdGreen,
      onPressed: _switchEditing,
    );
  }

  void _saveTaskName() {
    widget.task.name = taskController.text.toString().trim();
  }

  void _taskComplete(Task task) {
    ///not set state to sub task  if main task complete
    if (widget.task == task) {
      setState(() {
        ///redrawing 'main checkBox/checkMark'
        task.complete = !task.complete;
      });
    } else {
      if (!widget.task.complete) {
        setState(() {
          ///redrawing 'sub checkBox/checkMark'
          task.complete = !task.complete;
        });
      }
    }
  }

  void _switchEditing() {
    FocusManager.instance.primaryFocus?.unfocus();
    setState(() {
      ///disabled/enabledEditing editing
      _enabledEditing = !_enabledEditing;
    });
  }

  void _addSubTask() {
    setState(() {
      ///new subTask
      FocusManager.instance.primaryFocus?.unfocus();
      widget.task.subTasks.add(Task(
        id: widget.task.subTasks.isEmpty ? 0 : widget.task.subTasks.length,
      ));
      if (_enabledEditing) {
        _switchEditing();
      }
    });
  }

  void _deleteSubTask(int id) {
    setState(() {
      ///delete subTask
      widget.task.subTasks.removeWhere((element) => element.id == id);
    });
  }
}
