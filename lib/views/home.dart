import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_app/controllers/student_controller.dart';
import 'package:student_app/sources/db.dart';

import '../model/student.dart';
import 'add_student.dart';
import 'widgets/list_tile.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  RxString search = "".obs;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Student App"),
          actions: [
            IconButton(
                onPressed: () {
                  Get.to(AddStudentPage());
                },
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                ))
          ],
        ),
        body: 
        Column(children: [
          Expanded(
              child: Obx(() {
               return FutureBuilder(
                  // Set students from datbase and set students to the controller
                  future: Get.find<StudentController>().getStudents(search.value),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: Text("Nag kuha pa og data...")
                      );
                    }
          
                    if (Get.find<StudentController>().students.isEmpty) {
                      return const Center(
                        child: Text("Waw pay students...")
                      );
                    }
          
                    return Obx(()  {
                      return ListView.builder(
                              itemCount: Get.find<StudentController>().students.length,
                              itemBuilder: (context, index) {
                                return MyListTile(
                                    Get.find<StudentController>().students[index]);
                              });
                    });
                  },
                );
              })
            )
        ])
    );
  }
}
