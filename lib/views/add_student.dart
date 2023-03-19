import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:student_app/controllers/image_picker_controller.dart';

class AddStudentPage extends StatelessWidget {
  AddStudentPage({super.key});
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
              IconButton(
                onPressed: (){
                },
                icon: Icon(Icons.image,size: 100,),
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: "Email"
                ),
              ),
              ElevatedButton.icon(onPressed: (){}, icon: Icon(Icons.send, ), label: Text("Submit"))
            ],
          ),
        ),
      ),
    );
  }
}