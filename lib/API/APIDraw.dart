import 'dart:convert';

import 'package:storycraft/model/drawModel.dart';
import 'package:http/http.dart' as http;

class DrawApi {
  static String baseurl = "https://storycraftbackend.onrender.com";


  static Future<List<DrawModel>> getdata()  async {
    Uri requestUri = Uri.parse("$baseurl/draw/get") ;

    var response = await http.get(requestUri);



    var decoded = jsonDecode(response.body)["bol"];

    List<DrawModel> data = [] ;

    for(var MDmap in decoded) {
      DrawModel temp = DrawModel(
        name: MDmap["name"],
        image: MDmap["image"],
      );
      data.add(temp) ;
    }

    return data ;
  }
  static Future<String> addata(DrawModel temp)  async {
    Uri requestUri = Uri.parse("$baseurl/draw/add") ;
    print("drawing sending");
    var response = await http.post(requestUri,body: temp.DrawingSend());
    print("drawing sent");

    var decoded = jsonDecode(response.body)["bol"];

    return decoded ;
  }
  static Future<String> deleteata(DrawModel temp)  async {
    Uri requestUri = Uri.parse("$baseurl/draw/delete") ;
    var response = await http.post(requestUri,body: temp.DrawingSend());
    var decoded = jsonDecode(response.body)["bol"];

    return decoded ;
  }

}




