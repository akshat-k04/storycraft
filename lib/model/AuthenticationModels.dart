class AuthModel{
  String? email ;
  String? password ;
  String?name ;
  AuthModel({this.email , this.password,this.name}) ; // object



  //i made this map to send the send not to get the data

  //the response i get is stored as object as i mentained above
  Map<String,dynamic> createMapForLogin(){
    return {
      "email": email ,
      "password":password
    };
  }

  Map<String,dynamic> SignupModel(){
    return {
      "email": email ,
      "password":password,
      "name": name
    };
  }




}