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


class AddStudentPage extends StatefulWidget {
  AddStudentPage({super.key});

  @override
  State<AddStudentPage> createState() => _AddStudentPageState();
}

class _AddStudentPageState extends State<AddStudentPage> {
  final List<String> list = <String>['BSIT', 'BSCS', 'BSCRIM', 'BSIS'];

  ImagePickerController _imagePickerController = Get.find();


  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String dropDownvalue = list.first;
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
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: "Email"
                ),
              ),
                DropdownButton<String>(
                  value: dropDownvalue,
                  icon: const Icon(Icons.arrow_downward),
                  items: list.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? value){
                      setState(() {
                        dropDownvalue = value!;
                      });
                  }
                ),
              ElevatedButton.icon(onPressed: () async {
                Student s = Student(name: nameController.text,course:dropDownvalue,imgPath: _imagePickerController.imgPath.value);
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