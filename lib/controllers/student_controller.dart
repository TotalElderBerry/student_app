import 'package:get/get.dart';
import 'package:student_app/sources/db.dart';

import '../model/student.dart';

class StudentController extends GetxController{
  RxList students = [].obs;

  void setAllStudent(List<Student> studs){
    students.assignAll(studs);
    update();
  }

  List<Student> filterStudentFromStr(String s){
    List<Student> filteredList = [];
    s = s.toLowerCase();
    List<String> tokens = s.split(" ");

    for(Student stud in students){
      for (var token in tokens){
        if(stud.name.contains(token)) {
          filteredList.add(stud);
        }
      }
    }

   
    print("func "+filteredList.toString());
    return filteredList;
  }

  Future<List<Student>> getStudents(String s) async {
    var st = await StudentDB.instance.getStudents();
    setAllStudent((s.isEmpty)?st:filterStudentFromStr(s));
    update();
    return st;
  }

  void addStudent(Student s){
    students.add(s);
    update();
  }

  void deleteStudent(Student s){
    students.remove(s);
    update();

  }

  void updateStudent(int id, Student s){
    int idx = searchStudentIdxbyId(id);
    // print(id);
    if(idx >= 0) students[idx] = s;
    update();

  }

  Student? findStudentbyId(int id){
    update();
  
    return students.firstWhere((element) => element.id == id);

  }

  int searchStudentIdxbyId(int id){
    return students.indexWhere((element){
        return element.id == id;
    }  
    );
  }
}