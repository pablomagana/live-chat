import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  final String routeTo;
  final String label;

  const Labels({this.routeTo, this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            this.routeTo == 'register' ? '¿ No tienes cuenta ?' : '¿ Tienes cuenta ?',
            style: TextStyle(color: Colors.black54, fontSize: 15, fontWeight: FontWeight.w300),
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, this.routeTo);
            },
            child: Text(
              this.label,
              style: TextStyle(color: Colors.blue[600], fontSize: 18, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
