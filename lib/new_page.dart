import 'package:flutter/material.dart';
import 'package:notes_ui/db_provider.dart';
import 'package:notes_ui/note_model.dart';
import 'package:provider/provider.dart';

class NewPage extends StatefulWidget {
  final String? title;
  final String? desc;
  final int? id;
  final bool isUpdate;
  final String? createdAt;

  NewPage({this.title, this.desc, this.id, this.isUpdate = false, this.createdAt});

  @override
  State<NewPage> createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  final TextEditingController mTitleController = TextEditingController();
  final TextEditingController mDescController = TextEditingController();

  @override
  void initState() {
    super.initState();
    /// Provider Class build
    context.read<DbProvider>().getInitialNotes();
    if (widget.isUpdate) {
      mTitleController.text = widget.title ?? "";
      mDescController.text = widget.desc ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
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
                    onTap: () async { /// Condition not to proceed further if it's empty
                      if(mTitleController.text.isNotEmpty && mDescController.text.isNotEmpty){
                        if(widget.isUpdate){  /// Update logic
                          await context.read<DbProvider>().updateNote(NoteModel(
                            nID: widget.id,
                              nTitle: mTitleController.text,
                              nDesc: mDescController.text,
                              nCreatedAt: widget.createdAt ?? DateTime.now().millisecondsSinceEpoch.toString(),
                          ));
                        } else{  /// Add Logic
                          context.read<DbProvider>().addNote(NoteModel(
                              nTitle: mTitleController.text,
                              nDesc: mDescController.text,
                              nCreatedAt: widget.createdAt ?? DateTime.now().millisecondsSinceEpoch.toString(),
                          ));
                        }
                        Navigator.pop(context);
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: Text("Save"),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
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
              ),
              SizedBox(height: 30),
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

