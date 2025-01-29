import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
TextEditingController notesController = TextEditingController();

class NewPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25 , vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(11),
                      ),
                      child: Icon(Icons.arrow_back_ios_new , color: Colors.white,),
                    ),
                    Container(
                      height: 40,
                      width: 70,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(11),
                      ),
                      child: Text("Save" , style: TextStyle(fontSize: 17 ,color: Colors.white), textAlign: TextAlign.center,),
                    ),
                  ],
                ),SizedBox(height: 30,),
                Text("Title" , style: TextStyle(fontSize: 35 , color: Colors.grey),),SizedBox(height: 30,),
                Container(
                  width: double.infinity,
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    controller: notesController,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)
                      ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    label: Text("Type something..." , style: TextStyle(color: Colors.grey),),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}