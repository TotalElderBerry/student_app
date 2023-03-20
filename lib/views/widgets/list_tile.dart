import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:student_app/views/add_student.dart';

import '../../controllers/student_controller.dart';
import '../../model/student.dart';

class MyListTile extends StatelessWidget {
  Student s;
  StudentController studentController = Get.find();
  MyListTile(this.s);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.person),
      trailing: Wrap(
        children: [
          IconButton(onPressed: (){
            showDialog<String>(
            context: context,
            builder: (BuildContext context) => Dialog(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('Edit Details'),
                    const SizedBox(height: 15),
                    TextField(
                      decoration: InputDecoration(
                        hintText: s.name
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextButton(
                      onPressed: () {
                        studentController.updateStudent(s.id!, Student(name: "updated",course: "bscs",imgPath: "test"));
                        Navigator.pop(context);
                      },
                      child: const Text('Submit'),
                    ),
                  ],
                ),
              ),
            ),
          );
          }, icon: Icon(Icons.edit)),
          IconButton(onPressed: (){
            final snackBar = SnackBar(
            content: const Text('Item Deleted'),
            action: SnackBarAction(
              label: 'Undo',
              onPressed: () {
                studentController.addStudent(s);
              },
            ),
          );

          // Find the ScaffoldMessenger in the widget tree
          // and use it to show a SnackBar.
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
       
            studentController.deleteStudent(s);
          }, icon: Icon(Icons.delete)),
        ],
      ),
      title: Text(s.name),  
      subtitle: Text("BSIT"),
      onTap: ()=>(){
        print("longpressed");
        Get.to(AddStudentPage());
      },
    );
  }
}