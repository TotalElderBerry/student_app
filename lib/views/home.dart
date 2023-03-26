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
    StudentController _studentController = Get.find();
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32)),
                  borderSide: BorderSide.none
                ),
                contentPadding: EdgeInsets.all(16),
                hintText: "Search",
                suffixIcon: Padding(
                  padding: EdgeInsets.only(right: 16.0),
                  child: Icon(Icons.search),
                ),
              ),
              onChanged: (val){
                search.value = val;
                Get.find<StudentController>().filterStudentFromStr(search.value);
                print(search.value);
              },
            ),
          ),
          Expanded(
            child: 

            Obx((){
             return FutureBuilder(
                future: Get.find<StudentController>().getStudents(search.value),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
              print("rendered");
                  if(!snapshot.hasData){
                    return const Center(
                      // child: Text("Loading"),
                      child: CircularProgressIndicator()
                    );
                  }
                  // print("home");
                  // print(Get.find<StudentController>().students);
                  // Get.find<StudentController>().setAllStudent(snapshot.data);
                  return Obx(()  {
                  if(Get.find<StudentController>().students.isEmpty){
                    return const Center(
                      child: Text("No Items"),
                    );
                  }
                    return ListView.builder(
                            itemCount: Get.find<StudentController>().students.length,
                            itemBuilder: (context, index) {
                            return MyListTile(
                                Get.find<StudentController>().students[index]);
                            });
                  });
                }   
            );
            })
                         
            )
        ])
    );
  }
}
