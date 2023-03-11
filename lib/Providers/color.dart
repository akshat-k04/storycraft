import 'package:flutter/cupertino.dart';

class ColorProvider with ChangeNotifier{
  int color = 0xFF6C5B7B ;
  void changecolor (int col){
    color = col  ;
    notifyListeners() ;
  }

}