import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:storycraft/model/OTPmodel.dart';

import '../model/AuthenticationModels.dart';


class APIService {
  static String baseurl ="https://storycraftbackend.onrender.com" ;


  static Future<AuthModel> getdata(String email )  async {
    Uri requestUri = Uri.parse("$baseurl/auth/getdata") ;
    print("helo");
    var response = await http.post(requestUri,body: AuthModel(email: email,password: "").createMapForLogin());
    print("helo2");

    var decoded = jsonDecode(response.body);
    print("helo3");

    AuthModel userInfo= AuthModel(
      name:decoded["name"] ,
      password:decoded["password"] ,
      email:decoded["email"] ,

    );
    return userInfo ;
  }



  static Future<String> login(String email , String pass)  async {


    Uri requestUri = Uri.parse("$baseurl/auth/login") ;
    print("getting data") ;
    var response = await http.post(requestUri,body: AuthModel(email: email,password: pass).createMapForLogin());
    print("recived data") ;

    var decoded = jsonDecode(response.body);
    return decoded["bol"] ;
  }


  static Future<String> ForgetPass(String email , String pass)  async {


    Uri requestUri = Uri.parse("$baseurl/auth/forgetPassword") ;
    var response = await http.post(requestUri,body: AuthModel(email: email,password: pass).createMapForLogin());

    var decoded = jsonDecode(response.body);
    return decoded["bol"] ;
  }


  static Future<bool> userExistance(String email)  async {


    Uri requestUri = Uri.parse("$baseurl/auth/userchecker") ;
    var response = await http.post(requestUri,body: OTPModel(email: email).MapForOTPSend());

    var decoded = jsonDecode(response.body);
    return decoded["bol"] ;
  }


  static Future<bool> MakeUser(String email , String pass, String name)  async {
    Uri requestUri = Uri.parse("$baseurl/auth/signup") ;
    var response = await http.post(requestUri,body: AuthModel(email: email,password: pass,name: name).SignupModel());
    var decoded = jsonDecode(response.body);
    if(decoded["bol"]=="user exist"){
      return false ;
    }
    else{
      return true ;
    }
  }



  static Future<void> SendOTP(String Email) async{
    Uri requestUri = Uri.parse("$baseurl/otp/send") ;
    var response = await http.post(requestUri,body: OTPModel(email: Email).MapForOTPSend());
    var decoded = jsonDecode(response.body);

    print(decoded["bol"]) ; // print done if send
  }




  static Future<String> varifyOTP(String Email,String OTP) async{
    Uri requestUri = Uri.parse("$baseurl/otp/varify") ;
    print("helo") ;
    print(Email) ;
    var response = await http.post(requestUri,body: OTPModel(email: Email,OTP: OTP).MapForOTPvarify());
    var decoded = jsonDecode(response.body);
    return decoded["bol"] ;
  }
}