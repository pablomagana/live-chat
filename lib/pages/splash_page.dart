import 'package:flutter/material.dart';
import 'package:lifechat/services/auth_service.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: (context, snapshot) => Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Hero(
              tag: 'icon',
              child: Image(
                image: AssetImage('assets/tag-logo.png'),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future checkLoginState(BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final logged = await authService.isLogged();
    if (logged) {
      Navigator.pushReplacementNamed(context, 'usuarios');
    } else {
      Navigator.pushReplacementNamed(context, 'login');
    }
  }
}
