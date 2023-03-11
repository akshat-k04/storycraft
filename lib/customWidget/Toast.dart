import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// Toster( String msg ) {
//   Fluttertoast.showToast(
//     msg: msg,
//     toastLength: Toast.LENGTH_SHORT,
//     gravity: ToastGravity.BOTTOM,
//     timeInSecForIosWeb: 1,
//     backgroundColor: Colors.grey,
//     textColor: Colors.white,
//     fontSize: 14.0,
//   );
// }

// i got some error while i download the upper fluttertoast package

 showToast( BuildContext context ,String msg){
   final snackBar = SnackBar(
     duration: const Duration(seconds: 2),
     content: Text(msg),
     // action: SnackBarAction(
     //   label: 'Undo',
     //   onPressed: () {
     //     // Some code to undo the change.
     //   },
     // ),
   );
   ScaffoldMessenger.of(context).showSnackBar(snackBar);
 }