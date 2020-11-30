import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  final String text;
  final String uid;
  final AnimationController animationController;


  const ChatMessage({@required this.text,@required this.uid,@required this.animationController});

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
        opacity:animationController ,
          child: SizeTransition(
            sizeFactor: CurvedAnimation(parent:animationController,curve:Curves.easeInOut),
                      child: Container(
            child: this.uid == '123' ? _myMessage() : _externalMessage()),
          ),
    );
  }

  Widget _myMessage() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.only(left:50,right:10,bottom:10),
        child: Text(this.text,style: TextStyle(color: Colors.white),),
        decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(100)),
      ),
    );
  }

  Widget _externalMessage() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.only(left:50,right:10,bottom:10),
        child: Text(this.text,style: TextStyle(color: Colors.black),),
        decoration: BoxDecoration(color: Colors.grey.withOpacity(0.6),borderRadius: BorderRadius.circular(100)),
      ),
    );
  }
}
