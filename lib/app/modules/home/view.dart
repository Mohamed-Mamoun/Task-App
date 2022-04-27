import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:todo_app/app/core/values/colors.dart';
import 'package:todo_app/app/data/models/task.dart';
import 'package:todo_app/app/modules/home/controller.dart';
import 'package:todo_app/app/core/utils/extensions.dart';
import 'package:todo_app/app/modules/home/widgets/addCard.dart';
import 'package:todo_app/app/modules/home/widgets/add_dialog.dart';
import 'package:todo_app/app/modules/home/widgets/taskCard.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.all(4.0.wp),
                child: Text(
                  'My List',
                  style:
                      TextStyle(fontSize: 24.0.sp, fontWeight: FontWeight.bold),
                ),
              ),
              Obx(
                () => GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  children: [
                    ...controller.tasks
                        .map((element) => LongPressDraggable(
                          data: element,
                            onDragStarted: () => controller.changeDelete(true),
                            onDraggableCanceled: (_, __) =>
                                controller.changeDelete(false),
                            onDragEnd: (_) => controller.changeDelete(false),
                            feedback: Opacity(
                              opacity: 0.8,
                              child: TaskCard(task: element),
                            ),
                            child: TaskCard(task: element)))
                        .toList(),
                    AddCard(),
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: DragTarget<Task>(
          onAccept: (Task task){
            controller.deleteTask(task);
            EasyLoading.showSuccess('Task Deleted');
          },
          builder: ((context, candidateData, rejectedData) {
            return Obx(() => FloatingActionButton(
                  backgroundColor:
                      controller.delete.value ? Colors.red[500] : blue,
                  onPressed: () {
                    Get.to(() => AddDialog(), transition: Transition.downToUp);
                  },
                  child:
                      Icon(controller.delete.value ? Icons.delete : Icons.add),
                ));
          }),
        ));
  }
}
