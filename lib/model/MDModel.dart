
class MDmodel {
  String ?heading;
  String ?details ;
  String ?date ;
  String ?email ;
  String ?id ;
  String ?localid ;
  MDmodel({ this.email ,  this.details, this.date,this.id, this.heading,this.localid}) ; // object


  Map<String,dynamic> mapForMDAdd(){
    return {
      "email": email ,
      "details":details,
      "date":date ,
      "heading":heading,
      "localid":localid
    };
  }

  Map<String,dynamic> mapForMDget(){
    return {
      "email": email ,

    };
  }

  Map<String,dynamic> mapForMDFind(){
    return {
      "localid":localid ,

    };
  }


  Map<String,dynamic> mapForMDupdate(){
    return {
      "email": email ,
      "details":details,
      "date":date ,
      "heading":heading,
      "localid":localid
    };
  }


  Map<String,dynamic> mapForMDdelete(){
    return {
      "email": email ,
      "localid":localid
    };
  }
}