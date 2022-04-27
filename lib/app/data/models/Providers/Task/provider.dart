import 'dart:convert';

import 'package:get/get.dart';
import 'package:todo_app/app/core/utils/keys.dart';
import 'package:todo_app/app/data/Services/Storage/services.dart';
import 'package:todo_app/app/data/models/task.dart';

class TaskProvider {

  final _storage = Get.find<StorageServices>();
  
  List<Task> readTasks(){
    var tasks = <Task>[];
    jsonDecode(_storage.readData(taskKey).toString()).forEach((e) => tasks.add(Task.fromJson(e)));
    return tasks;
  }

  void writeTasks(List<Task> tasks){
    _storage.writeData(taskKey, jsonEncode(tasks));
  }
}