import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget{
  String value ;
  ProfileWidget({super.key,required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4.0, // soften the shadow
            spreadRadius: 2.0, //extend the shadow
          )
        ],
      ),
      child: Row(
        children: [
          const SizedBox(width: 20,),
          Text(value,
            style: const TextStyle(
                fontFamily: "patrick",
              fontSize: 30
            ),
          )
        ],
      ),
    );
  }

}