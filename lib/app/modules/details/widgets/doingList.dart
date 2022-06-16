import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/app/core/utils/extensions.dart';
import 'package:todo_app/app/modules/home/controller.dart';

class DoingList extends StatelessWidget {
  final homeController = Get.find<HomeController>();
  DoingList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => homeController.doingTodo.isEmpty &&
            homeController.doneTodo.isEmpty
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 15.0.hp,
              ),
              Image.asset(
                'assets/images/task.jpeg',
                fit: BoxFit.cover,
                width: 65.0.wp,
              ),
              SizedBox(
                height: 5.0.hp,
              ),
              Text(
                'Add Tasks',
                style:
                    TextStyle(fontSize: 15.0.sp, fontWeight: FontWeight.bold),
              )
            ],
          )
        : ListView(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            children: [
              ...homeController.doingTodo
                  .map((element) => Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 9.0.wp, vertical: 2.5.wp),
                        child: Row(
                          children: [
                            SizedBox(
                              height: 20,
                              width: 20,
                              child: Checkbox(
                                onChanged: (value) {
                                  homeController.done_Todo(element['title']);
                                },
                                value: element['done'],
                              ),
                            ),
                            SizedBox(
                              width: 4.0.wp,
                            ),
                            Text(
                              element['title'],
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.0.sp),
                            ),
                            Divider(
                              thickness: 4.5,
                              indent: 5.0.wp,
                              endIndent: 5.0.wp,
                            ),
                          ],
                        ),
                      ))
                  .toList()
            ],
          ));
  }
}
