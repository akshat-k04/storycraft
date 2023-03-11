import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 36,
      child:CircularProgressIndicator(backgroundColor: Colors.transparent,color: Colors.white,strokeWidth: 4,),
    );
  }

}