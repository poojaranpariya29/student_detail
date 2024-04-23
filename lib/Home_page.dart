import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:student_detail/modalclass.dart';
import 'package:student_detail/utill.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Home Page",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xff5D39AF),
      ),
      body: InkWell(
        onTap: () {
          Navigator.pushNamed(context, "adddata", arguments: StudentModel());
        },
        child: ListView.builder(
          itemCount: studentList.length,
          itemBuilder: (context, index) {
            StudentModel student = studentList[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: FileImage(File(student.image ?? "")),
              ),
              title: Text('Name: ${student.name}'),
              subtitle: Text('GR-ID: ${student.grid} | Std: ${student.std}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.edit),
                  ),
                  IconButton(
                    onPressed: () {
                      studentList.removeAt(index);
                      setState(() {});
                    },
                    icon: Icon(Icons.delete),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.pushNamed(context, 'adddata');
          if (result != null && result is StudentModel) {
            setState(() {
              studentList.add(result);
            });
          }
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0xff5D39AF),
        foregroundColor: Colors.white,
        shape: CircleBorder(),
      ),
    );
  }
}
