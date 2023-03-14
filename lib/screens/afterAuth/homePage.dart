import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storycraft/Providers/Auth.dart';
import 'package:storycraft/customWidget/InputField.dart';
import 'package:storycraft/customWidget/LongpressMDcard.dart';
import 'package:storycraft/customWidget/mdHeading.dart';
import 'package:storycraft/screens/afterAuth/previewScreen.dart';

import '../../API/firebaseDeepLinking.dart';
import '../../Providers/Md.dart';
import '../../Providers/color.dart';
import 'CreateMDFile.dart';
import 'Profile.dart';
import 'goal.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<HomePage> {
  String dropdownValue = 'Date(newest to oldest)';
  final TextEditingController _query = TextEditingController();


  @override
  void initState(){
    super.initState();
    FirebaseDynamicLink.initdynamiclink(context) ;

  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authprder = Provider.of<AuthProvider>(context) ;
    MDProvider MDProvid = Provider.of<MDProvider>(context);
    ColorProvider colrPrder = Provider.of<ColorProvider>(context) ;

    // tpm Andi = Provider.of<tpm>(context);

    var nickname = authprder.Name.split(" ") ;
    return WillPopScope(

      onWillPop: () async{
        await Future.delayed(const Duration(milliseconds: 100)) ;

        if(MDProvid.longprs){
          setState(() {
            MDProvid.changelong();
            MDProvid.updateIndx(-1) ;
          });
          return false ;
        }
        else{
          return true ;
        }

      },
      child: RefreshIndicator(
        onRefresh: ()async{
          MDProvider MDProvid = Provider.of<MDProvider>(context,listen: false);

          await MDProvid.fetchMD(authprder.Email) ;

        },
        child: Container(
        decoration:  BoxDecoration(
          color: Color(colrPrder.color),

        ),
        child: Scaffold(
          backgroundColor: Colors.transparent
            ,

          floatingActionButton: Column(
            children: [
              const Expanded(child: SizedBox()),
              FloatingActionButton(
                heroTag: "TODO",
                tooltip: "TODOS",
                onPressed: () async{
                  if(MDProvid.longprs){
                    MDProvid.changelong() ;
                    MDProvid.updateIndx(-1) ;
                  }
                  await Future.delayed(const Duration(milliseconds: 100)) ;
                  Navigator.of(context).push(createRoute("goal",-1));
                },
                backgroundColor: Colors.white,
                child: const Icon(Icons.task_alt_rounded,color: Color(0xFF2C3333),),
              ),

              const SizedBox(height: 20,),
              FloatingActionButton(
                heroTag: "addMD",
                tooltip: "Add markdowns",

                onPressed: () async{
                  if(MDProvid.longprs){
                    MDProvid.changelong() ;
                    MDProvid.updateIndx(-1) ;
                  }
                  await Future.delayed(const Duration(milliseconds: 100)) ;
                  Navigator.of(context).push(createRoute("create",-1));
                },
                backgroundColor: Colors.white,
                child: const Icon(color: Color(0xFF2C3333), Icons.add),
              ),
            ],
          ),


          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 60,
                ),


                SizedBox(
                  height: 50,
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                       GestureDetector(
                        onTap: (){
                          if(MDProvid.longprs){
                            MDProvid.changelong() ;
                            MDProvid.updateIndx(-1) ;
                          }
                            Navigator.of(context).push(createRoute("profile",-1));

                        },
                        child: const Icon(
                            // CupertinoIcons.settings,
                            CupertinoIcons.profile_circled,
                            color: Colors.white,
                            size: 50,

                        ),
                      ),

                      const SizedBox(width: 20,) ,
                      (!MDProvid.longprs)?Expanded(child:InputIt(readonly: false,hint: "search",controller: _query,)):const SizedBox(),

                      const SizedBox(width: 20,)
                    ],
                  ),
                ),
                const SizedBox(
                  height: 55,
                ),
                Row(
                  children:  [
                    const SizedBox(
                      width: 30,
                    ),
                     Expanded(
                      child: Row(
                        children:  [
                          DefaultTextStyle(
                              style: const TextStyle(
                                  decoration: TextDecoration.none,
                                  fontSize: 40,

                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFFF2929)),
                              child: AnimatedTextKit(
                                totalRepeatCount: 1,
                                // repeatForever: true,
                              animatedTexts: [
                                TyperAnimatedText(' ',speed: const Duration(milliseconds: 200)),
                                TyperAnimatedText('Hello',speed: const Duration(milliseconds: 200)),

                        ],

                      ),
                          ),
                          // Text(
                          //   "Hello ",
                          //   textAlign: TextAlign.left,
                          //   style: TextStyle(
                          //       decoration: TextDecoration.none,
                          //       fontSize: 40,
                          //
                          //       fontWeight: FontWeight.bold,
                          //       color: Color(0xFFFF2929)),
                          // ),


                        ],
                      ),
                    ),

                    const SizedBox(
                      width: 20,
                    ),
                  ],
                ),
                Row(
                  children:  [
                    const SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DefaultTextStyle(
                          style: const TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: 40,

                              fontWeight: FontWeight.bold,
                              color: Color(0xFFF1FF4E)),
                          child: AnimatedTextKit(
                            totalRepeatCount: 1,
                            animatedTexts: [
                              TyperAnimatedText(' ',speed: const Duration(milliseconds: 1400)),
                              TyperAnimatedText(nickname[0],speed: const Duration(milliseconds: 200)),

                            ],

                          ),


                          // Text(
                          //   nickname[0],
                          //   textAlign: TextAlign.left,
                          //   style: const TextStyle(
                          //       decoration: TextDecoration.none,
                          //       fontSize: 40,
                          //
                          //       fontWeight: FontWeight.bold,
                          //       color: Color(0xFFF1FF4E)),
                          // ),
                        ),
                      ),
                    ),

                    const SizedBox(
                      width: 20,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),

                Row(
                  children: [
                    const SizedBox(
                      width: 30,
                      height: 50,
                    ),
                    Text("Today\n${"${DateTime.now()}".split(" ")[0]}",style: const TextStyle(
                      color:Colors.white,
                      fontFamily: "montserrat"
                    ),),

                    const Expanded(child: SizedBox()),


                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration:  BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25) ,
                      ),
                      child: DropdownButton<String>(
                        underline: const DropdownButtonHideUnderline(child: SizedBox(),),
                        value: dropdownValue,
                        items: <String>['Date(newest to oldest)','Date(oldest to newest)', 'A to Z', 'Z to A']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(fontSize: 10),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if(MDProvid.longprs){
                            MDProvid.changelong() ;
                            MDProvid.updateIndx(-1) ;
                          }
                          setState(() {
                            dropdownValue = newValue!;

                            if(newValue=="Date(oldest to newest)"){
                              MDProvid.sortdateOldToNew() ;
                            }
                            else if(newValue=="Date(newest to oldest)"){
                              MDProvid.sortMD() ;
                            }
                            else if(newValue=="A to Z"){
                              MDProvid.SortHeadAtoZ() ;
                            }
                            else if(newValue=="Z to A"){
                              MDProvid.SortHeadZtoA() ;
                            }
                          });
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    )
                  ],
                ),

                const SizedBox(
                  height: 30,
                ),

                //Markdown list begins from here
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                    color: Colors.white,

                  ),
                  child: (MDProvid.filteredMD(MDProvid.Query).isEmpty)?
                  Center(child: Column(
                    children:  [
                      const SizedBox(
                        height: 100,
                      ),
                      Text((MDProvid.MDlist.isEmpty)?"Add Markdown":"No MD Found"
                        ,style: const TextStyle(
                            fontSize: 30,
                            fontFamily: "helloFont"
                        ),),
                    ],
                  ))
                      :
                  Column(
                    children: [
                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: MDProvid.filteredMD(MDProvid.Query).length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: ()async{
                                if(!MDProvid.longprs){
                                  await Future.delayed(const Duration(milliseconds: 100)) ;
                                  Navigator.of(context).push(createRoute("preview",index));
                                }
                                else{
                                  setState(() {
                                    MDProvid.updateIndx(index) ;
                                  });
                                }
                              },
                              onDoubleTap: (){
                                MDProvid.indx = index ;
                                Navigator.of(context).push(createRoute("edit",index));

                              },
                              onLongPress: (){
                                setState(() {
                                  if(!MDProvid.longprs){
                                    MDProvid.changelong() ;
                                    MDProvid.indx = index ;
                                  }

                                });
                              },
                              child: (MDProvid.longprs==true && MDProvid.indx==index)? PressedMDCard(inde:MDProvid.indx):
                              MDHead(Head:"${MDProvid.filteredMD(MDProvid.Query)[index].heading}" , Date: "${MDProvid.filteredMD(MDProvid.Query)[index].date}",id:"${MDProvid.filteredMD(MDProvid.Query)[index].id}" ,colordecider: index,), // default
                            );
                          }

                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),

                ),







                // Expanded(
                //
                //   child: Container(
                //     // padding: const EdgeInsets.only(bottom: 5),
                //     padding:  EdgeInsets.symmetric(vertical: 5),
                //     margin: const EdgeInsets.fromLTRB(20, 30, 20, 10),
                //     decoration: const BoxDecoration(
                //       boxShadow: [
                //         BoxShadow(
                //           color: Colors.black26,
                //           blurRadius: 4.0, // soften the shadow
                //           spreadRadius: 2.0, //extend the shadow
                //         )
                //       ],
                //       color: Color.fromRGBO(255,245,238, 1),
                //       borderRadius: BorderRadius.all(Radius.circular(20)),
                //     ),
                //     child: SingleChildScrollView(
                //       child: Column(
                //         children:  [
                //
                //
                //         ],
                //       ),
                //     ),
                //   ),
                // ),


                const SizedBox(
                  height: 20,
                )

              ],
            ),
          ),
        ),
          ),
      ),
    );
  }
  Route createRoute(String st,int e) {
    MDProvider MDProvid =Provider.of<MDProvider>(context,listen:false) ;
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
      (st=="create")?CreateMD():
      (st=="edit")?CreateMD(md:MDProvid.filteredMD(MDProvid.Query)[e]):
      (st=="preview")?PreviewScreen(MDString: "${MDProvid.filteredMD(MDProvid.Query)[e].details}",head:"${MDProvid.filteredMD(MDProvid.Query)[e].heading}",dat: "${MDProvid.filteredMD(MDProvid.Query)[e].date}",):
      (st=="profile")?const Profile() :
      (st=="goal")?const Goal() :
      CreateMD(),
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

}