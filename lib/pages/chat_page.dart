import 'package:flutter/material.dart';
import 'package:lifechat/models/user.dart';
import 'package:lifechat/widgets/chat_message.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  User userDest = User(uid: '1', name: 'Jaime', email: 'test1@gmail,com', online: true);

  List<ChatMessage> _messages = [];
  bool _isWritting = false;
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
                itemCount: this._messages.length,
                itemBuilder: (_, i) => this._messages[i],
              ),
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
            onSubmitted: _handlerInput,
            onChanged: (value) {
              if (value.trim().length > 0)
                this._isWritting = true;
              else
                this._isWritting = false;
              setState(() {});
            },
            decoration: InputDecoration.collapsed(hintText: ''),
            focusNode: _focusNode,
          )),
          IconTheme(
            data: IconThemeData(color: Colors.blue),
            child: IconButton(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                icon: Icon(
                  Icons.send,
                  size: 40,
                ),
                onPressed: _isWritting ? () => _handlerInput(_textController.text) : null),
          )
        ],
      ),
    ));
  }

  _handlerInput(String text) {
    _textController.clear();
    _focusNode.requestFocus();
    _isWritting = false;
    setState(() {
      final message = new ChatMessage(
          uid: '123',
          text: text,
          animationController:
              AnimationController(vsync: this, duration: Duration(milliseconds: 500)));
      this._messages.insert(0, message);
      message.animationController.forward();
    });
  }

  @override
  void dispose() {
    for (var i = 0; i < _messages.length; i++) {
      _messages[i].animationController.dispose();
    }
    super.dispose();
  }
}
