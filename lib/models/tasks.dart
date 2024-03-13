class Task {
  int id;
  bool complete;
  String? name;
  List<Task> subTasks;

  Task({
    required this.id,
    this.complete = false,
    this.name = '',
    this.subTasks = const [],
  });

  @override
  bool operator ==(Object other) =>
      other is Task &&
      other.id == id &&
      other.complete == complete &&
      other.name == name &&
      other.subTasks == subTasks;

  @override
  int get hashCode => Object.hash(id, complete, name, subTasks);
}

List<Task> tasks = [
  Task(
    id: 0,
    name: 'Короткая задача',
  ),
  Task(
    id: 1,
    name:
        'Задача на много текста: текст текст текст текст текст текст текст текст текст текст текст текст ',
  ),
  Task(
    id: 2,
    name: 'Задача на день',
  ),
  Task(
    id: 3,
    name: 'Короткая задача',
  ),
  Task(
    id: 4,
    name:
        'Задача на много текста: текст текст текст текст текст текст текст текст текст текст текст текст ',
  ),
  Task(
    id: 5,
    name: 'Задача на день',
  ),
  Task(
    id: 6,
    name: 'Короткая задача',
  ),
  Task(
    id: 7,
    name:
        'Задача на много текста: текст текст текст текст текст текст текст текст текст текст текст текст ',
  ),
  Task(
    id: 8,
    name: 'Задача на день',
  ),
];
