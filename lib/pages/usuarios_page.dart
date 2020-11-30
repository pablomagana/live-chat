import 'package:flutter/material.dart';
import 'package:lifechat/models/usuarios.dart';

class UsuariosPage extends StatefulWidget {
  @override
  _UsuariosPageState createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  bool serverConnected = false;
  final usuarios = [
    Usuario(uid: '1', name: 'Loreto', email: 'test1@gmail.com', online: true),
    Usuario(uid: '2', name: 'Elisa', email: 'test2@gmail.com', online: false),
    Usuario(uid: '3', name: 'Jose', email: 'test3@gmail.com', online: true),
    Usuario(uid: '4', name: 'Marcos', email: 'test4@gmail.com', online: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('It\' Me!'),
        leading: IconButton(
          icon: Icon(Icons.exit_to_app),
          onPressed: () {},
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
