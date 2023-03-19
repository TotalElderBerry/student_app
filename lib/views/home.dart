import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'add_student.dart';
import 'widgets/list_tile.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

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
          child: ListView.builder(
            itemCount: 3,
            itemBuilder: (context,index){
              return MyListTile();
          }),
        )
      ]),
    );
  }
}