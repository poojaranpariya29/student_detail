import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
          // Navigator.pushNamed(context, 'DetailsPage');
          Navigator.pushNamed(context, "adddata", arguments: studentData);
        },
        child: ListView.builder(
          itemCount: studentList.length,
          itemBuilder: (context, index) {
            StudentData student = studentList[index];
            return Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: FileImage(File(student.xFILE ?? "")),
                ),
                title: Text('Name: ${student.name}'),
                subtitle: Text('GR-ID: ${student.grid} | Std: ${student.std}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        _showDialog(context, index);
                      },
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
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.pushNamed(context, 'adddata');
          if (result != null && result is StudentData) {
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

  void _showDialog(BuildContext context, int index) {
    TextEditingController studentNameController =
        TextEditingController(text: studentList[index].name);
    TextEditingController studentGridController =
        TextEditingController(text: studentList[index].grid);
    TextEditingController studentStdController =
        TextEditingController(text: studentList[index].std);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: Text("Edit Student Profile")),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: studentNameController,
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: studentGridController,
                  decoration: InputDecoration(labelText: 'GR-ID'),
                ),
                TextField(
                  controller: studentStdController,
                  decoration: InputDecoration(labelText: 'Std'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  studentList[index].name = studentNameController.text;
                  studentList[index].grid = studentGridController.text;
                  studentList[index].std = studentStdController.text;
                });
                Navigator.of(context).pop();
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }
}
