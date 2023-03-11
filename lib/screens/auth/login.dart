
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storycraft/Providers/Auth.dart';
import 'package:storycraft/customWidget/LoadingWidget.dart';
import 'package:storycraft/customWidget/Toast.dart';
import 'package:storycraft/screens/afterAuth/homePage.dart';
import 'package:storycraft/screens/auth/Signup.dart';
import 'package:storycraft/customWidget/Button.dart';
import 'package:storycraft/customWidget/InputField.dart';
import 'package:storycraft/screens/auth/ForgetPassword.dart';

import '../../API/firebaseDeepLinking.dart';
import '../../Providers/Md.dart';
import '../../Providers/color.dart';


class login extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return LoginState() ;
  }

}



class LoginState extends State<login>{
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseDynamicLink.initdynamiclink(context) ;
  }
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool loading= false ;
  CheckCred(BuildContext context) async {
    AuthProvider prder = Provider.of<AuthProvider>(context,listen: false);
    MDProvider MDProvid = Provider.of<MDProvider>(context,listen: false);

    if(_formKey.currentState!.validate()){
      setState(() {
        loading=true ;
      });
      //it means it is validate
      String val = await prder.checkLogin(_email.text, _password.text);

      if(val == "success"){
        // Provider.of<AuthProvider>(context,listen: false).login = true ;


        SharedPreferences sp = await SharedPreferences.getInstance();
        sp.setString('email', _email.text);


        await prder.getAuthData(_email.text);
        await MDProvid.fetchMD(_email.text) ;
        //TODO:- fetch all the information
        setState(() {
          loading=false ;
        });
        Navigator.of(context).pushAndRemoveUntil(createRoute('home'),(Route<dynamic> route) => false);
      }
      else if(val== "fail"){
        showToast(context, "wrong password") ;
      }
      else{
        showToast(context, "user not exist") ;

      }
      setState(() {
        loading=false ;
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    ColorProvider colrPrder = Provider.of<ColorProvider>(context) ;

    return Container(
      decoration: BoxDecoration(
    color: Color(colrPrder.color),
    ),
      child: Form(
        key: _formKey,
        child: Scaffold(
          backgroundColor: Colors.transparent,

          body: SingleChildScrollView(
            child: Container(
              margin:const EdgeInsets.fromLTRB(30, 160, 30, 40),
              color: Colors.transparent,
              child: Column(
                children:  [
                  Row(
                    children: const [
                      Text("Welcome Back!",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: "Patrick",
                          fontSize: 40,
                          fontWeight: FontWeight.bold ,
                          color: Colors.white
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 50),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        // Row(
                        //   children: const [
                        //     Text('Email',
                        //       style: TextStyle(
                        //         fontSize: 15.5,
                        //         color: Colors.white70
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        const SizedBox(
                          height: 5,
                        ),
                        InputIt(hint: 'Your Email',controller: _email,readonly: (loading)?true:false,),
                        const SizedBox(
                          height: 20,
                        ),
                        // Row(
                        //   children: const [
                        //     Text('Password',
                        //       style: TextStyle(
                        //           fontSize: 15.5,
                        //           color: Colors.white70
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        const SizedBox(
                          height: 5,
                        ),
                        InputIt(hint: 'Your Password',controller: _password,readonly: (loading)?true:false),
                        const SizedBox(
                          height: 40,
                        ),
                        (loading==true)?LoadingWidget():ClickMe(title: "Submit",doing: (){
                          CheckCred(context) ;
                        }),
                        const SizedBox(
                          height: 30,
                        ),
                        TextButton(
                            onPressed: (){

                              Navigator.of(context).push(createRoute("forget"));
                            },
                            child: const Text(
                                'Forget Password?',
                              style: TextStyle(
                                  fontSize: 13,
                                color: Color(0xFFD9D9D9),
                                fontFamily: "ubantu"
                              ),
                            )
                        ),

                        const SizedBox(
                          height: 10.0,
                        ),
                        const Text(
                          'OR',
                          style: TextStyle(
                              fontSize: 13,
                              color: Color(0xFFD9D9D9),
                              fontFamily: "ubantu"
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        TextButton(
                            onPressed: (){
                              Navigator.of(context).push(createRoute("signup"));
                            },
                            child: const Text(
                              "Don't have an account?",
                              style: TextStyle(
                                  fontSize: 15.5,
                                fontFamily: "ubantu",
                                color: Color(0xFFD9D9D9),
                              ),
                            )
                        ),
                      ],
                    ),
                  ),

                ],
              ),
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
  (st=="forget")?ForgetPassword():
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
