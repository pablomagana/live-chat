import 'package:flutter/material.dart';
import 'package:lifechat/models/usuarios.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  Usuario userDest = Usuario(uid: '1', name: 'Jaime', email: 'test1@gmail,com', online: true);

  final _textController = new TextEditingController();
  final _focusNode = new FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        title: Row(
          children: [
            CircleAvatar(
              child: Text(userDest.name.substring(0, 2), style: TextStyle(fontSize: 16)),
              backgroundColor: Colors.white,
            ),
            SizedBox(
              width: 10,
            ),
            Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(userDest.name),
                  userDest.online
                      ? Text(
                          'Online',
                          style: TextStyle(fontSize: 10),
                        )
                      : Container(),
                ]),
            Spacer(),
            IconButton(icon: Icon(Icons.perm_identity), onPressed: () {})
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                  reverse: true,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (_, i) => Text(
                        '$i',
                        style: TextStyle(color: Colors.black),
                      )),
            ),
            Divider(
              height: 2,
            ),
            Container(
              height: 70,
              color: Colors.blue.withOpacity(0.4),
              child: _chatBox(),
            )
          ],
        ),
      ),
    );
  }

  Widget _chatBox() {
    return SafeArea(
        child: Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Flexible(
              child: TextField(
            controller: _textController,
            onSubmitted: (value) {},
            onChanged: (value) {},
            decoration: InputDecoration.collapsed(hintText: ''),
            focusNode: _focusNode,
          )),
          IconButton(
              icon: Icon(
                Icons.keyboard_arrow_right_rounded,
                size: 40,
                color: Colors.blue,
              ),
              onPressed: null)
        ],
      ),
    ));
  }
}
