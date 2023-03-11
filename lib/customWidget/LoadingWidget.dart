import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget{
  bool ? Changewhite ;

  LoadingWidget({super.key,this.Changewhite});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child:CircularProgressIndicator(backgroundColor: Colors.transparent,color: (Changewhite==true)?Color(0xFF434242):Colors.white,strokeWidth: 4,),
    );
  }

}