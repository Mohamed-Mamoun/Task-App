import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:todo_app/app/data/Services/Storage/services.dart';
import 'package:todo_app/app/modules/home/binding.dart';
import 'package:todo_app/app/modules/home/view.dart';
import 'package:get_storage/get_storage.dart';

void main() async{
  await GetStorage.init();
  await Get.putAsync(() => StorageServices().init(),);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      initialBinding: HomeBinding(),
      builder: EasyLoading.init(),

    );
  }
}
