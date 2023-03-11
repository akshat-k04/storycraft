import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class MDHead extends StatefulWidget{
  String Head ;
  String Date ;
  String id ;
  int colordecider ;
  MDHead({super.key,required this.Head,required this.Date,required this.id,required this.colordecider});

  @override
  State<StatefulWidget> createState() {
    return MDHeadState() ;
  }

}

class MDHeadState extends State<MDHead>{


  @override
  Widget build(BuildContext context) {

    return Container(
      height: 100,
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      decoration:  BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        color: (widget.colordecider%5==0)?Color(0xFFEDF1D6):
        (widget.colordecider%5==1)?Color(0xFFDFFFD8):
        (widget.colordecider%5==2)?Color(0xFFBAD7E9):
        (widget.colordecider%5==3)?Color(0xFFF5EAEA):
            Color(0xFFE3DFFD)
        ,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4.0, // soften the shadow
            spreadRadius: 2.0, //extend the shadow
          )
        ],
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 5,
          ),
          Row(
            children:  [
              const SizedBox(
                width: 20,
              ),
              Text(widget.Date.split(" ")[1].split(".")[0]),
              SizedBox(width: 15,),
              Expanded(child: Text(widget.Date.split(" ")[0])),
              const SizedBox(
                width: 20,
              ),
              (widget.id=="null")?Icon(CupertinoIcons.clock):Icon(Icons.done_all),
              const SizedBox(
                width: 20,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              Text(
                // Head,
                (widget.Head.length>30)?"${widget.Head.substring(0,30)}...":widget.Head,
                style: const TextStyle(fontSize: 20,
                  fontFamily: "poppins",

                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),

        ],
      ),
    );
  }

}