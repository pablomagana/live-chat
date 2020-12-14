import 'package:flutter/material.dart';
import 'package:lifechat/models/chat_response.dart';
import 'package:lifechat/models/user.dart';
import 'package:lifechat/services/auth_service.dart';
import 'package:lifechat/services/chat_service.dart';
import 'package:lifechat/services/socket_service.dart';
import 'package:lifechat/widgets/chat_message.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  ChatService chatService;
  SocketService socketService;
  AuthService authService;

  User userDest;

  List<ChatMessage> _messages = [];
  bool _isWritting = false;
  final _textController = new TextEditingController();
  final _focusNode = new FocusNode();

  @override
  void initState() {
    this.chatService = Provider.of<ChatService>(context, listen: false);
    this.socketService = Provider.of<SocketService>(context, listen: false);
    this.authService = Provider.of<AuthService>(context, listen: false);

    this.socketService.socket.on('msg-user', _handlerRecivedMessage);

    _loadChat(this.chatService.userTo.uid);

    super.initState();
  }

  _handlerRecivedMessage(data) {
    ChatMessage msg = new ChatMessage(
        text: data['msg'], uid: data['userFrom'], animationController: createAnimationController());

    print(msg.text);
    setState(() {
      _messages.insert(0, msg);
      msg.animationController.forward();
    });
  }

  _loadChat(String userId) async {
    List<Message> chat = await this.chatService.getChat(userId);

    final history = chat.map((m) => ChatMessage(
        text: m.msg, uid: m.userFrom, animationController: createAnimationController()..forward()));
    setState(() {
      _messages.insertAll(0, history);
    });
  }

  @override
  Widget build(BuildContext context) {
    userDest = chatService.userTo;
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
            onChanged: (text) {
              if (text.trim().length > 0)
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
          uid: authService.user.uid, text: text, animationController: createAnimationController());
      this.socketService.emit(
          'msg-user', {'userTo': userDest.uid, 'userFrom': authService.user.uid, 'msg': text});
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

  AnimationController createAnimationController() {
    return new AnimationController(vsync: this, duration: Duration(milliseconds: 500));
  }
}
