import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../model/student.dart';
import 'package:path/path.dart';
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
        var dbPath = await getDatabasesPath();
        return db = await openDatabase(
              join(dbPath.toString(), 'student_db.db'),
              onCreate: (dbase, version) {
                return dbase.execute(
                  'CREATE TABLE Student(id INTEGER PRIMARY KEY, name TEXT, course TEXT, img TEXT)'
                );
              },
              version: 1
          );
  }

  Future<List<Student>> getStudents()async{
    String dbPath = await getDatabasesPath();
      print("db path is in "+dbPath);
    var myDB = await StudentDB.database;
    List<Map<String,dynamic>> res = await myDB.query('Student');
    return List.generate(res.length, (index){
      Student s = Student(
        name: res[index]['name'],
        course: res[index]['course'],
        imgPath: res[index]['img'],
      );
      s.id = res[index]['id'];
      return s;
    });
  }

  Future<int> addStudent(Student dog) async {
  // Get a reference to the database.
  final db = await StudentDB.database;

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

  Future<int> deleteStudent(Student s) async{
    return db!.delete('Student',where: 'name = ?',whereArgs: [s.name]);
  }

  Future<void> updateStudent(Student s) async {
    await db!.update('Student',s.toMap(), where: 'id = ?', whereArgs: [s.id]);
  }

 

}