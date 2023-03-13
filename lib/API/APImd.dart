
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:storycraft/model/MDModel.dart';



class MDAPI {
    static String baseurl ="https://storycraftbackend.onrender.com" ;


     static Future<List<MDmodel>> getdata(String email)  async {
      List<MDmodel> MDdata=[] ;
      Uri requestUri = Uri.parse("$baseurl/md/get") ;
      print("helo") ;
      var response = await http.post(requestUri,body: MDmodel(email: email).mapForMDget());
      print("helo2") ;
      var decoded = jsonDecode(response.body)["bol"];



      for(var MDmap in decoded){
        MDmodel temp = MDmodel(
        heading : MDmap["heading"] ,
        details : MDmap["details"] ,
        email : MDmap["email"] ,
        date : MDmap["date"] ,
        id : MDmap["_id"], 
        localid:MDmap["localid"]
        );

        MDdata.add(temp);
      }
      return MDdata ;
    }



    static Future<String> addata(MDmodel temp)  async {
      Uri requestUri = Uri.parse("$baseurl/md/add") ;
      var response = await http.post(requestUri,body: temp.mapForMDAdd());
      var decoded = jsonDecode(response.body).bol;

      return decoded ;
    }

    static Future<MDmodel> findSpecificMarkdown(MDmodel temp)  async {
      Uri requestUri = Uri.parse("$baseurl/md/find") ;
      var response = await http.post(requestUri,body: temp.mapForMDFind());
      var decoded = jsonDecode(response.body).bol;

      return decoded ;
    }


    static Future<String> deletedata(MDmodel temp )  async {
      Uri requestUri = Uri.parse("$baseurl/md/delete") ;
      var response = await http.post(requestUri,body: temp.mapForMDdelete());
      var decoded = jsonDecode(response.body).bol;

      return decoded ;
    }


    static Future<String> updatedata(MDmodel temp )  async {
      Uri requestUri = Uri.parse("$baseurl/md/update") ;
      var response = await http.post(requestUri,body: temp.mapForMDupdate());
      var decoded = jsonDecode(response.body).bol;

      return decoded ;
    }

}