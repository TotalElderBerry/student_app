import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_app/controllers/student_controller.dart';

import '../model/student.dart';
import 'add_student.dart';
import 'widgets/list_tile.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  StudentController _studentController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Student App"),
        actions: [
          IconButton(onPressed: (){
            Get.to(AddStudentPage());
          }, icon: Icon(
            Icons.add,
            color: Colors.white,
          ))
        ],
      ),
      body: Column(children: [
        Expanded(
          child: Obx((){
            return ListView.builder(
              itemCount: _studentController.students.length,
              itemBuilder: (context,index){
              return MyListTile(_studentController.students[index]);
            });
          })
        )
      ]),
    );
  }
}