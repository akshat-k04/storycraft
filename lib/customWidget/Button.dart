import 'package:flutter/material.dart';

class ClickMe extends StatelessWidget{
  String title ;

  var doing;

  ClickMe({
    super.key,
    required this.title,
    required this.doing()
  });

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: 44,
      child: ElevatedButton(
        style:  ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),

      )
          ),

          backgroundColor: const MaterialStatePropertyAll(Colors.white),
        ),
        onPressed: (){
          doing() ;
        },
        child: Center(

          child: Text(
              title,
            style: const TextStyle(
              color: Colors.black,
              fontFamily: "lasitana"
            ),
          ),
        ),

      ),
    );
  }

}