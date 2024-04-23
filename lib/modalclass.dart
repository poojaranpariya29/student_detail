class StudentModel {
  String? name, grid, std, image;

  StudentModel({this.name, this.grid, this.std, this.image});

  factory StudentModel.fromJson(Map<String, dynamic> map) {
    return StudentModel(
      name: map["name"],
      grid: map["grid"],
      std: map["std"],
      image: map["image"],
    );
  }
}
