import 'package:flutter/material.dart';
import 'package:notes_ui/home_page.dart';
import 'package:notes_ui/note_model.dart';
import 'package:notes_ui/db_helper.dart';


TextEditingController mTitleController = TextEditingController();
TextEditingController mDescController = TextEditingController();


class NewPage extends StatefulWidget {
  final String? title;
  final String? desc;
  final int? id;
  bool isUpdate;
  final String? createdAt;

  NewPage({this.title , this.desc , this.id , this.isUpdate = false , this.createdAt});

  @override
  State<NewPage> createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {

  DbHelper ? mDb;

  List<NoteModel> mData = [];

  @override
  void initState() {
    super.initState();
    mDb = DbHelper.getInstance();
    getAllNotes();
  }

  void getAllNotes () async{
    mData = await mDb!.fetchNotes();
    setState(() {

    });
}

  @override
  Widget build(BuildContext context) {

   if(widget.isUpdate){
     mTitleController.text = widget.title!;
     mDescController.text = widget.desc!;
   }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () async{
                      if(widget.isUpdate){
                        bool check = await mDb!.updateValue(NoteModel(
                          nTitle: mTitleController.text,
                          nDesc: mDescController.text,
                          nCreatedAt: widget.createdAt!,
                          nID: widget.id,
                        ));
                      }else {
                        bool check = await mDb!.addNotes(newnote: NoteModel(
                          nTitle: mTitleController.text,
                          nDesc: mDescController.text,
                          nCreatedAt: DateTime
                              .now()
                              .millisecondsSinceEpoch
                              .toString(),
                        ));

                        /*if (check) {
                          getAllNotes();
                        }*/
                      }
                      /*Navigator.pop(context, MaterialPageRoute(builder: (index) => HomePage()));*/
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10 , vertical: 5),
                      child: Text("Save"),
                    ),
                    ),
                  ),
                ],
              ),
              TextField(
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.black54,
                ),
                controller: mTitleController,
                maxLines: null,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  hintText: "Enter Title",
                ),
                keyboardType: TextInputType.multiline,
              ),SizedBox(height: 30,),
              TextField(
                controller: mDescController,
                maxLines: null,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  hintText: "Enter Notes",
                ),
                keyboardType: TextInputType.multiline,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
