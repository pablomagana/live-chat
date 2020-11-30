import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Image(
            image: AssetImage('assets/tag-logo.png'),
          ),
        ),
      ),
    );
  }
}
