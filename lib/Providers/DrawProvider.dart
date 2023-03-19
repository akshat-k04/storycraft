
import 'package:flutter/cupertino.dart';

import '../API/APIDraw.dart';
import '../model/drawModel.dart';

class DrawProvider with ChangeNotifier{
  List<DrawModel> post=[] ;

  Future<void>fetchpost(String email) async {

    post = await DrawApi.getdata() ;
    notifyListeners();
  }

  void deletePost(DrawModel temper)async{

    await DrawApi.deleteata(temper) ;
  }

  void addPost(DrawModel temper)async{

    await DrawApi.addata(temper) ;
  }
}