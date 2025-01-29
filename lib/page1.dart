import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageOne extends StatelessWidget{
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
                    Stack(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(11),
                          ),
                        ),
                        Positioned(
                          top: 9,
                            left: 10,
                            child: Image.asset("assets/images/edit-logo.png" , width: 20, height: 20, color: Colors.white,))
                      ],
                    )
                  ],
                ),SizedBox(height: 30,),
                Text("Beautiful weather app Ul concepts we wish existed" , style: TextStyle(color: Colors.white , fontSize: 32),),SizedBox(height: 20,),
                Text("May 21, 2020" , style: TextStyle(color: Colors.grey),),SizedBox(height: 20,),
                Text("ho would have thought there could be so many creative ways to tell the temperature? Today's daily dose of design inspiration is all about the weather. In this collection of Ul designs, we're sharing a handful of beautiful mobile weather app concepts that we wish existed in real life.", style: TextStyle(color: Colors.white , fontSize: 18 , height: 2),),SizedBox(height: 20,),
                Text("Weather apps are quite the popular interface theme for designers to explore. But don't let these effortlessly clean designs fool you. When it comes to the weather, there's a lot of data designers have to arrange which can be quite a challenge. Regardless, it's a great way to practice your Ul skills. We" , style: TextStyle(color: Colors.white , fontSize: 18 , height: 2),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}