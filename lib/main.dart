import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_app/controllers/image_picker_controller.dart';
import 'package:student_app/themes/theme.dart';
import 'package:student_app/views/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  ImagePickerController imgController = Get.put(ImagePickerController());
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(useMaterial3: true,colorScheme: darkColorScheme),
      home: HomePage(),
    );
  }
}