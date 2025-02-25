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

  void getAllNotes() async {
    mData = await mDB!.fetchNotes();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFFFFFFF),
      appBar: AppBar(
        backgroundColor: Color(0XFFFFFFFF),
        title: Text("All Notes"),
        centerTitle: true,
      ),

      /// GRID VIEW BUILDER
      /// THIS mDATA ISNOTEMPTY IS TAKEN FOR TO DEFINE THAT IF THE DATA IS ADDED THEN THE GRIDVIEW CAN SHOW THE DATA IF IT'S NOT THEN THE TEXT CAN SHOW

      body: mData.isNotEmpty
          ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
                itemCount: mData.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 7/19,
                ),
                itemBuilder: (_, index) {
                  /// DATE FORMATE TITILE
                  var eachDate = DateTime.fromMillisecondsSinceEpoch(
                      int.parse(mData[index].nCreatedAt));

                  /// DIALOUG BOX APPEARNING
                  return InkWell(
                    onLongPress: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container(
                              height: 50,
                              color: Color(0XFFFFFFFF),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        /// MOVE FOLDER
                                        InkWell(
                                            onTap: () {
                                              showModalBottomSheet(context: context,shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(15) , topRight: Radius.circular(15))) ,builder: (context) {
                                                return Container(
                                                  height: 150,
                                                  color: Colors.white,
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(20.0),
                                                    child: Column(
                                                      children: [
                                                        Text("Select destination folder" , style: TextStyle(fontSize: 18 ,fontWeight: FontWeight.bold),),
                                                        Divider(),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              width : 50,
                                                              child: Icon(Iconsax.folder),
                                                            ),SizedBox(width: 20,),
                                                            Container(
                                                              child: Text("Folder", style: TextStyle(fontSize: 16 ,fontWeight: FontWeight.bold),),
                                                            )
                                                          ],
                                                        ),SizedBox(height: 15,),
                                                        Row(
                                                          children: [
                                                            Container(
                                                                width : 50,
                                                                child: Icon(Iconsax.add , color: Colors.green,)),SizedBox(width: 20,),
                                                            Container(child: Text("Create folder", style: TextStyle(fontSize: 16 ,fontWeight: FontWeight.bold),)),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              });
                                            },child: Icon(Iconsax.folder)),

                                        /// LOCK NOTE
                                        InkWell(
                                            onTap: () {

                                            },child: Icon(Iconsax.lock)),
                                        /// SHARE NOTE
                                        InkWell(
                                            onTap: () {

                                            },child: Icon(Iconsax.share)),
                                        /// DELETE
                                        InkWell(
                                            onTap: () async {
                                              /// DELETE BUTTON TASK
                                              bool check = await mDB!
                                                  .deleteNote(mData[index].nID!);

                                              if (check) {
                                                getAllNotes();
                                                Navigator.pop(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            HomePage()));
                                              }
                                            },
                                            child: Icon(Iconsax.trash)),
                                        /// MORE
                                        InkWell(
                                            onTap: () {
                                              showDialog(context: context, builder: (context){
                                                return Dialog(
                                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                                  child: Container(
                                                    width: 50,
                                                    height: 120,
                                                    child: Card(
                                                      child: Column(
                                                        children: [
                                                          Text("Save as file"),SizedBox(height: 10,),
                                                          Text("Duplicate note"),SizedBox(height: 10,),
                                                          Text("Add to favourities"),SizedBox(height: 10,),
                                                          Text("Move to Samsung"),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              });
                                            },child: Icon(Iconsax.more)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    },

                    /// NOTES VISIBLE on UI and UPDATE TASK
                    child: InkWell(
                      onTap: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NewPage(
                                      isUpdate: true,
                                      title: mData[index].nTitle,
                                      desc: mData[index].nDesc,
                                      id: mData[index].nID,
                                      createdAt: mData[index].nCreatedAt,
                                    )));
                      },
                      child: Column(
                        children: [
                          Card(
                            //color: Colors.white,
                            elevation: 10,
                            child: Container(
                              height: 200,
                              width: 200,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(21),
                                  color: Color(0XFFFFFFFF)
                                /*Colors.primaries[
                                      Random().nextInt(Colors.primaries.length)],*/
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  overflow: TextOverflow.fade,
                                    mData[index].nDesc
                                ),
                              ),
                            ),
                          ),SizedBox(height: 10,),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  mData[index].nTitle.isNotEmpty ? mData[index].nTitle : "Title", textAlign: TextAlign.center,
                                ),SizedBox(height: 6,),
                                Text(
                                  "${eachDate.day}-${eachDate.month}-${eachDate.year}",
                                  style: TextStyle(color: Colors.black54 , fontSize: 12),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );

                }),
          )
          : Center(
              child: Text("No notes yet!!"),
            ),

      /// NEW NOTE CREATED LOGIC IMPLEMENTED
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          mTitleController.clear();
          mDescController.clear();

          Navigator.push(
              context, MaterialPageRoute(builder: (index) => NewPage()));
        },
        child: Icon(Iconsax.edit , color: Colors.deepOrange,size: 19,) , backgroundColor: Colors.white , shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(60)),
      ),
    );
  }
}
