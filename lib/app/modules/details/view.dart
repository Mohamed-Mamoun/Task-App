import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:todo_app/app/core/utils/extensions.dart';
import 'package:todo_app/app/data/models/task.dart';
import 'package:todo_app/app/modules/home/controller.dart';

class Detail extends StatelessWidget {
  var homeController = Get.find<HomeController>();
  Detail({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var task = homeController.task.value!;
    var color = HexColor.fromHex(task.color);
    var icon = task.icon;
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(2.5.wp),
            child: Row(
              children: [
              IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_back))
              ],
            ),
          )
        ],
      ),
    );
  }
}