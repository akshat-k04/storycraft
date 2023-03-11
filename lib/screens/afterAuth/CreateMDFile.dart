
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storycraft/model/MDModel.dart';
import 'package:storycraft/screens/afterAuth/homePage.dart';
import 'package:storycraft/screens/afterAuth/previewScreen.dart';
import 'package:uuid/uuid.dart';

import '../../Providers/Auth.dart';
import '../../Providers/Md.dart';
import '../../Providers/color.dart';
import '../../customWidget/Toast.dart';

class CreateMD extends StatefulWidget{
  var md;
  CreateMD({super.key,this.md});

  @override
  State<StatefulWidget> createState() {
    return MDState() ;
  }

}

class MDState extends State<CreateMD> {


  TextEditingController bodycont = TextEditingController();
  TextEditingController titlecont = TextEditingController();

  @override
    void initState() {

    // TODO: implement initState
    super.initState();
    if(widget.md!=null){
      titlecont.text = "${widget.md.heading}";
      bodycont.text= "${widget.md.details}";
    }
  }
  void processIt(BuildContext context){
    if(titlecont.text.isEmpty){
      showToast(context, "Please wirte the Title") ;
    }
    else if(bodycont.text.isEmpty){
      showToast(context, "content must not be empty") ;
    }
    else{
      AuthProvider prder = Provider.of<AuthProvider>(context,listen: false);
      MDProvider MDProvid = Provider.of<MDProvider>(context,listen: false);

      if(widget.md!=null){
        MDmodel temper =MDmodel(
          email: prder.Email,
          heading: titlecont.text,
          details: bodycont.text,
          date: "${DateTime.now()}",
          localid:"${MDProvid.MDlist[MDProvid.indx].localid}" ,
        );
        print("firnt") ;
        MDProvid.updateMD(temper) ;
      }
      else{
        MDmodel temper =MDmodel(
          email: prder.Email,
          heading: titlecont.text,
          details: bodycont.text,
          date:"${DateTime.now()}" ,
          localid: "${prder.Email}${const Uuid().v1()}" ,
        );

        MDProvid.addMD(temper);
      }

      Navigator.of(context).pop(
          createRoute("home"));
    }
  }

  @override
  Widget build(BuildContext context) {
    ColorProvider colrPrder = Provider.of<ColorProvider>(context) ;

    return Scaffold(

      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery
              .of(context)
              .size
              .height,
          decoration: BoxDecoration(
            color: Color(colrPrder.color),

          ),

          child: Column(
            children: [
              const SizedBox(
                height: 65,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    (widget.md==null)?"Create":"Update",
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 43,
                        fontFamily: "roboto",
                        fontWeight:FontWeight.w500,
                        color: Color(0xFFFF2929)),
                  ),
                  const Text(
                    " your",
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
              Row(
                children:  [
                  const SizedBox(
                    width: 20,
                  ),

                  Row(
                    children: const [
                      Text(
                        "Markdown",
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
                ],
              ),

              SizedBox(
                height: 40,
              ),

              Container(
                height: 80,
                padding: const EdgeInsets.symmetric(
                    vertical: 0.0, horizontal: 10.0),
                margin: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 10.0),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  color: Color(0xFFE9F8F9),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4.0, // soften the shadow
                      spreadRadius: 2.0, //extend the shadow
                    )
                  ],
                ),
                child: Center(
                  child: TextField(
                    controller: titlecont,
                    cursorColor: Colors.blueGrey,
                    style: TextStyle(
                        fontFamily: "poppins",

                        fontSize: 20.0, fontWeight: FontWeight.bold),
                    decoration: const InputDecoration(

                        hintText: "Title", border: InputBorder.none),
                  ),
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
                  child: TextField(
                    controller: bodycont,
                    cursorColor: Colors.blueGrey,
                    maxLines: null,
                    style: const TextStyle(
                      fontSize: 17.0,
                      fontFamily: "montserrat"
                    ),
                    decoration: const InputDecoration(
                        hintText: "WRITE HERE",
                        border: InputBorder.none),
                  ),

                ),
              ),

              const SizedBox(
                height: 10,
              ),


              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton(
                    onPressed: () {
                      processIt(context) ;
                    },
                    backgroundColor: Colors.white,
                    child: const Icon(
                      Icons.save,
                      color: Color(0xFF2C3333),

                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      if(bodycont.text.isEmpty){
                        showToast(context, "content must not be empty") ;
                      }
                      else{
                        Navigator.of(context).push(
                            createRoute("preview"));
                      }

                    },
                    backgroundColor: Colors.white,
                    child: const Icon(
                      Icons.preview_rounded,
                      color: Color(0xFF2C3333),

                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }

  Route createRoute(String st) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          st=="home"?HomePage():PreviewScreen(MDString: bodycont.text,head:titlecont.text,dat: "not_saved_yet",),
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
