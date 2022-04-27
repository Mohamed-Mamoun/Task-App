import 'package:todo_app/app/data/models/Providers/Task/provider.dart';
import 'package:todo_app/app/data/models/task.dart';

class TaskRepository {
  
  TaskProvider taskProvider;
  TaskRepository({required this.taskProvider});

  List<Task> readTasks() => taskProvider.readTasks();
  void writeTasks(List<Task> tasks) => taskProvider.writeTasks(tasks);
}
