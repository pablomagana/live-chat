import 'package:flutter/material.dart';
import 'package:lifechat/models/user.dart';
import 'package:lifechat/services/auth_service.dart';

class UsuariosPage extends StatefulWidget {
  @override
  _UsuariosPageState createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  bool serverConnected = false;
  final usuarios = [
    User(uid: '1', name: 'Loreto', email: 'test1@gmail.com', online: true),
    User(uid: '2', name: 'Elisa', email: 'test2@gmail.com', online: false),
    User(uid: '3', name: 'Jose', email: 'test3@gmail.com', online: true),
    User(uid: '4', name: 'Marcos', email: 'test4@gmail.com', online: false),
  ];

  @override
  Widget build(BuildContext context) {
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
            AuthService.deleteToken()
                .then((value) => Navigator.pushReplacementNamed(context, 'login'));
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.check_circle_rounded,
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
        ),
        separatorBuilder: (_, i) => Divider(),
        itemCount: usuarios.length,
      ),
    );
  }
}
