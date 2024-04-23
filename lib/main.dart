import 'package:flutter/material.dart';
import 'package:student_detail/save_file.dart';
import 'Add_Data_Page.dart';
import 'Home_page.dart';

void main() {
  runApp(Myapp());
}

class Myapp extends StatefulWidget {
  const Myapp({super.key});

  @override
  State<Myapp> createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => HomePage(),
        "adddata": (context) => AddData(),
        "save": (context) => SaveImage(),
      },
    );
  }
}
