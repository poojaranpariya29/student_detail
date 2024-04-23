import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:student_detail/modalclass.dart';
import 'package:student_detail/utill.dart';

import 'Add_Data_Page.dart';

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
            var user = studentList[index];
            return Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              height: 100,
              decoration: BoxDecoration(color: Color(0XFFBDADE3)),
              width: double.infinity,
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage: FileImage(File(user.image ?? "")),
                ),
                title: Column(
                  children: [
                    Row(
                      children: [
                        Text("Name:"),
                        Text(user.name ?? ""),
                      ],
                    ),
                    Row(
                      children: [
                        Text("GrId:"),
                        Text(user.grid ?? ""),
                      ],
                    ),
                    Row(
                      children: [
                        Text("Std:"),
                        Text(user.std ?? ""),
                      ],
                    ),
                  ],
                ),
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
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          print("goto detail");
          await Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return AddData();
            },
          ));
          print("Back to home");
          setState(() {});
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
