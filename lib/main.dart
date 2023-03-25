import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_app/controllers/image_picker_controller.dart';
import 'package:student_app/controllers/student_controller.dart';
import 'package:student_app/sources/db.dart';
import 'package:student_app/themes/theme.dart';
import 'package:student_app/views/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await StudentDB.initializeDatabase();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ImagePickerController());
    Get.put(StudentController());

    return GetMaterialApp(
      theme: ThemeData(useMaterial3: true,colorScheme: darkColorScheme),
      home: HomePage(),
    );
  }
}