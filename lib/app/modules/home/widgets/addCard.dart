import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:todo_app/app/core/utils/extensions.dart';
import 'package:todo_app/app/core/values/colors.dart';
import 'package:todo_app/app/data/models/task.dart';
import 'package:todo_app/app/modules/home/controller.dart';
import 'package:todo_app/app/widgets/icons.dart';
import 'package:dotted_border/dotted_border.dart';

class AddCard extends StatelessWidget {
  final homeController = Get.find<HomeController>();
  AddCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final icons = getIcons();
    final squareWidth = Get.width - 12.0.wp;
    return Container(
      height: squareWidth / 2,
      width: squareWidth / 2,
      margin: EdgeInsets.all(3.0.wp),
      child: InkWell(
        onTap: () {
          Get.defaultDialog(
            title: 'Task Type',
            radius: 5,
            content: Form(
                key: homeController.formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.0.wp),
                      child: TextFormField(
                        controller: homeController.titleController,
                        decoration: const InputDecoration(
                          labelText: 'Title',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please Enter a Title';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5.0.wp),
                      child: Wrap(
                          spacing: 2.0.wp,
                          children: icons
                              .map((e) => Obx(() {
                                    final index = icons.indexOf(e);
                                    return ChoiceChip(
                                      selectedColor: Colors.grey[300],
                                      pressElevation: 0,
                                      backgroundColor: Colors.white,
                                      label: e,
                                      selected:
                                          homeController.chipIndex.value ==
                                              index,
                                      onSelected: (bool selectedChip) {
                                        homeController.chipIndex.value =
                                            selectedChip ? index : 0;
                                      },
                                    );
                                  }))
                              .toList()),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (homeController.formKey.currentState!.validate()) {
                          int icon = icons[homeController.chipIndex.value]
                              .icon!
                              .codePoint;
                          String color = icons[homeController.chipIndex.value]
                              .color!
                              .toHex();
                          var task = Task(
                              title: homeController.titleController.text,
                              icon: icon,
                              color: color);
                          Get.back();
                          homeController.addTask(task)
                              ? EasyLoading.showSuccess('New Task Added')
                              : EasyLoading.showError('Task Already Exist');
                        }
                      },
                      child: Text(
                        'Confirm',
                        style: TextStyle(
                            fontSize: 16.0.sp, fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        minimumSize: const Size(150, 40),
                      ),
                    )
                  ],
                )),
          );
          homeController.titleController.clear();
          homeController.changeChipIndex(0);
        },
        child: DottedBorder(
          color: Colors.grey[400]!,
          dashPattern: const [8, 4],
          child: Center(
            child: Icon(Icons.add, size: 10.0.wp, color: Colors.grey.shade600),
          ),
        ),
      ),
    );
  }
}
