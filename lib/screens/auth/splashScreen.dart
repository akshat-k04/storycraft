import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storycraft/customWidget/Toast.dart';
import 'package:storycraft/model/MDModel.dart';
import 'package:storycraft/screens/afterAuth/previewScreen.dart';
import 'package:storycraft/screens/auth/login.dart';
import 'package:uni_links/uni_links.dart';

import '../../Providers/Auth.dart';
import '../../Providers/Md.dart';
import '../../Providers/color.dart';
import '../afterAuth/homePage.dart';

class SplashScreen extends StatefulWidget{

  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() {
   return StateSplash() ;
  }
}

class StateSplash extends State<SplashScreen>{
  bool fetch = false  ;

  Object? _err;
  bool _initialURILinkHandled = false;
  StreamSubscription? _streamSubscription;
  @override
  void initState() {
    super.initState();
    nevigate();
  }


  nevigate()async{

    AuthProvider prder = Provider.of<AuthProvider>(context,listen: false);
    MDProvider MDProvid = Provider.of<MDProvider>(context,listen: false);
    ColorProvider colrPrder = Provider.of<ColorProvider>(context,listen: false) ;

    SharedPreferences sp = await SharedPreferences.getInstance();
    int? l =sp.getInt("color") ;
    if(l!= null){
      colrPrder.changecolor(l) ;
    }
    String? email = sp.getString('email') ;

    await Future.delayed(const Duration(seconds: 2)) ;

    if(email!=null){

      print ("intil") ;
      setState(() {
        fetch = true ;
      });
      await prder.getAuthData(email);
      await MDProvid.fetchMD(email) ;
      print ("done for ") ;
      setState(() {
        fetch =false ;
      });
      await _initURIHandler(true) ;
    }
    else {
      _initURIHandler(false) ;


    }
  }



  Future<void> _initURIHandler(bool autologin) async {
    // 1
    if (!_initialURILinkHandled) {
      _initialURILinkHandled = true;
      // 2

        // 3
        final initialURI = await getInitialUri();
        // 4
        if (initialURI != null) {
          debugPrint("Initial URI received $initialURI");
          //send to preview screen


          String? localid = "${initialURI}".substring(45);
          print(localid) ;
          // showToast(context, localid) ;
          await Provider.of<MDProvider>(context, listen: false).FindMD(
              MDmodel(localid: localid));
          if (Provider
              .of<MDProvider>(context, listen: false)
              .DynamicLinkMD
              .localid != localid) {
            if (autologin) {
              Navigator.of(context).pushAndRemoveUntil(
                  createRoute('home', context), (
                  Route<dynamic> route) => false);
            }
            else {
              Navigator.of(context).pushReplacement(
                  createRoute('login', context));
            }
          }
          else {
            Navigator.of(context).pushAndRemoveUntil(
                createRoute('preview', context), (
                Route<dynamic> route) => false);
          }
        } else {
          debugPrint("Null Initial URI received");
          if (autologin) {
            Navigator.of(context).pushAndRemoveUntil(
                createRoute('home', context), (Route<dynamic> route) => false);
          }
          else {
            Navigator.of(context).pushReplacement(
                createRoute('login', context));
          }
        }
    }
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration:  const BoxDecoration(
          color:  Colors.white,
        ),
        child: Column(
          children:  [
            const SizedBox(
              height: 150,
            ),
            const SizedBox(
                width:370,
                child: Image(  image: AssetImage("assets/photo/logo.png"),)),
            const SizedBox(
              height: 150,
            ),
            // LoadingWidget(Changewhite: true,) ,


            (fetch)?DefaultTextStyle(

              style: const TextStyle(
                  decoration: TextDecoration.none ,
                  fontSize: 12,
                  color: Colors.black
              ),
              child: AnimatedTextKit(
                repeatForever: true,
                pause: Duration(seconds: 2),
                animatedTexts: [
                  TypewriterAnimatedText('Fetching data!',speed: Duration(milliseconds: 100)),
                ],

              ),
            ):const SizedBox(),
            const SizedBox(height: 300,),
          ],
        ),
      ),
    ) ;
  }

}


Route createRoute(String st,BuildContext context) {
  MDProvider mdp =Provider.of<MDProvider>(context,listen: false) ;
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
    (st=="home")?const HomePage():
    (st=="preview")? PreviewScreen(MDString: mdp.DynamicLinkMD.details, head: mdp.DynamicLinkMD.heading, dat: mdp.DynamicLinkMD.date) :
    login(),
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
