import 'package:flutter/material.dart';
import 'package:lifechat/widgets/button_form.dart';
import 'package:lifechat/widgets/input_form.dart';
import 'package:lifechat/widgets/labels.dart';
import 'package:lifechat/widgets/logo.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.lightGreen,
          body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.95,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Logo(
                      titulo: 'Messenger',
                    ),
                    _Form(),
                    Labels(
                      routeTo: 'register',
                      label: 'Crea una ahora',
                    ),
                    Text(
                      'Términos y condiciones de uso',
                      style: TextStyle(fontWeight: FontWeight.w200),
                    )
                  ],
                ),
              ))),
    );
  }
}

class _Form extends StatefulWidget {
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          InputForm(
            icon: Icons.mail_outline,
            placeholder: 'Email',
            textController: emailCtrl,
            keyBoardType: TextInputType.emailAddress,
          ),
          InputForm(
            icon: Icons.lock_outlined,
            placeholder: 'Pass',
            textController: passCtrl,
            isPassword: true,
            keyBoardType: TextInputType.visiblePassword,
          ),
          ButtonForm(
              backgroundColor: Colors.blue,
              pressfn: () {
                print('login');
              },
              btnText: "Acceder")
        ],
      ),
    );
  }
}
