import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_ui/db_helper.dart';
import 'package:notes_ui/db_provider.dart';
import 'package:notes_ui/home_page.dart';
import 'package:notes_ui/new_page.dart';
import 'package:notes_ui/page1.dart';
import 'package:provider/provider.dart';

void main(){
  runApp(ChangeNotifierProvider(create: (context) => DbProvider(dbHelper: DbHelper.getInstance()) , child: NotesApp(),));
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