import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
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
  final doingTodo = [].obs;
  final doneTodo = [].obs;

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

  void changeTodo(List<dynamic> selectedTodo){
    doingTodo.clear();
    doneTodo.clear();
    for(int i = 0; i < selectedTodo.length ; i++){
      var todo = selectedTodo[i];
      var status = todo['done'];
      if(status){
        doneTodo.add(todo);
      }else{
        doingTodo.add(todo);
      }
    }
  }
  bool addTodo(String title){
    var todo = {'title': title, 'done': false};
    if(doingTodo.any((element) => mapEquals(todo, element))){
      return false;
    }
    var doneTodo = {'title': title, 'done': true};
    if(doingTodo.any((element) => mapEquals(doneTodo, element))){
      return false;
    }
    doingTodo.add(todo);
    return true;
  }
  void updateTodos(Task task){
    var newTodos = <Map<String, dynamic>>[];
    newTodos.addAll([...doingTodo, ...doneTodo]);
    var newTask = task.copywith(todoList: newTodos);
    int oldIndex = tasks.indexOf(task);
    tasks[oldIndex] = newTask;
    tasks.refresh();
  }

  void done_Todo(String title){
    var doing_todo = {'title': title, 'done':false};
    int index = doingTodo.indexWhere((element) => mapEquals<String, dynamic>(doing_todo, element));
    doingTodo.removeAt(index);
    var done_Todo = {'title': title, 'done':true};
    doneTodo.add(done_Todo);
    doingTodo.refresh();
    doneTodo.refresh();
  }

   void deleteTodo(dynamic doneTodoItem) {
    var index = doneTodo.indexWhere((element) => mapEquals<String, dynamic>(doneTodoItem, element));
    doneTodo.removeAt(index);
    doneTodo.refresh();
   }
}
