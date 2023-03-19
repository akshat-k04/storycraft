import 'package:document_file_save_plus/document_file_save_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
// import 'package:provider/provider.dart';
import 'package:scribble/scribble.dart';
// import 'package:storycraft/Providers/DrawProvider.dart';
import 'package:storycraft/customWidget/Toast.dart';
// import 'package:storycraft/model/drawModel.dart';

// import '../../Providers/Auth.dart';
import '../../customWidget/DrawingToolBar.dart';

class Drawing extends StatefulWidget {
  const Drawing({super.key});

  @override
  State<StatefulWidget> createState() {
    return DrawingState();
  }
}

class DrawingState extends State<Drawing> {
  late ScribbleNotifier notifier;
  late ScribbleState state;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notifier = ScribbleNotifier();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,



      body: StateNotifierBuilder<ScribbleState>(
        stateNotifier: notifier,
        builder : (context,state,_)=>
            Stack(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SingleChildScrollView(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      // height: ( * 2>MediaQuery.of(context).size.width * 2)?MediaQuery.of(context).size.height * 2:MediaQuery.of(context).size.width * 2,
                      // width: (MediaQuery.of(context).size.height * 2>MediaQuery.of(context).size.width * 2)?MediaQuery.of(context).size.height * 2:MediaQuery.of(context).size.width * 2,
                      width:2*MediaQuery.of(context).size.width ,
                      child: Scribble(
                        notifier: notifier,
                        drawPen: true,
                      ),
                    ),
                  ),
                ),
                // this widget make the space for drawing

                Positioned(
                  bottom:30,
                    right: 16,
                    child: Column(
                      children: [
                        IconButton(
                          onPressed: () {  },
                          icon: const Icon(Icons.people_outline,size: 30,),
                        ),
                        IconButton(

                          onPressed: () {  SaveImg(context) ;},
                          icon:const Icon(Icons.save_alt_rounded,color: Colors.black,size: 30,),
                        ),
                      ],
                    )
                ),
                Positioned(
                  top: 46,
                  right: 16,
                  child:ColorToolBar(notifier: notifier,state: state,),
                ),
                Positioned(
                    top: 46,
                    left: 78,
                    child: SizedBox(
                      height: 40,
                      child: EditToolBar(notifier: notifier,st: state.allowedPointersMode == ScribblePointerMode.penOnly,),
                    )
                ),
              ],
            ),
      ),
    );
  }
  void SaveImg(BuildContext context)async{
    final image = await notifier.renderImage();
    final Uint8List pngBytes = image.buffer.asUint8List();
    showDialog(
      context: context,
      builder: (context) =>  AlertDialog(
        title: const Text("Your Image"),
        content: SizedBox(
          height: 310,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: Colors.black
                    )
                ),
                child:Image.memory(image.buffer.asUint8List()),
              ),
              // const Text("Note:Once Shared You Can't delete It") ,
            ],
          ),
        ),
        actions: [
          // TextButton(
          //     onPressed: (){
          //       ShareLocally(pngBytes,"anonymous");
          //       Navigator.of(context).pop(true);
          //     } ,
          //     child: const Text('Share(anonymously)',style: TextStyle(color: Colors.black),)),
          // TextButton(
          //     onPressed: (){
          //       AuthProvider authProvid = Provider.of<AuthProvider>(context);
          //       ShareLocally(pngBytes,authProvid.Name);
          //       Navigator.of(context).pop(true);
          //     } ,
          //     child: const Text('Share',style: TextStyle(color: Colors.black),)),

          TextButton(
              onPressed: (){
                saveLocally(pngBytes);
                Navigator.of(context).pop(true);
              } ,
              child: const Text('save it',style: TextStyle(color: Colors.black),))
        ],

      ),
    );
  }

  // void ShareLocally(Uint8List pngBytes,String name)async{
  //   DrawProvider drprder = Provider.of<DrawProvider>(context) ;
  //
  //   DrawModel temper = DrawModel(name: name, image: pngBytes) ;
  //   drprder.addPost(temper) ;
  //   print("added Successfully") ;
  //   //now the code is different
  // }
  void saveLocally(Uint8List pngBytes)async{
    final String nme =DateTime.now().millisecond.toString() ;
    DocumentFileSavePlus().saveFile(
        pngBytes,
        nme,
        "image/png");
    //code is same to same as saveLocally

    showToast(context, 'image saved successfully!');
  }
}



