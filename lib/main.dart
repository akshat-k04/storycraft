import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:storycraft/Providers/color.dart';

import 'package:storycraft/screens/auth/splashScreen.dart';

import 'Providers/Auth.dart';
import 'Providers/Md.dart';

// ...


void main() async{

  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create:(context)=>AuthProvider()),
        ChangeNotifierProvider(create: (context)=> MDProvider()),
        ChangeNotifierProvider(create: (context)=> ColorProvider()),

        // ChangeNotifierProvider(create: (context)=> tpm())

      ],
      child: MaterialApp(

        title: 'StoryCraft',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch:Colors.brown,

        ),
        home: const BaseStruct(),
      ),
    );
  }
}

class BaseStruct extends StatelessWidget{

  const BaseStruct({super.key});

  @override
  Widget build(BuildContext context){

    return  AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          systemNavigationBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light),
      // child: login(),
      child: SplashScreen(),
    );
  }

}

