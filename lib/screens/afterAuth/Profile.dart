import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storycraft/Providers/color.dart';
import 'package:storycraft/customWidget/profiledetail.dart';
import 'package:storycraft/screens/auth/Signup.dart';
import 'package:storycraft/screens/auth/login.dart';

import '../../Providers/Auth.dart';


class Profile extends StatefulWidget{
  const Profile({super.key});

  @override
  State<StatefulWidget> createState() {
    return ProfileState() ;
  }

}

class ProfileState extends State<Profile>{

  @override
  Widget build(BuildContext context) {
    AuthProvider authprder = Provider.of<AuthProvider>(context) ;
    ColorProvider colrPrder = Provider.of<ColorProvider>(context) ;
    return Container(
        decoration:  BoxDecoration(
          color: Color(colrPrder.color),

        ),

    child: Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: ()async {
          authprder.Name="" ;
          authprder.Password="";
          authprder.Email="" ;
          SharedPreferences preferences = await SharedPreferences.getInstance();
          await preferences.remove('email');
          await preferences.clear();
          Navigator.of(context).pushAndRemoveUntil(createRoute("login"),(Route<dynamic> route) => false);
        },
        child: const Text(
          "logout",
          style: TextStyle(
            fontFamily: "helloFont",
            color: Colors.black
          ),
        )

      ),
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 120,
              ),
              Row(
                children: const [
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Your",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 43,
                        fontFamily: "roboto",
                        fontWeight:FontWeight.w500,
                      color: Color(0xFFFF2929),

                    ),
                  ),

                ],
              ),
              Row(
                children: const [
                  SizedBox(
                    width: 20,
                  ),

                  Text(
                    "Profile",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      fontSize: 43,
                      fontFamily: "roboto",
                      fontWeight:FontWeight.w500,
                      color: Color(0xFFF1FF4E),

                    ),
                  ),

                ],
              ),
              const SizedBox(
                height: 30,
              ),
              ProfileWidget(value:authprder.Name),
              const SizedBox(
                height: 8,
              ),
              ProfileWidget(value: authprder.Email,),
              const SizedBox(
                height: 50,
              ),



              const Text("App Theme",
                style: TextStyle(
                  fontFamily: "montserrat",
                  fontSize: 30,
                  color: Colors.white60
                ),
              ) ,

              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.all(40),
                width: 330,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),

                ),
                child: Column(

                  children: [

                    Row(
                      children: [
                        FloatingActionButton(
                            onPressed: ()async{
                              SharedPreferences sp = await SharedPreferences.getInstance();
                              sp.setInt('color', 0xFF2C3333);
                              colrPrder.changecolor(0xFF2C3333) ;

                            },
                          backgroundColor: const Color(0xFF2C3333),
                        ),
                        const SizedBox(width: 40,) ,




                        FloatingActionButton(
                          onPressed: ()async{
                            SharedPreferences sp = await SharedPreferences.getInstance();
                            sp.setInt('color', 0xFF1E1E1E);
                            colrPrder.changecolor(0xFF1E1E1E) ;

                          },
                          backgroundColor: const Color(0xFF1E1E1E),
                        ),
                        const SizedBox(width: 40,) ,




                        FloatingActionButton(

                          onPressed: ()async{
                            SharedPreferences sp = await SharedPreferences.getInstance();
                            sp.setInt('color', 0xFF1C82AD);
                            colrPrder.changecolor(0xFF1C82AD) ;
                          },
                          backgroundColor: const Color(0xFF1C82AD),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),




                    Row(
                      children: [
                        FloatingActionButton(
                            onPressed: ()async{
                              SharedPreferences sp = await SharedPreferences.getInstance();
                              sp.setInt('color', 0xFF4E6E81);
                              colrPrder.changecolor(0xFF4E6E81) ;

                            },
                          backgroundColor: const Color(0xFF4E6E81),
                        ),
                        const SizedBox(width: 40,) ,




                        FloatingActionButton(
                            onPressed: ()async{
                              SharedPreferences sp = await SharedPreferences.getInstance();

                              sp.setInt('color', 0xFF6C5B7B);
                              colrPrder.changecolor(0xFF6C5B7B) ;
                              //
                            },
                          backgroundColor: const Color(0xFF6C5B7B),
                        ),
                        const SizedBox(width: 40,) ,




                        FloatingActionButton(
                            onPressed: ()async{
                              SharedPreferences sp = await SharedPreferences.getInstance();
                              sp.setString('color', "0xFF3C6255");
                              colrPrder.changecolor(0xFF3C6255) ;

                            },
                          backgroundColor: const Color(0xFF3C6255),
                        ),
                      ],
                    ),
                  ],
                ),
              )













              // Container(
              //   height: 300,
              //   margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              //   decoration: const BoxDecoration(
              //     borderRadius: BorderRadius.all(Radius.circular(20)),
              //     color: Colors.white,
              //     boxShadow: [
              //       BoxShadow(
              //         color: Colors.black12,
              //         blurRadius: 4.0, // soften the shadow
              //         spreadRadius: 2.0, //extend the shadow
              //       )
              //     ],
              //
              //   ),
              //   child: SingleChildScrollView(
              //     child: Column(
              //       children: [
              //         SizedBox(height: 20,),
              //         Row(
              //           children: const [
              //             SizedBox(width: 20,),
              //             Text("LeaderBoard",
              //               style: TextStyle(
              //                 fontWeight: FontWeight.bold,
              //                   fontSize: 40
              //               ),
              //             )
              //           ],
              //         ),
              //         Member(),
              //         Member(),
              //         Member(),
              //         Member(),
              //         Member(),
              //       ],
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
    )
    ) ;
  }

}



Route createRoute(String st) {

  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
    (st=="login")?login():
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
