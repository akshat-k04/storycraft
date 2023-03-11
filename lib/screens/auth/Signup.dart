import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storycraft/customWidget/LoadingWidget.dart';
import 'package:storycraft/screens/auth/OTPvalidation.dart';
import 'package:email_validator/email_validator.dart';
import '../../Providers/Auth.dart';
import '../../Providers/color.dart';
import '../../customWidget/Button.dart';
import '../../customWidget/InputField.dart';
import '../../customWidget/Toast.dart';

class SignUp extends StatefulWidget{
  const SignUp({super.key});

  @override
  State<StatefulWidget> createState() {
    return SignUpState() ;
  }
}

class SignUpState extends State<SignUp>{
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _name = TextEditingController();
  final _confirm = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool loading  = false ;

  Process() async {

    AuthProvider prder = Provider.of<AuthProvider>(context,listen: false);
    if(_formKey.currentState!.validate()){
      // means validated
      setState(() {
        loading=true ;
      });
      if(!EmailValidator.validate(_email.text)){

        showToast(context, "please enter valid email address") ;
      }
      else if(await prder.Userexistance(_email.text)){
        showToast(context, "Email address already used") ;
      }
      else if(_password.text == _confirm.text){
        prder.SignupOTPsend(_email.text, _password.text,_name.text);
        setState(() {
          loading=false ;
        });
        Navigator.of(context).push(createRoute("otppg"));
      }
      else{
        showToast(context, "Password not match") ;
      }
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
      child: Form(
        key: _formKey,
        child: Scaffold(
          backgroundColor: Colors.transparent,

          body: SingleChildScrollView(
            child: Container(
              margin:const EdgeInsets.fromLTRB(30, 120, 30, 40),
              color: Colors.transparent,
              child: Column(
                children:  [
                  Row(
                    children: const [
                      Text("Set Up Your Profile",
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
                        SizedBox(
                          height: 30,
                        ),
                        // Row(
                        //   children: const [
                        //     Text('Full Name',
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
                        InputIt(hint: 'Your Name',controller: _name,readonly: (loading)?true:false),
                        const SizedBox(
                          height: 18,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        // Row(
                        //   children: const [
                        //     Text('Email',
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
                        InputIt(hint: 'Your email Address',controller: _email,readonly: (loading)?true:false),
                        const SizedBox(
                          height: 18,
                        ),
                        const SizedBox(
                          height: 15,
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
                          height:18,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        // Row(
                        //   children: const [
                        //     Text('Confirm Password',
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
                        InputIt(hint: 'Your Password',controller: _confirm,readonly: (loading)?true:false),
                        const SizedBox(
                          height: 50,
                        ),
                        (loading)?LoadingWidget():ClickMe(title: "Send OTP",doing: (){
                          Process() ;
                        }),
                        const SizedBox(
                          height: 30.0,
                        ),


                        TextButton(
                            onPressed: (){
                              Navigator.of(context).pop(createRoute("login"));
                            },
                            child: const Text(
                              "Already have an account?",
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
    (st=="otppg")?OTPScreen():
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
