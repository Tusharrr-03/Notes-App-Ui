import 'package:flutter/material.dart';

TextEditingController notesData = TextEditingController();

class NewPage extends StatelessWidget {
  const NewPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10 , vertical: 5),
                    child: Text("Save"),
                  ),
                  ),
                ],
              ),
              Text("Title" , style: TextStyle(fontSize: 38 , color: Colors.grey),),SizedBox(height: 20,),
              TextField(
                controller: notesData,
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
              )

            ],
          ),
        ),
      ),
    );
  }
}
