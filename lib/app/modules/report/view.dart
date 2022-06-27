import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:todo_app/app/core/values/colors.dart';
import 'package:todo_app/app/modules/home/controller.dart';
import 'package:todo_app/app/core/utils/extensions.dart';
import 'package:intl/intl.dart';

class ReportPage extends StatelessWidget {
  final homeController = Get.find<HomeController>();
  ReportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(
      child: Obx(() {
        var createdTasks = homeController.getTotalTask();
        var doneTasks = homeController.totalDoneTask();
        var liveTasks = createdTasks - doneTasks;
        var percent = (doneTasks / createdTasks * 100).toStringAsFixed(0);

        return ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(3.0.wp),
              child: Text(
                'My Report',
                style:
                    TextStyle(fontSize: 22.0.sp, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.0.wp),
              child: Text(
                DateFormat.yMMMMd().format(DateTime.now()),
                style: TextStyle(color: Colors.grey, fontSize: 16.0.sp),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 3.0.wp, vertical: 3.0.wp),
              child: const Divider(
                thickness: 2,
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(vertical: 3.0.wp, horizontal: 5.0.wp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStatus(Colors.green, liveTasks, 'Live Tasks'),
                  _buildStatus(Colors.orange, doneTasks, 'Completed'),
                  _buildStatus(Colors.blue, createdTasks, 'Created')
                ],
              ),
            ),
            SizedBox(
              height: 15.0.wp,
            ),
            UnconstrainedBox(
              child: SizedBox(
                height: 70.0.wp,
                width: 70.0.wp,
                child: CircularStepProgressIndicator(
                  totalSteps: createdTasks == 0 ? 1 : createdTasks,
                  currentStep: doneTasks,
                  stepSize: 20,
                  selectedColor: green,
                  unselectedColor: Colors.grey[200],
                  padding: 0,
                  width: 150,
                  height: 150,
                  selectedStepSize: 22,
                  roundedCap: (_, __) => true,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${createdTasks == 0 ? 0 : percent + '%'}',
                        style: TextStyle(
                            fontSize: 20.0.sp, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Efficientcy',
                        style: TextStyle(
                            fontSize: 16.0.sp,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    ));
  }
}

Row _buildStatus(Color color, int number, String text) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        height: 3.0.wp,
        width: 3.0.wp,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 0.5.wp, color: color)),
      ),
      SizedBox(
        width: 3.0.wp,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$number',
            style: TextStyle(
              fontSize: 16.0.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 2.0.wp,
          ),
          Text(
            text,
            style: TextStyle(color: Colors.grey, fontSize: 12.0.sp),
          )
        ],
      ),
    ],
  );
}
