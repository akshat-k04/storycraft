import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storycraft/customWidget/LoadingWidget.dart';
import 'package:storycraft/customWidget/Toast.dart';

import '../../Providers/Auth.dart';
import '../../Providers/color.dart';
import '../../customWidget/Button.dart';
import '../../customWidget/InputField.dart';
import '../afterAuth/homePage.dart';
import 'Signup.dart';
// this screen is for signup process
class OTPScreen extends StatefulWidget{
  const OTPScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return StateOTp() ;
  }
}

class StateOTp extends State<OTPScreen>{

  final _OTP = TextEditingController();
  bool loading  = false  ;
  Check()async{
    setState(() {
      loading=true ;
    });
    AuthProvider prder = Provider.of<AuthProvider>(context,listen: false);

    int al =await prder.VarifyOTP(_OTP.text);
    if(al==0){
      showToast(context,"enter valid OTP") ;
      // Toster( "Enter valid OTP") ;
    }
    else if(al==-1){
      showToast(context,"Email id is already used") ;
    }
    else{
      prder.login = true ;
      setState(() {
        loading=false ;
      });
      SharedPreferences sp = await SharedPreferences.getInstance();
      sp.setString('email', prder.Email);
      Navigator.pushAndRemoveUntil(context,createRoute('home'),(Route<dynamic> route) => false);
    }
    setState(() {
      loading=false ;
    });
  }


  @override
  Widget build(BuildContext context) {
    ColorProvider colrPrder = Provider.of<ColorProvider>(context) ;

    return Container(
      decoration: BoxDecoration(
        color: Color(colrPrder.color),

      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,

        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.fromLTRB(30, 200, 30, 40),
            color: Colors.transparent,
            child: Column(
              children: [
                Row(
                  children: const [
                    Text("Validate Email",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 35,
                          fontFamily: "Patrick",

                          fontWeight: FontWeight.bold,
                          color: Colors.white
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 50),
                  child: Column(
                    children: [


                      // Row(
                      //   children: const [
                      //      Text('OTP',
                      //       style: TextStyle(
                      //           fontSize: 15.5,
                      //           color: Colors.white70
                      //       ),
                      //     ) ,
                      //   ],
                      // ),
                      const SizedBox(
                        height: 35,
                      ),
                       InputIt(hint: 'Enter OTP', controller: _OTP,readonly: (loading)?true:false)
                          ,
                      const SizedBox(
                        height: 40,
                      ),
                      (loading)?LoadingWidget():ClickMe(
                          title: "submit" , doing: () {
                            Check() ;
                      }),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}


Route createRoute(String st) {

  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
    (st=="home")?const HomePage():

    const SignUp(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
