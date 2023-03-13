import 'package:flutter/material.dart';

class Member extends StatelessWidget{
  const Member({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        children:  [
          const SizedBox(
            height: 10,
          ),
          Row(
            children: const [
              SizedBox(width: 10,),
              Text("Name",style: TextStyle(fontSize: 25),),
            ],
          ),
          const SizedBox(
            height: 2,
          ),
          Row(
            children: const [
              SizedBox(width: 18,),
              Text("Notes Count:5"),
            ],
          ),
          const SizedBox(
            height: 2,
          ),
          const Divider(
            color: Colors.black,
            indent: 22.0,
            endIndent: 22.0,
          ),
        ],
      ),
    ) ;
  }

}

