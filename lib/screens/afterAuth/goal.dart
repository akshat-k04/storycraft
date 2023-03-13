
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';






// class Goal extends StatefulWidget{
//   @override
//   State<StatefulWidget> createState() {
//    return _FilePickerAppState() ;
//   }
//
// }
//
//
//
// class _FilePickerAppState extends State<Goal> {
//   FilePickerResult? result;
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//         appBar: AppBar(
//           title: const Text("File picker demo"),
//         ),
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             if(result != null)
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text('Selected file:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
//                     ListView.builder(
//                         shrinkWrap: true,
//                         itemCount: result?.files.length ?? 0,
//                         itemBuilder: (context, index) {
//                           return Text(result?.files[index].name ?? '', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold));
//                         })
//                   ],
//                 ),),
//             Center(
//               child: ElevatedButton(
//                 onPressed: () async{
//                   result = await FilePicker.platform.pickFiles();
//                   if (result == null) {
//                     print("No file selected");
//                   } else {
//                     setState(() {
//                     });
//                     result?.files.forEach((element) {
//                       print(element.name);
//                     });
//                   }
//                 },
//                 child: const Text("File Picker"),
//               ),
//             ),
//
//           ],
//         ),
//
//     );
//   }
// }
//
class Goal extends StatelessWidget{
  const Goal({super.key});

  @override
  Widget build(BuildContext context) {
   return Container(
     padding: const EdgeInsets.all(10),
     child: Column(
       children: const [

         SizedBox(height: 50,) ,

         Text("Tasks",style: TextStyle(fontSize: 20),) ,
         SizedBox(height: 40,) ,
         Text("add todo feature and make its floating button on home screen",style: TextStyle(fontSize: 20),) ,
         SizedBox(height: 20,) ,

         Text("make a leader board of note count ",style: TextStyle(fontSize: 20),) ,
       ],
     ),
   ) ;
  }

}