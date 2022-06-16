import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:todo_app/app/core/utils/extensions.dart';
import 'package:todo_app/app/modules/details/widgets/doingList.dart';
import 'package:todo_app/app/modules/details/widgets/doneTodo.dart';
import 'package:todo_app/app/modules/home/controller.dart';

class Detail extends StatelessWidget {
  final homeController = Get.find<HomeController>();
  Detail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var task = homeController.task.value!;
    var color = HexColor.fromHex(task.color);
    var icon = task.icon;
    return Scaffold(
        body: ListView(children: [
      Padding(
        padding: EdgeInsets.all(2.5.wp),
        child: Row(
          children: [
            IconButton(
                onPressed: () {
                  Get.back();
                  homeController.updateTodos(task);
                  homeController.changeTask(null);
                },
                icon: const Icon(Icons.arrow_back)),
          ],
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.0.wp),
        child: Row(
          children: [
            Icon(
              IconData(icon, fontFamily: 'MaterialIcons'),
              color: color,
            ),
            SizedBox(
              width: 3.0.wp,
            ),
            Text(
              task.title,
              style: TextStyle(fontSize: 18.0.sp, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
      Obx(() {
        var totalTodo =
            homeController.doingTodo.length + homeController.doneTodo.length;
        return Padding(
          padding: EdgeInsets.only(left: 15.0.wp, top: 5.0.wp, right: 15.0.wp),
          child: Row(
            children: [
              Text(
                '$totalTodo Task',
                style: TextStyle(
                    fontSize: 12.0.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
              SizedBox(width: 3.0.wp),
              Expanded(
                  child: StepProgressIndicator(
                totalSteps: totalTodo == 0 ? 1 : totalTodo,
                currentStep: homeController.doneTodo.length,
                size: 5,
                padding: 0,
                selectedGradientColor: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [color.withOpacity(0.5), color]),
                unselectedGradientColor: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.grey[300]!, Colors.grey[300]!]),
              ))
            ],
          ),
        );
      }),
      Form(
        key: homeController.formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 3.0.wp, horizontal: 5.0.wp),
          child: TextFormField(
            controller: homeController.titleController,
            autofocus: true,
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.check_box_outline_blank_outlined),
                suffixIcon: IconButton(
                    onPressed: () {
                      if (homeController.formKey.currentState!.validate()) {
                        var success = homeController
                            .addTodo(homeController.titleController.text);
                        if (success) {
                          EasyLoading.showSuccess('Added Successfully');
                        } else {
                          EasyLoading.showError('Already Exists');
                        }
                        homeController.titleController.clear();
                      }
                    },
                    icon: const Icon(Icons.done))),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Write Your Todo';
              }
            },
          ),
        ),
      ),
      DoingList(),
      DoneTodo()
    ]));
  }
}
