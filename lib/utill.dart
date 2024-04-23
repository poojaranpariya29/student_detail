import 'dart:io';

class StudentData {
  String grid;
  String name;
  String std;
  String xFILE;
  StudentData({
    required this.grid,
    required this.name,
    required this.std,
    required this.xFILE,
  });
}

class StudentModel {
  String? name, grid, std;

  StudentModel({this.name, this.grid, this.std});

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      name: json["name"],
      grid: json["grid"],
      std: json["std"],
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "grid": grid,
        "std": std,
      };
}

StudentData studentData = StudentData(name: '', grid: '', std: '', xFILE: '');

List<StudentData> studentList = [];
