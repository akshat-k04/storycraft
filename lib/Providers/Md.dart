import 'package:flutter/cupertino.dart';
import 'package:storycraft/API/APImd.dart';

import '../model/MDModel.dart';

class MDProvider with ChangeNotifier{
  List<MDmodel> MDlist=[] ;
  String Query ="" ;
  bool longprs= false  ;
  int indx = -1 ;
   MDmodel DynamicLinkMD=MDmodel() ;

  void updateQuery (String val){
    Query = val ;
    print("calin") ;
    notifyListeners() ;
  }

  void changelong (){
    longprs = !longprs ;
    notifyListeners() ;
  }

  void updateIndx (int e){
    indx = e ;
    notifyListeners() ;
  }

  Future<void> FindMD(MDmodel MD)async{
    print("hhii");
    DynamicLinkMD = await MDAPI.findSpecificMarkdown(MD) ;
  }


  void sortMD(){
    MDlist.sort((a,b)=> b.date!.compareTo((a.date! )));
  }

  void addMD(MDmodel MD)async{
    MDlist.add(MD);
    sortMD();
    notifyListeners();
    await MDAPI.addata(MD);


  }


  void updateMD(MDmodel MD){
    int index = MDlist.indexOf(MDlist.firstWhere((element) => element.localid== MD.localid));
    MDlist[index]= MD ;
    sortMD();
    notifyListeners();

    MDAPI.updatedata(MD) ;
  }

  void deleteMD(MDmodel MD)async{

    int index = MDlist.indexOf(MDlist.firstWhere((element) => element.localid== MD.localid));
    MDlist.removeAt(index) ;
    sortMD();
    notifyListeners();
    await MDAPI.deletedata(MD) ;
  }

  Future<void>fetchMD(String email) async {

    MDlist = await MDAPI.getdata(email) ;
    sortMD() ;
    notifyListeners();
  }


  List<MDmodel> filteredMD(String query){
    return MDlist.where((element) => element.heading!.toLowerCase().contains(query.toLowerCase())||element.details!.toLowerCase().contains(query.toLowerCase())).toList();
  }
}