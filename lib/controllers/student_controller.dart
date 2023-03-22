import 'package:get/get.dart';
import 'package:student_app/sources/db.dart';

import '../model/student.dart';

class StudentController extends GetxController{
  RxList students = [].obs;

  void setAllStudent(List<Student> studs){
    students.addAll(studs);
    update();
  }

  List getStudents() {
    return students;
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