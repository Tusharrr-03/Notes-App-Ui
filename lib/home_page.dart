import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:notes_ui/db_helper.dart';
import 'package:notes_ui/new_page.dart';
import 'package:notes_ui/note_model.dart';

/*List<Map<String, dynamic>> mNotes = [
  {
    'title': 'How to make your personal brand stand out onnline',
    'date': 'May 21,2020',
    'color': const Color(0xffFFAB91),
    'text color': const Color(0xffAC6E5D),
  },
  {
    'title': 'Beautiful weather app UI concepts we wish existed',
    'date': 'Mar 18,2020',
    'color': const Color(0xffFFCC80),
    'text color': const Color(0xffBE965B),
  },
  {
    'title': '10 excellent font pairing tools for designers',
    'date': 'Feb 01,2020',
    'color': const Color(0xffE7ED9B),
    'text color': const Color(0xffABB170),
  },
  {
    'title':
        'Spotify\'s Reema Bhagat on product design ,music and a key to happy life ',
    'date': 'Feb 01,2020',
    'color': const Color(0xff81DEEA),
    'text color': const Color(0xff418991),
  },
  {
    'title': '12 eye-catching mobile wallpaper',
    'date': 'Feb 01,2020',
    'color': const Color(0xffCF94DA),
    'text color': const Color(0xff8D6296),
  },
  {
    'title': 'eye-catching mobile wallpaper',
    'date': 'Feb 01,2020',
    'color': const Color(0xff7FCBC3),
    'text color': const Color(0xffAC6E5D),
  },
  {
    'title': 'Design for Good: Join The Face Mask Challenge',
    'date': 'Feb 01,2020',
    'color': const Color(0xffF48FB1),
    'text color': const Color(0xffAC6E5D),
  },
  {
    'title': 'Guruji yeh Floating button right side me align nhi ho rha.',
    'date': 'Feb 01,2020',
    'color': const Color(0xffF48FB1),
    'text color': const Color(0xffAC6E5D),
  },
];*/

TextEditingController mTitleController = TextEditingController();
TextEditingController mDescController = TextEditingController();


class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  /// CREATING CONTRUCTOR GET ACCESS THE CLASS
  DbHelper? mDB;

  List<NoteModel> mData = [];


  @override
  void initState() {
    super.initState();
    mDB = DbHelper.getInstance();
    getAllNotes();
  }

  void getAllNotes()async{
    mData = await mDB!.fetchNotes();
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HOME"),
        centerTitle: true,
      ),

      /// GRID VIEW BUILDER
      /// THIS mDATA ISNOTEMPTY IS TAKEN FOR TO DEFINE THAT IF THE DATA IS ADDED THEN THE GRIDVIEW CAN SHOW THE DATA IF IT'S NOT THEN THE TEXT CAN SHOW

      body: mData.isNotEmpty ? GridView.builder(
        itemCount: mData.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 9/11,
          ),
          itemBuilder: (_ , index) {

          /// DATE FORMATE TITILE
          var eachDate = DateTime.fromMillisecondsSinceEpoch(int.parse(mData[index].nCreatedAt));

          /// DIALOUG BOX APPEARNING
            return InkWell(
              onTap: (){
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      actions: [

                        /// DELETE BUTTON TASK
                        OutlinedButton(onPressed: () async{
                          bool check = await mDB!.deleteNote(mData[index].nID!);

                          if(check){
                            getAllNotes();
                            Navigator.pop(context, MaterialPageRoute(builder: (index) => HomePage()));
                          }
                        }, child: Text("Delete")),

                        /// UPDATE BUTTON TASK
                        OutlinedButton(onPressed: () async{
                         Navigator.push(context, MaterialPageRoute(builder: (context) => NewPage(isUpdate: true, title: mData[index].nTitle, desc: mData[index].nDesc, id: mData[index].nID, createdAt: mData[index].nCreatedAt,)));

                        }, child: Text("Update")),
                      ],
                      title: Text("Please Select one option in it"),
                    )
                );
              },

              /// NOTES VISIBLE UI
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(21),
                  color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(mData[index].nTitle , style: TextStyle(fontSize: 22),),SizedBox(height: 20,),
                      Text(mData[index].nDesc),Expanded(child: SizedBox(height: 10,)),
                      Text("${eachDate.day}-${eachDate.month}-${eachDate.year}"),
                    ],
                  ),
                ),
              ),
            );
      }
      ) : Center(
        child: Text("No notes yet!!"),
      ),


      /// NEW NOTE CREATED LOGIC IMPLEMENTED
      floatingActionButton: FloatingActionButton(onPressed: ()async{

        mTitleController.clear();
        mDescController.clear();

        Navigator.push(context, MaterialPageRoute(builder: (index) => NewPage()));


      }, child: Icon(Icons.add),
      ),
    );
  }
}
