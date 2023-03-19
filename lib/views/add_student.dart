import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:student_app/controllers/image_picker_controller.dart';
import 'package:student_app/controllers/student_controller.dart';
import 'package:student_app/views/home.dart';

import '../model/student.dart';

class AddStudentPage extends StatelessWidget {
  AddStudentPage({super.key});
  ImagePickerController _imagePickerController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Student"),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        child: SizedBox(
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Obx((){
                if(_imagePickerController.imgPath.value == ''){
                  return IconButton(
                    onPressed: (){
                          _imagePickerController.pickImage();
                        },
                        icon: Icon(Icons.image,size: 100,),
                  );
                }
                return Image.network(_imagePickerController.imgPath.value);
              }),
              TextField(
                decoration: InputDecoration(
                  hintText: "Email"
                ),
              ),
              ElevatedButton.icon(onPressed: (){
                Student s = Student(id:1,name: "test",course: "test",imgPath: "test");
                StudentController studentController = Get.find();
                studentController.addStudent(s);
                Get.to(HomePage());
              }, icon: Icon(Icons.send, ), label: Text("Submit"))
            ],
          ),
        ),
      ),
    );
  }
}