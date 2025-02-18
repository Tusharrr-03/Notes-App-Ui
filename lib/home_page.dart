import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:notes_ui/db_helper.dart';

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
  DbHelper? mDB;

  List<Map<String , dynamic>> mData = [];

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
      ),
      body: mData.isNotEmpty ? ListView.builder(
        itemCount: mData.length,
          itemBuilder: (_ , index)
          {
             return ListTile(
              title: Text(mData[index][DbHelper.COLUMN_NOTES_TITLE]),
              subtitle: Text(mData[index][DbHelper.COLUMN_NOTES_DESC]),
            );
      }) : Center(
        child: Text("No notes yet!!"),
      ),
      floatingActionButton: FloatingActionButton(onPressed: ()async{

        mTitleController.clear();
        mDescController.clear();

        showModalBottomSheet(context: context, builder: (_){
          return Container(
            width: double.infinity,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Icon(Iconsax.arrow_up_2),SizedBox(height: 15,),
                  TextField(
                    controller: mTitleController,
                    decoration: InputDecoration(
                      label: Text("Title"),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(color: Colors.black54),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(color: Colors.black54),
                      )
                    ),
                  ),SizedBox(height: 10,),
                  TextField(
                    controller: mDescController,
                    decoration: InputDecoration(
                        label: Text("Desc"),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(color: Colors.black54),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(color: Colors.black54),
                      )
                    ),
                  ),SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      OutlinedButton(onPressed: () async{
                        bool check = await mDB!.addNotes(title: mTitleController.text, desc: mDescController.text);

                        if(check){
                          getAllNotes();
                          Navigator.pop(context);
                        }

                      }, child: Text("Add")),SizedBox(width: 8,),
                      OutlinedButton(onPressed: () async{
                        mTitleController.clear();
                        mDescController.clear();
                      }, child: Text("Clear")),
                    ],
                  )

                ],
              ),
            ),
          );
        });

      }, child: Icon(Icons.add),
      ),
    );
  }
}


/// Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//         child: SafeArea(
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text(
//                       "Notes",
//                       style: TextStyle(color: Colors.white, fontSize: 40),
//                     ),
//                     Container(
//                       width: 40,
//                       height: 40,
//                       alignment: Alignment.center,
//                       decoration: BoxDecoration(
//                         color: Colors.white.withOpacity(0.2),
//                         borderRadius: BorderRadius.circular(11),
//                       ),
//                       child: const FaIcon(
//                         FontAwesomeIcons.search,
//                         color: Colors.white,
//                         size: 20,
//                       ),
//                     )
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 30,
//                 ),
//                 GridView.builder(
//                   shrinkWrap: true,
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     mainAxisSpacing: 15,
//                     crossAxisSpacing: 12,
//                     childAspectRatio: 9 / 12,
//                   ),
//                   itemCount: mNotes.length,
//                   itemBuilder: (context, index) {
//                     return Container(
//                       decoration: BoxDecoration(
//                         color: mNotes[index]['color'],
//                         borderRadius: BorderRadius.circular(11),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 20, vertical: 30),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               mNotes[index]['title'],
//                               style: const TextStyle(fontSize: 16),
//                             ),
//                             const Expanded(
//                                 child: SizedBox(
//                               height: 10,
//                             )),
//                             Text(
//                               mNotes[index]['date'],
//                               style:
//                                   TextStyle(color: mNotes[index]['text color']),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//       floatingActionButton: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: FloatingActionButton(
//           onPressed: () {},
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
//           backgroundColor: Colors.black,
//           foregroundColor: const Color(0xffffffff),
//           child: const Icon(Icons.add),
//         ),
//       ),



/*

titleController.clear();
descController.clear();

showModalBottomSheet(context: context, builder: (_){
return Container(
padding: EdgeInsets.all(11),
color: Colors.white,
width: double.infinity,
child: Column(
children: [
Text("Add Note", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),),
SizedBox(
height: 11,
),
TextField(
controller: titleController,
decoration: InputDecoration(
label: Text("Title"),
hintText: "Enter title here..",
focusedBorder: OutlineInputBorder(),
enabledBorder: OutlineInputBorder(),
),
),
SizedBox(
height: 11,
),
TextField(
controller: descController,
decoration: InputDecoration(
label: Text("Desc"),
hintText: "Enter desc here..",
focusedBorder: OutlineInputBorder(),
enabledBorder: OutlineInputBorder(),
),
),
SizedBox(
height: 11,
),
Row(
mainAxisAlignment: MainAxisAlignment.end,
children: [
OutlinedButton(onPressed: () async{
bool check = await mDb!.addNote(title: titleController.text, desc: descController.text);

if(check){
getAllNotes();
Navigator.pop(context);
}*/
