import 'package:flutter/cupertino.dart';
import 'package:storycraft/API/APIauth.dart';
import 'package:storycraft/model/AuthenticationModels.dart';

class AuthProvider with ChangeNotifier{
  String Email ="" ;
  String Password = "" ;
  String Name = "" ;
  var status = "" ;
  bool login = false ;



  Future<void> getAuthData(String email )async {
    AuthModel info = await APIService.getdata(email)  ;
    Email = info.email! ;
    Name = info.name! ;
    // Password = info.password! ;
    login = true ;
    notifyListeners() ;
  }

  Future<String> checkLogin(String email , String password)async {

    status = await APIService.login(email, password)  ;
    if(status=="success"){
      login=true ;
    }
    return status ;
  }


  Future<String> updatepass(String email , String password)async {

    status = await APIService.ForgetPass(email, password)  ;
    return status ;
  }

  Future<bool> Userexistance(String email )async {
    bool cv =await APIService.userExistance(email) ;
    return cv  ;
    // 1 means user exist
    // 0 means not exist
  }

  Future<void> SignupOTPsend(String email , String password , String name)async {
    Email=email ;
    Password = password ;
    Name = name ;
    await APIService.SendOTP(email)  ;

  }
  Future<void> ForgetOTPsend(String email)async {
    Email=email ;
    await APIService.SendOTP(email)  ;
  }


  Future<int> VarifyOTP(String OTP )async {
    String val = await APIService.varifyOTP(Email,OTP)  ;


    // return 1 if usermade
    // 0 if wrong otp
    // -1 if user is already


    if(val=="varified") {
      bool vl = await APIService.MakeUser(Email, Password, Name) ;
      if(vl==true){

        return 1 ;
      }
      else{
        return -1;
      }
    }
    else{
      return 0 ;
    }

  }
}