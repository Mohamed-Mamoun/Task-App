import 'package:flutter/cupertino.dart';
import 'package:todo_app/app/data/Services/Storage/repository.dart';
import 'package:todo_app/app/data/models/task.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  TaskRepository taskRepository;
  HomeController({required this.taskRepository});

  final tasks = <Task>[].obs;
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final chipIndex = 0.obs;
  final delete = false.obs;
  final task = Rx<Task?>(null);

  @override
  void onInit() {
    super.onInit();
    tasks.assignAll(taskRepository.readTasks());
    ever(tasks, (_) => taskRepository.writeTasks(tasks));
  }

  @override
  void onClose() {
    titleController.dispose();
    // TODO: implement onClose
    super.onClose();
  }

  void changeChipIndex(int newValue) {
    chipIndex.value = newValue;
  }
  
  bool addTask(Task task){
    if(tasks.contains(task)){
      return false;
    } 
    tasks.add(task);
    return true;
  }

  void changeDelete(bool value){
    delete.value = value;
  }

  void deleteTask(Task task) {
    tasks.remove(task);
  }
  void changeTask(Task? taskSelected){
   task.value = taskSelected;
  }

  updateTask(Task task, String text) {
    var todos = task.todoList ?? [];
    if(containTodo(todos, text)){
      return false;
    }
    var todo = {'title': text, 'done': false};
    todos.add(todo);
    var newTask = task.copywith(todoList: todos);
    int oldIndex = tasks.indexOf(task);
    tasks[oldIndex] = newTask;
    tasks.refresh();
    return true;
  }

  bool containTodo(List todos, String text) {
    return todos.any((element) => element['title'] == text);
  }
}
