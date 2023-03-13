import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:provider/provider.dart';
import 'package:storycraft/screens/auth/login.dart';
import 'package:uuid/uuid.dart';

import '../../Providers/Auth.dart';
import '../../Providers/Md.dart';
import '../../Providers/color.dart';
import '../../customWidget/Toast.dart';
import '../../model/MDModel.dart';
import 'homePage.dart';

class PreviewScreen extends StatelessWidget {
  final MDString;
  final head ;
  final dat;
  String ? email ;
  PreviewScreen({super.key, required this.MDString,required this.head,required this.dat,this.email});

  void processIt(BuildContext context){

      AuthProvider prder = Provider.of<AuthProvider>(context,listen: false);
      MDProvider MDProvid = Provider.of<MDProvider>(context,listen: false);


        MDmodel temper =MDmodel(
          email: prder.Email,
          heading: head,
          details: MDString,
          date:"${DateTime.now()}" ,
          localid: "${prder.Email}${const Uuid().v1()}" ,
        );

        MDProvid.addMD(temper);

      Navigator.of(context).pop(
          createRoute("home"));

  }

  @override
  Widget build(BuildContext context) {
    AuthProvider prder = Provider.of<AuthProvider>(context,listen: false);
    ColorProvider colrPrder = Provider.of<ColorProvider>(context) ;

    return Scaffold(
        floatingActionButton: (prder.login==true && email!=null&& email!=prder.Email)?FloatingActionButton(
          heroTag: "logintrue",
        onPressed: () {
          processIt(context) ;
        },

          child: const Icon(
            Icons.save_alt,color: Colors.black54,
          ),
      ) :
        (prder.login==false)?FloatingActionButton(
          heroTag: "loginfalse",

          child: const Icon(
            Icons.login_rounded,
            color: Colors.black,
          ),
          onPressed: () {
            showToast(context, "ff");
            Navigator.of(context).pop(
                createRoute("login"));
          },

        ):null,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Color(colrPrder.color),
          ),
          child:Column(
            children: [

              const SizedBox(
                height: 65,
              ),
              Row(
                children: const [
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Preview ",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 43,
                        fontFamily: "roboto",
                        fontWeight:FontWeight.w500,
                        color: Color(0xFFFF2929)),
                  ),

                ],
              ),
          Row(
            children:const [
              SizedBox(
                width: 20,
              ),
               Text(
                "Screen",
                textAlign: TextAlign.left,
                style: TextStyle(
                    decoration: TextDecoration.none,
                    fontSize: 43,
                    fontFamily: "roboto",
                    fontWeight:FontWeight.w500,
                    color: Color(0xFFF1FF4E)),

              ),
            ],
          ),


              const SizedBox(
                height: 40,
              ),

          Container(
            height: 80,
            margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Color(0xFFE9F8F9),

              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4.0, // soften the shadow
                  spreadRadius: 2.0, //extend the shadow
                )
              ],
            ),
            child: Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text("${head}",
                      style:const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
              const SizedBox(
              height: 20,
            ),
            Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 10.0),
                  margin: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 10.0),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Color(0xFFE9F8F9),

                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4.0, // soften the shadow
                        spreadRadius: 2.0, //extend the shadow
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(child: Text("Date:${dat}".split(" ")[0])),
                          const SizedBox(
                            width: 10,
                          )
                        ],
                      ),
                      Expanded(child: Markdown(data: MDString,selectable: true,)),
                    ],
                  )
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }
  Route createRoute(String st) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
      st=="home"?const HomePage():
          st=="login"?login():
      PreviewScreen(MDString: "",head:"",dat: "not_saved_yet",),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;
        var tween = Tween(begin: begin, end: end).chain(
            CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
