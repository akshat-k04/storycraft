
import 'package:flutter/cupertino.dart';

class Goal extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return Container(
     padding: EdgeInsets.all(10),
     child: Column(
       children: [

         SizedBox(height: 50,) ,

         Text("Tasks",style: TextStyle(fontSize: 20),) ,
         SizedBox(height: 40,) ,
         Text("add todo feature and make its floating button on home screen",style: TextStyle(fontSize: 20),) ,
         SizedBox(height: 20,) ,

         Text("make a leader board of note count ",style: TextStyle(fontSize: 20),) ,
       ],
     ),
   ) ;
  }

}