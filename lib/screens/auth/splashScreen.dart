import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storycraft/screens/auth/login.dart';

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
    // await Firebase.initializeApp(
    //   options: DefaultFirebaseOptions.currentPlatform,
    // );
    await Future.delayed(const Duration(seconds: 2)) ;

    print ("done for firebase") ;
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
      Navigator.of(context).pushAndRemoveUntil(createRoute('home'),(Route<dynamic> route) => false);
    }
    else {
      Navigator.of(context).pushReplacement(createRoute('login'));

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


Route createRoute(String st) {

  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
    (st=="home")?const HomePage():

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
