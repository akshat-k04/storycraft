import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/Md.dart';
class InputIt extends StatefulWidget{
  String hint ;
  bool readonly  ;
  TextEditingController? controller ;
  InputIt({
    super.key,
    required this.readonly ,
    required this.hint,
    required this.controller,

  }) ;
  @override
  State<StatefulWidget> createState() {
    return StateInput() ;
  }

}


class StateInput extends State<InputIt> {
  bool showpass = false ;
  double rad = 25 ;


  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: (widget.hint=="search")?const EdgeInsets.symmetric(horizontal: 5):null,
      decoration:  BoxDecoration(
        borderRadius:  BorderRadius.all((widget.hint=="search")? Radius.circular(rad):const Radius.circular(8)),
        color: (widget.hint=="Your Password")?const Color(0xFF9C9A9A):Colors.white
      ),


      child: TextFormField(
          onChanged: (val){
            if(widget.hint=="search"){
              MDProvider MDProvid = Provider.of<MDProvider>(context,listen: false);
              MDProvid.updateQuery(val) ;
            }
    },
        readOnly:widget.readonly,
        obscureText: (showpass || widget.hint!="Your Password")?false:true,
        controller: widget.controller,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter ${widget.hint}';
          }
          return null;
        },


        style: const TextStyle(
          color: Colors.black,
            fontFamily: 'ubantu'
        ),

          cursorColor:const Color(0xFF1E1E1E),

        decoration: InputDecoration(
          suffixIcon: (widget.hint=="Your Password")?IconButton(

            onPressed: () {
              setState(() {
                showpass = !showpass ;
              });
            }, icon: showpass?const Icon(
            CupertinoIcons.eye_fill,
            color: Color(0xFF1E1E1E),
          ):const Icon(
              CupertinoIcons.eye_slash,
            color: Color(0xFF1E1E1E),

          ),
          ):null,



          hintText: widget.hint,



          hintStyle: const TextStyle(
            color: Colors.black54
                ,fontFamily: 'ubantu'
          ),



          contentPadding: const EdgeInsets.fromLTRB(15, 2.5,5, 2.5),


          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                  color: Colors.white24,
              ),
            borderRadius: BorderRadius.all(
                (widget.hint=="search")? Radius.circular(rad):const Radius.circular(8),
            )
          ),




          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.white
            ),
              borderRadius: BorderRadius.all(
                (widget.hint=="search")? Radius.circular(rad):const Radius.circular(8),
              )
          ),



          errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                  color: Colors.red
              ),
              borderRadius: BorderRadius.all(
                (widget.hint=="search")? Radius.circular(rad):const Radius.circular(8),
              )
          ),




          focusedErrorBorder:OutlineInputBorder(
              borderSide: const BorderSide(
                  color: Colors.red
              ),
              borderRadius: BorderRadius.all(
                (widget.hint=="search")? Radius.circular(rad):const Radius.circular(8),
              )
          ),




        )
      ),
    );
  }

}