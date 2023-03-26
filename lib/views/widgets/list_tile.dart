import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:student_app/sources/db.dart';
import 'package:student_app/views/add_student.dart';

import '../../controllers/student_controller.dart';
import '../../model/student.dart';

class MyListTile extends StatefulWidget {
  Student s;
  MyListTile(this.s);

  @override
  State<MyListTile> createState() => _MyListTileState();
}

class _MyListTileState extends State<MyListTile> {
  StudentController studentController = Get.find();
  final List<String> nlist = <String>['BSIT', 'BSCS', 'BSCRIM', 'BSIS'];

  final updateNameController = TextEditingController();
  String dropDownvalue = "BSIT";
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        child: Align(
          alignment: Alignment.center,
           widthFactor: 1,
          heightFactor: 1.0,
          child: Image.file(File(widget.s.imgPath)),
        ),
      )
      
      ,
      trailing: Wrap(
        children: [
          IconButton(onPressed: (){
            showDialog<String>(
            context: context,
            builder: (BuildContext context) => StatefulBuilder(
              builder: (context, setStateSB) {
                return Dialog(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text('Edit Details'),
                        const SizedBox(height: 15),
                        TextField(
                          controller: updateNameController,
                          decoration: InputDecoration(
                            hintText: widget.s.name
                          ),
                        ),
                        DropdownButton<String>(
                          value: dropDownvalue,
                          icon: const Icon(Icons.arrow_downward),
                          items: nlist.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? value){
                              setStateSB(() {
                                dropDownvalue = value!;
                                print(dropDownvalue);
                              });
                          }
                        ),
                        const SizedBox(height: 15),
                        TextButton(
                          onPressed: () {
                            Student s = Student(name: updateNameController.text,course: 
                            dropDownvalue,imgPath: widget.s.imgPath);
                            s.id = widget.s.id;
                            studentController.updateStudent(widget.s.id!, s);
                            StudentDB.instance.updateStudent(s);
                            // print(s.id);
                            Navigator.pop(context);
                          },
                          child: const Text('Submit'),
                        ),
                      ],
                    ),
                  ),
                );
              }
            ),
          );
          }, icon: Icon(Icons.edit)),
          
          IconButton(onPressed: (){
            final snackBar = SnackBar(
            content: const Text('Item Deleted'),
            action: SnackBarAction(
              label: 'Undo',
              onPressed: () {
                studentController.addStudent(widget.s);
                StudentDB.instance.addStudent(widget.s);
              },
            ),
          );

          // Find the ScaffoldMessenger in the widget tree
          // and use it to show a SnackBar.
           ScaffoldMessenger.of(context).showSnackBar(snackBar);
            StudentDB.instance.deleteStudent(widget.s);
            studentController.deleteStudent(widget.s);
          }, icon: const Icon(Icons.delete)),
        ],
      ),
      title: Text(widget.s.name),  
      subtitle: Text(widget.s.course),
      onTap: ()=>(){
        print("longpressed");
        Get.to(AddStudentPage());
      },
    );
  }
}