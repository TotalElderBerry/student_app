import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_app/controllers/student_controller.dart';
import 'package:student_app/sources/db.dart';

import '../model/student.dart';
import 'add_student.dart';
import 'widgets/list_tile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  
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
        body: Column(children: [
          Expanded(
            child: FutureBuilder(
                future: StudentDB.instance.getStudents(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  Obx((){
                    if (snapshot.hasData) {
                      print(snapshot.hasData);
                      Get.find<StudentController>().setAllStudent(snapshot.data!);
                      if(Get.find<StudentController>().students.isNotEmpty){
                        ListView.builder(
                            itemCount: Get.find<StudentController>().students.length,
                            itemBuilder: (context, index) {
                              return MyListTile(
                                  Get.find<StudentController>().students[index]);
                            });
                      }else{
                      }
                    }
                        return const Center(
                          child: Text("WAY DATA"),
                        );
                  });
                    return const Center(
                      child: Text("WAY DATA"),
                    );
                }
            )
          )
        ])
    );
  }
}
