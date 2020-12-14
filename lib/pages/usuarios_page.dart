import 'package:flutter/material.dart';
import 'package:lifechat/models/user.dart';
import 'package:lifechat/services/auth_service.dart';
import 'package:lifechat/services/chat_service.dart';
import 'package:lifechat/services/socket_service.dart';
import 'package:lifechat/services/users_service.dart';
import 'package:provider/provider.dart';

class UsuariosPage extends StatefulWidget {
  @override
  _UsuariosPageState createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  bool serverConnected = false;
  List<User> usuarios = [];

  _loadUsers() async {
    final usersService = UsersService();
    this.usuarios = await usersService.getUsuarios();
    setState(() {});
  }

  @override
  void initState() {
    _loadUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final socketService = Provider.of<SocketService>(context);
    serverConnected = socketService.serverStatus == ServerStatus.Online;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: "icon",
              child: Image(
                height: 30,
                image: AssetImage('assets/tag-logo.png'),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Text('It\' Me!'),
          ],
        ),
        leading: IconButton(
          icon: Icon(Icons.exit_to_app),
          onPressed: () {
            socketService.disconnect();
            AuthService.deleteToken()
                .then((value) => Navigator.pushReplacementNamed(context, 'login'));
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.check_circle,
              color: serverConnected ? Colors.lightGreen : Colors.redAccent,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (_, i) => ListTile(
          title: Text(usuarios[i].name),
          leading: CircleAvatar(
            child: Text(usuarios[i].name.substring(0, 2)),
          ),
          trailing: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
                color: usuarios[i].online ? Colors.lightGreen : Colors.redAccent,
                borderRadius: BorderRadius.circular(100)),
          ),
          onTap: () {
            final chatService = Provider.of<ChatService>(context, listen: false);
            chatService.userTo = usuarios[i];
            Navigator.pushNamed(context, 'chat');
          },
        ),
        separatorBuilder: (_, i) => Divider(),
        itemCount: usuarios.length,
      ),
    );
  }
}
