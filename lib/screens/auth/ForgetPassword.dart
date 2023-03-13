import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storycraft/customWidget/LoadingWidget.dart';

import '../../Providers/Auth.dart';
import '../../Providers/Md.dart';
import '../../Providers/color.dart';
import '../../customWidget/Button.dart';
import '../../customWidget/InputField.dart';
import '../../customWidget/Toast.dart';
import '../afterAuth/homePage.dart';
import 'Signup.dart';

class ForgetPassword extends StatefulWidget{
  const ForgetPassword({super.key});

  @override
  State<StatefulWidget> createState() {
    return ForgetState() ;
  }

}

class ForgetState extends State<ForgetPassword>{
  final _email = TextEditingController();
  final _otp = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();

  bool showOTP = false ;
  bool OTPvalidate =false ;

  bool loading = false ;
  @override
  Widget build(BuildContext context) {
    AuthProvider prder = Provider.of<AuthProvider>(context,listen: false);
    ColorProvider colrPrder = Provider.of<ColorProvider>(context) ;

    return  Container(
      decoration: BoxDecoration(
        color: Color(colrPrder.color),

      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,

        body: SingleChildScrollView(
          child: Container(
            margin:const EdgeInsets.fromLTRB(30, 200, 30, 40),
            color: Colors.transparent,
            child: Column(
              children:  [
                Row(
                  children: const [
                    Text("Recover Password",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontFamily: "Patrick",
                          fontSize: 35,
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
                //       Row(
                //         children: [
                //           (!showOTP)?const Text('Email',
                //             style: TextStyle(
                //                 fontSize: 15.5,
                //                 color: Colors.white70
                //             ),
                //           )
                //               :(!OTPvalidate)?const Text('OTP',
                //   style: TextStyle(
                //       fontSize: 15.5,
                //       color: Colors.white70
                //   ),
                // ):const Text('Enter password',
                //             style: TextStyle(
                //                 fontSize: 15.5,
                //                 color: Colors.white70
                //             ),
                //           ),
                //
                //         ],
                //       ),
                      const SizedBox(
                        height: 25,
                      ),
                      (!showOTP)?InputIt(hint: 'kakshat35@gmail.com',controller: _email,readonly: (loading)?true:false):
                      (!OTPvalidate)?InputIt(hint: 'Enter OTP',controller: _otp,readonly: (loading)?true:false):
                      InputIt(hint: 'Your Password',controller: _password,readonly: (loading)?true:false),
                      const SizedBox(
                        height: 18,
                      ),
                      // Row(
                      //   children:[
                      //     OTPvalidate?const Text('Confirm password',
                      //       style: TextStyle(
                      //           fontSize: 15.5,
                      //           color: Colors.white70
                      //       ),
                      //     ):const SizedBox(
                      //
                      //     ),
                      //   ],
                      // ),
                      const SizedBox(
                        height: 5,
                      ),
                      (OTPvalidate)?InputIt(hint: "Your Password", controller: _confirm,readonly: (loading)?true:false):const SizedBox() ,
                      const SizedBox(
                        height: 30,
                      ),
                      (showOTP)?(OTPvalidate)?
                      (loading)?LoadingWidget():ClickMe(
                              title: "set password",
                              doing: ()async{
                                MDProvider MDProvid = Provider.of<MDProvider>(context,listen: false);
                                setState(() {
                                  loading=true ;
                                });
                                if(_password.text == _confirm.text){
                                  if(await prder.updatepass(_email.text, _password.text)=="password updated"){
                                    await Provider.of<AuthProvider>(context,listen: false).getAuthData(_email.text);
                                    await MDProvid.fetchMD(_email.text) ;

                                    //TODO:- fetch all info of user
                                    setState(() {
                                      loading=false ;
                                    });
                                    Navigator.pushAndRemoveUntil(context,createRoute('home'),(Route<dynamic> route) => false);
                                  }
                                  else {
                                    showToast(context,"there is problem in backend .please try again later") ;
                                  }
                                }
                                else{
                                  showToast(context,"password not match") ;
                                }
                                setState(() {
                                  loading=false ;
                                });
                              }
                          )
                      :(loading)?LoadingWidget():ClickMe(
                          title: "submit",
                          doing: ()async{
                            setState(() {
                              loading=true ;
                            });
                            int al =await prder.VarifyOTP(_otp.text);
                            if(al==0){
                              showToast(context,"enter valid OTP") ;
                              // Toster( "Enter valid OTP") ;
                            }
                            else if(al==1){
                              showToast(context,"user not exist") ;
                            }
                            else {
                              Provider.of<AuthProvider>(context,listen: false).login = true ;
                              setState(() {
                                OTPvalidate=true ;
                              });
                              showToast(context,"OTP is correct") ;
                            }
                            setState(() {
                              loading=false ;
                            });
                      }):


                      (loading)?LoadingWidget():ClickMe(title: "Get OTP",
                          doing: ()async{
                            setState(() {
                              loading=true ;
                            });
                            if(!EmailValidator.validate(_email.text)){
                              showToast(context,"enter valid email address") ;
                            }
                            else if(await prder.Userexistance(_email.text)){
                              prder.ForgetOTPsend(_email.text);
                              setState(() {
                                showOTP = true ;
                              });
                            }
                            else{
                              showToast(context,"user not exist") ;
                            }
                            setState(() {
                              loading=false ;
                            });
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
