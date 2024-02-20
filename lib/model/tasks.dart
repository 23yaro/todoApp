
class Task {
  int id;
  bool complete;
  String? name;
  String? description;
  List<Task>? subTasks;
  //DateTime dateTime;

  Task({
    required this.id ,
    this.complete = false,
    this.name = 'name',
    this.description = 'description',
    this.subTasks,
    //required this.dateTime,
  });
}
