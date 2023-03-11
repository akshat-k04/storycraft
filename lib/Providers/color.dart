import 'package:flutter/cupertino.dart';

class ColorProvider with ChangeNotifier{
  int color = 0xFF4E6E81 ;
  void changecolor (int col){
    color = col  ;
    notifyListeners() ;
  }

}