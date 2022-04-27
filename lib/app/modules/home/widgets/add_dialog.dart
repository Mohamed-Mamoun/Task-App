import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:todo_app/app/core/utils/extensions.dart';
import 'package:todo_app/app/modules/home/controller.dart';

class AddDialog extends StatelessWidget {
  final homeController = Get.find<HomeController>();
  AddDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: homeController.formKey,
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(3.0.wp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                      homeController.titleController.clear();
                      homeController.changeTask(null);
                    },
                    icon: const Icon(Icons.close),
                  ),
                  TextButton(
                    onPressed: () {
                      if(homeController.formKey.currentState!.validate()){
                        if(homeController.task.value == null){
                          EasyLoading.showError('Please Select Task Type');
                        } else {
                          var success = homeController.updateTask(
                            homeController.task.value!,
                            homeController.titleController.text
                          );
                          if (success){
                            EasyLoading.showSuccess('Task Added Successfully');
                             Get.back();
                             homeController.titleController.clear();
                             homeController.changeTask(null);
                          }else{
                            EasyLoading.showError('Task Already Exist');
                          }
                        }
                      }
                    },
                    child: Text(
                      'Done',
                      style: TextStyle(fontSize: 15.0.sp),
                    ),
                    style: ButtonStyle(
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent)),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 5.0.wp),
              child: Text(
                'New Task',
                style:
                    TextStyle(fontSize: 20.0.sp, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
              child: TextFormField(
                controller: homeController.titleController,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[500]!)),
                ),
                autofocus: true,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please write Your Task';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 5.0.wp,
                top: 3.0.wp,
                bottom: 5.0.wp,
              ),
              child: Text('Add To',
              style: TextStyle(
                fontSize: 15.0.sp,
                color: Colors.grey
              ),
              ),
              ),
            ...homeController.tasks
                .map((element) => Obx(
                  () => InkWell(
                    onTap: (){
                      homeController.changeTask(element);
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.0.wp, vertical: 3.0.wp),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                             Row(
                               children: [
                                  Icon(IconData(element.icon, fontFamily: 'MaterialIcons'), color: HexColor.fromHex(element.color),),
                              SizedBox(width: 4.0.wp,),
                              Text(element.title, style: TextStyle(fontSize:15.0.sp, fontWeight: FontWeight.bold))
                               ],
                             ),
                             if(homeController.task.value == element)
                             const Icon(Icons.check, color: Colors.green)
                            ],
                          ),
                    ),
                  ),
                ))
                .toList()
          ],
        ),
      ),
    );
  }
}
