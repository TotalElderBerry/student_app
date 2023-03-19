import 'package:get/get.dart';

import '../model/student.dart';

class StudentController extends GetxController{
  RxList students = [].obs;

  List getStudents(){
    return students.value;
  }

  void addStudent(Student s){
    students.add(s);
  }

  void deleteStudent(Student s){
    students.remove(s);
  }

  void updateStudent(int id, Student s){
    students[students.indexWhere((element) => element.id == id)] = s;
  }

  Student? findStudentbyId(int id){
    return students.firstWhere((element) => element.id == id);
  }
}