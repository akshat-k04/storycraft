class OTPModel{
  String? email ;
  String?OTP ;
  OTPModel({this.email, this.OTP }) ; // object

  Map<String,dynamic> MapForOTPSend(){
    return {
      "email": email ,
    };
  }
  Map<String,dynamic> MapForOTPvarify(){
    return {
      "email": email ,
      "otp":OTP
    };
  }
}