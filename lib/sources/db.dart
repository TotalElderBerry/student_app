import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/student.dart';

class StudentDB{  
  static final StudentDB _studentDB = StudentDB._internal();
  static Database? db;
  static StudentDB get instance => _studentDB;
  StudentDB._internal();

  static Future<Database> get database async {
    if (db != null) return db!;
    // Initialize the DB first time it is accessed
    db = await initializeDatabase();
    return db!;
  }

  static Future<Database> initializeDatabase()async{
        return db = await openDatabase(
              join(await getDatabasesPath(), 'student_db.db'),
              onCreate: (db, version) {
                return db.execute(
                  'CREATE TABLE Student(id INTEGER PRIMARY KEY, name TEXT, course TEXT, img TEXT)'
                );
              },
              version: 1
          );
  }

  Future<List<Student>> getStudents()async{
    List<Map<String,dynamic>> res = await db!.query('Student');
    return List.generate(res.length, (index){
      return Student(
        name: res[index]['name'],
        course: res[index]['course'],
        imgPath: res[index]['img'],
      );
    });
  }

  Future<int> addStudent(Student dog) async {
  // Get a reference to the database.
  final db = await database;

  // Insert the Dog into the correct table. You might also specify the
  // `conflictAlgorithm` to use in case the same dog is inserted twice.
  //
  // In this case, replace any previous data.
  return await db.insert(
    'Student',
    dog.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

 

}