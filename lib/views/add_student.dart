import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:student_app/controllers/image_picker_controller.dart';
import 'package:student_app/controllers/student_controller.dart';
import 'package:student_app/views/home.dart';

import '../model/student.dart';
import '../sources/db.dart';

class AddStudentPage extends StatelessWidget {
  AddStudentPage({super.key});
  ImagePickerController _imagePickerController = Get.find();
  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
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
                // return Image.network(_imagePickerController.imgPath.value);
                return Image.file(File(_imagePickerController.imgPath.value));
              }),
              const TextField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: "Email"
                ),
              ),
              ElevatedButton.icon(onPressed: () async {
                Student s = Student(name: nameController.text,course: "test",imgPath: _imagePickerController.imgPath.value);
                StudentController studentController = Get.find();

                int id = await StudentDB.instance.addStudent(s);

                s.id = id;

                studentController.addStudent(s);
                
                
                Get.back();
              }, icon: const Icon(Icons.send), label: const Text("Submit"))
            ],
          ),
        ),
      ),
    );
  }
}