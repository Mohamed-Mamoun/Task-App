import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/app/core/utils/extensions.dart';
import 'package:todo_app/app/modules/home/controller.dart';

class DoneTodo extends StatelessWidget {
  final homeController = Get.find<HomeController>();
  DoneTodo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => homeController.doneTodo.isNotEmpty
        ? ListView(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            children: [
              ...homeController.doneTodo.map((element) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
                    child: Dismissible(
                      onDismissed: (_) {
                        homeController.deleteTodo(element);
                      },
                      direction: DismissDirection.endToStart,
                      key: ObjectKey(element),
                      background: Container(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(right: 3.0.wp),
                          color: Colors.red.withOpacity(0.8),
                          child: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          )),
                      child: Row(
                        children: [
                          const SizedBox(
                              height: 40,
                              width: 25,
                              child: Icon(
                                Icons.check,
                                color: Colors.blue,
                              )),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 3.0.wp),
                            child: Text(
                              element['title'],
                              style: TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.0.sp),
                            ),
                          )
                        ],
                      ),
                    ),
                  ))
            ],
          )
        : Container());
  }
}
