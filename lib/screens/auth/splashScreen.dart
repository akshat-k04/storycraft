import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storycraft/API/firebaseDeepLinking.dart';
import 'package:storycraft/customWidget/LoadingWidget.dart';
import 'package:storycraft/screens/auth/login.dart';

import '../../Providers/Auth.dart';
import '../../Providers/Md.dart';
import '../../Providers/color.dart';
import '../../firebase_options.dart';
import '../afterAuth/homePage.dart';

class SplashScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
   return StateSplash() ;
  }
}

class StateSplash extends State<SplashScreen>{
  @override
  void initState() {
    // TODO: implement initState
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
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );


    print ("done for firebase") ;
    if(email!=null){

      print ("intil") ;

      await prder.getAuthData(email);
      await MDProvid.fetchMD(email) ;
      print ("done for ") ;

      //TODO:- get data of user
      Navigator.of(context).pushAndRemoveUntil(createRoute('home'),(Route<dynamic> route) => false);
    }
    else {
      Navigator.of(context).pushReplacement(createRoute('login'));

    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:  BoxDecoration(
        color:  Colors.white,
      ),
      child: Column(
        children:  [
          const SizedBox(
            height: 200,
          ),
          const Image(  image: AssetImage("assets/photo/logo.png"),),
          SizedBox(
            height: 150,
          ),
          LoadingWidget(Changewhite: true,) ,
        ],
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
