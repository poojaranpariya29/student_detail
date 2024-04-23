import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_detail/modalclass.dart';
import 'package:student_detail/utill.dart';

class AddData extends StatefulWidget {
  int? studentindex;

  AddData({super.key, this.studentindex});

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  TextEditingController NameController = TextEditingController();
  TextEditingController GridController = TextEditingController();
  TextEditingController StdController = TextEditingController();

  String? image;
  @override
  void initState() {
    super.initState();
    if (widget.studentindex != null) {
      NameController.text = studentList[widget.studentindex!].name ?? "";
      GridController.text = studentList[widget.studentindex!].grid ?? "";
      StdController.text = studentList[widget.studentindex!].std ?? "";

      image = studentList[widget.studentindex!].image ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff5D39AF),
          foregroundColor: Colors.white,
          title: Text(
            'Detail Page',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () async {
                  XFile? file = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  image = file?.path ?? "";
                  setState(() {});
                  print("image");
                },
                child: Center(
                  child: CircleAvatar(
                    backgroundImage: FileImage(File(image ?? "")),
                    radius: 60,
                  ),
                ),
              ),
              Center(
                child: Text(
                  "Add Profile",
                  style: TextStyle(fontSize: 15),
                ),
              ),
              Text(
                "Student GrId:",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              TextFormField(
                controller: GridController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(border: OutlineInputBorder()),
              ),
              Text(
                "Student Name:",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              TextFormField(
                controller: NameController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(border: OutlineInputBorder()),
              ),
              Text(
                "Student Std:",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              TextFormField(
                controller: StdController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(border: OutlineInputBorder()),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (widget.studentindex == null) {
                      studentList.add(StudentModel(
                        name: NameController.text,
                        grid: GridController.text,
                        std: StdController.text,
                        image: image,
                      ));
                      Navigator.pop(context);
                      print("Add");
                    } else {
                      studentList[widget.studentindex!] = StudentModel(
                        name: NameController.text,
                        grid: GridController.text,
                        std: StdController.text,
                        image: image,
                      );
                      print("Update");
                      Navigator.pop(context);
                    }
                  },
                  child: Text("SUBMIT"),
                ),
              ),
            ],
          ),
        ));
  }
}
