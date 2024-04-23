import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_detail/utill.dart';
import 'package:flutter/src/painting/image_provider.dart';

import 'Add_Data_Page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

GlobalKey globalKey = GlobalKey();

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
      body: ListView.builder(
        itemCount: studentList.length,
        itemBuilder: (context, index) {
          var user = studentList[index];
          return Container(
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.all(10),
            height: 100,
            decoration: BoxDecoration(color: Color(0XFFBDADE3)),
            width: double.infinity,
            child: ListTile(
              onTap: () async {
                await Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return AddData(
                      studentindex: index,
                    );
                  },
                ));
                setState(() {});
              },
              leading: InkWell(
                onTap: () {
                  onPressed:
                  () async {
                    RenderRepaintBoundary rrb = globalKey.currentContext
                        ?.findRenderObject() as RenderRepaintBoundary;
                    var pic = await rrb.toImage();
                    var pngImg =
                        await pic.toByteData(format: ImageByteFormat.png);
                    Uint8List? asUint8List = pngImg?.buffer.asUint8List();

                    print("asUint8List $asUint8List");
                    savedImg = asUint8List;
                    Navigator.pushNamed(context, "save");
                  };
                },
                child: RepaintBoundary(
                  key: globalKey,
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: FileImage(File(user.image ?? "")),
                  ),
                ),
              ),
              title: Column(
                children: [
                  Row(
                    children: [
                      Text("GrId:"),
                      Text(user.grid ?? ""),
                    ],
                  ),
                  Row(
                    children: [
                      Text("Name:"),
                      Text(user.name ?? ""),
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
                    onPressed: () {
                      _DialogBox(context, index);
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
        child: const Icon(Icons.add),
      ),
    );
  }

  void _DialogBox(BuildContext context, int index) {
    String? image;
    TextEditingController NameController =
        TextEditingController(text: studentList[index].name);
    TextEditingController GridController =
        TextEditingController(text: studentList[index].grid);
    TextEditingController StdController =
        TextEditingController(text: studentList[index].std);
    image = studentList[index].image;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: Text("Edit Student Profile")),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () async {
                    XFile? file = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    image = file?.path ?? "";
                    setState(() {});
                    print("image");
                  },
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: FileImage(File(image ?? "")),
                    child: Icon(Icons.camera_alt),
                  ),
                ),
                TextField(
                  controller: NameController,
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: GridController,
                  decoration: InputDecoration(labelText: 'GR-ID'),
                ),
                TextField(
                  controller: StdController,
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
                  studentList[index].name = NameController.text;
                  studentList[index].grid = GridController.text;
                  studentList[index].std = StdController.text;
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
