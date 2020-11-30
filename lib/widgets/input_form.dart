import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputForm extends StatelessWidget {
  final IconData icon;
  final String placeholder;
  final TextEditingController textController;
  final TextInputType keyBoardType;
  final bool isPassword;

  InputForm(
      {@required this.icon,
      @required this.placeholder,
      @required this.textController,
      this.keyBoardType = TextInputType.text,
      this.isPassword = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 5, left: 5, bottom: 5, right: 20),
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), offset: Offset(0, 5), blurRadius: 5)
          ]),
      child: TextField(
        controller: textController,
        autocorrect: false,
        keyboardType: TextInputType.emailAddress,
        obscureText: isPassword,
        decoration: InputDecoration(
            prefixIcon: Icon(icon),
            alignLabelWithHint: true,
            focusedBorder: InputBorder.none,
            border: InputBorder.none,
            hintText: placeholder),
      ),
    );
  }
}
