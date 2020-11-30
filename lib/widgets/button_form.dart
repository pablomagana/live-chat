import 'package:flutter/material.dart';

class ButtonForm extends StatelessWidget {
  final backgroundColor;
  final Function pressfn;
  final btnText;
  ButtonForm({@required this.backgroundColor, @required this.pressfn, @required this.btnText});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      elevation: 2,
      highlightElevation: 5,
      color: this.backgroundColor,
      shape: StadiumBorder(),
      child: Container(
        width: double.infinity,
        child: Center(
          child: Text(
            this.btnText,
            style: TextStyle(color: Colors.white, fontSize: 17),
          ),
        ),
      ),
      onPressed: this.pressfn,
    );
  }
}
