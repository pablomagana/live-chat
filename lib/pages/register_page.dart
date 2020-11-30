import 'package:flutter/material.dart';
import 'package:lifechat/widgets/button_form.dart';
import 'package:lifechat/widgets/input_form.dart';
import 'package:lifechat/widgets/labels.dart';
import 'package:lifechat/widgets/logo.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.lightGreen,
          body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Logo(
                      titulo: 'Registro',
                    ),
                    _Form(),
                    Labels(
                      routeTo: 'login',
                      label: "Accede con tu cuenta",
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
  final nameCtrl = TextEditingController();
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
            icon: Icons.perm_identity_outlined,
            placeholder: 'Nombre',
            textController: nameCtrl,
            keyBoardType: TextInputType.name,
          ),
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
