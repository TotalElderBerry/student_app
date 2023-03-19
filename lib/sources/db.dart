import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/student.dart';

class StudentDB{  
  static Database? db;

  void initializeDatabase()async{
        db = await openDatabase(
              join(await getDatabasesPath(), 'student_db.db'),
              onCreate: (db, version) {
                return db.execute(
                  'CREATE TABLE Student(id INTEGER PRIMARY KEY, name TEXT, course TEXT, img TEXT'
                );
              },
              version: 1
          );
  }

  Future<List<Student>> getStudents()async{
    List<Map<String,dynamic>> res = await db!.query('Student');
    return List.generate(res.length, (index){
      return Student(
        id: res[index]['id'],
        name: res[index]['name'],
        course: res[index]['course'],
        imgPath: res[index]['img'],
      );
    });
  }

 

}