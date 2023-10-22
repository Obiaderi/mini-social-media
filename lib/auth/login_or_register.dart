import 'package:flutter/material.dart';
import 'package:mini_social_media/pages/login_screen.dart';
import 'package:mini_social_media/pages/register_screen.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool isLogin = true;

  void toggleLogin() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLogin) {
      return LoginScreen(onTap: toggleLogin);
    } else {
      return RegisterScreen(onTap: toggleLogin);
    }
  }
}
