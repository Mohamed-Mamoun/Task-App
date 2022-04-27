import 'package:get/get.dart';
import 'package:todo_app/app/data/Services/Storage/repository.dart';
import 'package:todo_app/app/data/models/Providers/Task/provider.dart';
import 'package:todo_app/app/modules/home/controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController(
        taskRepository: TaskRepository(taskProvider: TaskProvider())));
  }
}
