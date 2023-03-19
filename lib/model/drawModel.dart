import 'dart:typed_data';

class DrawModel{
  Uint8List image ;
  String name ;
  DrawModel({required this.name, required this.image }) ; // object


  Map<String,dynamic> DrawingSend(){
    return {
      "name": name ,
      "image":image
    };
  }
}