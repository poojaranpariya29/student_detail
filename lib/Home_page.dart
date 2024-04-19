import 'dart:io';
import 'package:flutter/material.dart';
import 'Add_data_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController grid = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController standard = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff5D39AF),
        centerTitle: true,
        title: Text(
          "DETAIL",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          InkWell(
              onTap: () {
                setState(() {});
              },
              child: Icon(
                Icons.refresh,
                color: Colors.white,
              )),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: ListView.builder(
        itemCount: Global.g1.studentList.length,
        itemBuilder: (context, index) {
          return Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              height: MediaQuery.of(context).size.height * 0.15,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xffBDADE3),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 5,
                      ),
                      CircleAvatar(
                        radius: 35,
                        backgroundImage: FileImage(
                          File("${Global.g1.studentList[index]["image"]}"),
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            "GR ID: ${Global.g1.studentList[index]["grid"]}",
                          ),
                          Text(
                            "NAME: ${Global.g1.studentList[index]["name"]}",
                          ),
                          Text(
                            " STANDARD: ${Global.g1.studentList[index]["standard"]}",
                          ),
                        ],
                      ),
                      Spacer(),
                      IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Container(
                                      color: Color(0xff5D39AF),
                                      child: Text(
                                        "Update:",
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.white),
                                      ),
                                    ),
                                    actions: [
                                      TextFormField(
                                        controller: grid,
                                        decoration: InputDecoration(
                                          hintText: "grid:",
                                        ),
                                      ),
                                      TextFormField(
                                          controller: name,
                                          decoration: InputDecoration(
                                              hintText: "name:")),
                                      TextFormField(
                                          controller: standard,
                                          decoration: InputDecoration(
                                              hintText: "standard:")),
                                      SizedBox(height: 10),
                                      Center(
                                        child: ElevatedButton(
                                            onPressed: () {
                                              Map m1 = {
                                                "grid": grid.text,
                                                "name": name.text,
                                                "standard": standard.text,
                                              };
                                              Global.g1.studentList.add(m1);
                                              Navigator.pop(context, [
                                                grid.text,
                                                name.text,
                                                standard.text,
                                              ]);
                                            },
                                            child: Text("UPDATE")),
                                      ),
                                      Center(
                                        child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text("CANCEL")),
                                      )
                                    ],
                                  );
                                });
                          },
                          icon: const Icon(Icons.edit)),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              Global.g1.studentList
                                  .remove(Global.g1.studentList[index]);
                            });
                          },
                          icon: const Icon(Icons.delete)),
                    ],
                  ),
                ],
              ));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "adddata");

          setState(() {});
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
