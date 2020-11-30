import 'package:flutter/material.dart';
import 'package:lifechat/pages/chat_page.dart';
import 'package:lifechat/pages/login_page.dart';
import 'package:lifechat/pages/register_page.dart';
import 'package:lifechat/pages/splash_page.dart';
import 'package:lifechat/pages/usuarios_page.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'usuarios': (_) => UsuariosPage(),
  'chat': (_) => ChatPage(),
  'login': (_) => LoginPage(),
  'register': (_) => RegisterPage(),
  'splash': (_) => SplashPage()
};
