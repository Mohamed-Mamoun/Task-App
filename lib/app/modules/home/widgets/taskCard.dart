import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/app/core/utils/extensions.dart';
import 'package:todo_app/app/data/models/task.dart';
import 'package:todo_app/app/modules/details/view.dart';
import 'package:todo_app/app/modules/home/controller.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class TaskCard extends StatelessWidget {
  final homeController = Get.find<HomeController>();
  Task task;
  TaskCard({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var squareWidth = Get.width - 12.0.wp;
    final color = HexColor.fromHex(task.color);
    return GestureDetector(
      onTap: (){
        Get.to(()=> Detail());
        homeController.changeTask(task);
        homeController.changeTodo(task.todoList ?? []);
      },
      child: Container(
        width: squareWidth / 2,
        height: squareWidth / 2,
        margin: EdgeInsets.all(3.0.wp),
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
              offset: const Offset(0, 7), blurRadius: 7, color: Colors.grey[400]!)
        ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [StepProgressIndicator(
            totalSteps: 100,
            currentStep: 80,
            size: 5,
            padding: 0,
            selectedGradientColor: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.bottomRight,
              colors: [color.withOpacity(0.5), Colors.white]
            ),
            unselectedGradientColor: const LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.bottomRight,
              colors: [Colors.white, Colors.white]
            ),
            ),
            Padding(
              padding: EdgeInsets.all(3.0.wp),
              child: Icon(IconData(task.icon,fontFamily: 'MaterialIcons'), color: 
              color),
            ),
            Padding(
              padding: EdgeInsets.all(3.0.wp),
              child: Text(task.title,
               style: TextStyle(
                 fontSize: 14.0.sp,
                 fontWeight: FontWeight.bold
               ),),
            ),
            SizedBox(
              height: 10.0.wp,
            ),
             Padding(
              padding: EdgeInsets.only(left: 25.0.wp),
              child: Text('${task.todoList?.length ?? 0} Task',
               style: TextStyle(
                 fontSize: 12.0.sp,
                 fontWeight: FontWeight.w500,
                 
               ),),
            )
            ],
            
        ),
      ),
    );
  }
}
