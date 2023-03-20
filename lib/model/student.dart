class Student{
  int? id;
  String name;
  String course;
  String imgPath;
  Student({required this.name,required this.course,required this.imgPath});

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'name': name,
      'course': course,
      'img': imgPath
    };
  }
}