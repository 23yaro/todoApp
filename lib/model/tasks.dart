
class Task {
  int id;
  bool complete;
  String? name;
  List<Task> subTasks;

  Task({
    required this.id ,
    this.complete = false,
    this.name ='',
    this.subTasks = const [],
  });
}
