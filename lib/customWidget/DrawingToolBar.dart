import 'package:flutter/material.dart';
import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';
import 'package:scribble/scribble.dart';



class ColorToolBar extends StatelessWidget{
  final ScribbleNotifier notifier;
  final ScribbleState state ;
  const ColorToolBar({
    super.key,
    required this.notifier,
    required this.state
  });

  @override
  Widget build(BuildContext context) {
    return
      Column(
        children: [
          buton(context, colr: Colors.purple, notifier: notifier),
          buton(context, colr: Colors.indigo, notifier: notifier),
          buton(context, colr: Colors.blue, notifier: notifier),
          buton(context, colr: Colors.green, notifier: notifier),
          buton(context, colr: Colors.yellow, notifier: notifier),
          buton(context, colr: Colors.orange, notifier: notifier),
          buton(context, colr: Colors.red, notifier: notifier),
          buton(context, colr: Colors.black, notifier: notifier),
          buton(context, colr: Colors.white, notifier: notifier),
          SizedBox(height: 25,),
          SizeBar(notifier: notifier, state: state),
          SizedBox(height: 25,),
          Costum(context ,notifier:notifier,state: state),
        ],

      );
  }

}


Widget Costum(BuildContext context,{required ScribbleNotifier notifier,required ScribbleState state }){

  return SizedBox(
    height: 45,
    width: 40,
    child: FloatingActionButton(
      heroTag: "color chooser",
        tooltip: 'custom color',
        backgroundColor:state.map(
          drawing: (s) => Color(s.selectedColor),
          erasing: (_) => Colors.transparent,
        ) ,
        onPressed: (){
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                  title: const Text("Choose color"),
                  content: CircleColorPicker(
                    //initialColor: Colors.black,
                    onChanged: (color) {notifier.setColor(color); },
                    size: const Size(240, 240),
                    strokeWidth: 4,
                    thumbSize: 36,
                  ),
                  actions:[
                    TextButton(onPressed:(){Navigator.of(context).pop(true);}, child: const Text('done'))
                  ]
              )
          );
        }),
  );
}

Widget buton(BuildContext context,{required Color colr,required ScribbleNotifier notifier}){

  return SizedBox(
    height: 45,
    width: 40,
    child: FloatingActionButton(
      heroTag: colr.toString(),
        tooltip: colr.toString(),
        backgroundColor: colr,
        onPressed: (){
          notifier.setColor(colr);
        }),
  );
}


class EditToolBar extends StatelessWidget{
  final ScribbleNotifier notifier ;
  final bool st;
  const EditToolBar({super.key,required this.notifier,required this.st});


  @override
  Widget build(BuildContext context) {
    return
      Row(
        children: [
          ModeSwitcher(context, editmode: !st, notifier: notifier ),
          ClearAll(context, notifier: notifier),
          Erase(context, notifier: notifier),
          Undo(context, notifier: notifier),
          Redo(context, notifier: notifier),

        ],

      );
  }

}

Widget ModeSwitcher(BuildContext context , {required bool editmode,required ScribbleNotifier notifier}){
  return SizedBox(
    height: 40,
    width: 45,
    child: FloatingActionButton(
      heroTag: "mode switcher",
        tooltip: editmode?"scroll Mode":"drawing Mode",
        backgroundColor: Colors.white,
        child: Icon(editmode?Icons.edit_off_rounded:Icons.edit_rounded,color: Colors.black,),
        onPressed: (){
          notifier.setAllowedPointersMode(editmode?ScribblePointerMode.penOnly:ScribblePointerMode.all);
        }),
  );
}

Widget ClearAll(BuildContext context ,{required ScribbleNotifier notifier}){
  return SizedBox(
    height: 40,
    width: 45,
    child: FloatingActionButton(
      heroTag: "clear all",
        tooltip: "clear all",
        backgroundColor: Colors.white,
        child: const Icon(Icons.rectangle_outlined,color: Colors.black,),
        onPressed: (){
          notifier.clear();
        }),
  );
}
Widget Erase(BuildContext context ,{required ScribbleNotifier notifier}){
  return SizedBox(
    height: 40,
    width: 45,
    child: FloatingActionButton(
      heroTag: "erase latest",
        tooltip: 'erase',
        backgroundColor: Colors.white,
        child: const Icon(Icons.remove_rounded,color: Colors.black,),
        onPressed: (){
          notifier.setEraser();
        }),
  );
}

Widget Undo(BuildContext context ,{required ScribbleNotifier notifier}){
  return SizedBox(
    height: 40,
    width: 45,
    child: FloatingActionButton(
      heroTag: "undo",
        tooltip: 'undo',
        backgroundColor:notifier.canUndo? Colors.white:Colors.grey,
        child: const Icon(Icons.undo_rounded,color: Colors.black,),
        onPressed: (){
          notifier.canUndo? notifier.undo():null;
        }),
  );
}

Widget Redo(BuildContext context ,{required ScribbleNotifier notifier}) {
  return SizedBox(
    height: 40,
    width: 45,
    child: FloatingActionButton(
      heroTag: "redo",
        tooltip: 'redo',
        backgroundColor: notifier.canRedo ? Colors.white : Colors.grey,
        child: const Icon(Icons.redo_rounded, color: Colors.black,),
        onPressed: () {
          notifier.canRedo ? notifier.redo() : null;
        }),
  );
}

class SizeBar extends StatelessWidget{
  final ScribbleNotifier notifier ;
  final ScribbleState state ;
  const SizeBar({
    super.key,
    required this.notifier,
    required this.state
  });


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final w in notifier.widths)
          _buildStrokeButton(
              context,
              strokeWidth: w,
              state: state,
              notifier: notifier
          )
      ],
    );
  }

}

Widget _buildStrokeButton(
    BuildContext context, {
      required double strokeWidth,
      required ScribbleState state,
      required ScribbleNotifier notifier
    }) {
  final selected = state.selectedWidth == strokeWidth;

  return SizedBox(
    width: strokeWidth*2.55,
    height: strokeWidth*2.6+5,
    child: FloatingActionButton(
      heroTag: "$strokeWidth",
      tooltip: "size =$strokeWidth",
      onPressed:(){notifier.setStrokeWidth(strokeWidth);} ,
      backgroundColor: selected?state.map(
        drawing: (s) => Color(s.selectedColor),
        erasing: (_) => Colors.transparent,
      ):Colors.black,
    ),
  );
}