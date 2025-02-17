import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_ui/home_page.dart';
import 'package:notes_ui/new_page.dart';
import 'package:notes_ui/page1.dart';

void main(){
  runApp(NotesApp());
}
class NotesApp extends StatelessWidget{
  const NotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "poppins"
      ),
      home: HomePage(),
    );
  }
}