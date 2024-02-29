import 'package:flutter/material.dart';
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
  final _taskController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _enabledEditing = true;
    _taskController.addListener(_saveTaskName);
    widget.task.subTasks = [];
  }

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _taskController.text = widget.task.name.toString();
    /*final subTaskChildren = SliverList(
      delegate: SliverChildBuilderDelegate(
            (context, index) {
          return SubTaskWidget(
            task: widget.task.subTasks[index],
            readOnly: _enabledEditing,
            mainTaskComplete: widget.task.complete,
            taskComplete: _taskComplete,
            deleteSubTask: _deleteSubTask,
          );
        },
        childCount: widget.task.subTasks.length,
      ),
    );*/
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
              enabled: !_enabledEditing,
              maxLines: null,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
              decoration: const InputDecoration(hintText: 'Новая задача'),
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

  Widget _underTile() {
    TextStyle underTextStyle() {
      return TextStyle(color: Colors.black.withOpacity(0.5), fontSize: 10);
    }

    return ListTile(
      trailing: IconButton(
        icon: const Icon(Icons.cancel),
        onPressed: () {
          widget.deleteTask(widget.task.id);
        },
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            textAlign: TextAlign.start,
            style: underTextStyle(),
            'добавить',
          ),
          Text(
            textAlign: TextAlign.end,
            style: underTextStyle(),
            'удалить',
          ),
        ],
      ),
      leading: IconButton(
        icon: const Icon(Icons.add),
        onPressed: _addSubTask,
      ),
    );
  }

  Decoration _boxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      border: Border(
        right: BorderSide(
          color: widget.task.complete
              ? Colors.green.withOpacity(0.7)
              : Colors.red.withOpacity(0.7),
          width: 2,
        ),
      ),
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
      icon: _enabledEditing ? const Icon(Icons.edit) : const Icon(Icons.check),
      color: _enabledEditing ? null : Colors.green.withOpacity(0.9),
      onPressed: _switchEditing,
    );
  }

  void _saveTaskName() {
    widget.task.name = _taskController.text.toString();
  }

  void _taskComplete(Task task) {
    setState(() {
      //redrawing 'checkBox/checkMark'
      task.complete = !task.complete;
    });
  }

  void _switchEditing() {
    FocusManager.instance.primaryFocus?.unfocus();
    setState(() {
      //disabled/enabledEditing editing
      _enabledEditing = !_enabledEditing;
    });
  }

  void _addSubTask() {
    setState(() {
      //new subTask
      widget.task.subTasks.add(Task(
        id: widget.task.subTasks.isEmpty ? 0 : widget.task.subTasks.length,
      ));
    });
  }

  void _deleteSubTask(int id) {
    setState(() {
      //delete subTask
      widget.task.subTasks.removeWhere((element) => element.id == id);
    });
  }
}
