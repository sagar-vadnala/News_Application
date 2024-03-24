import 'package:flutter/material.dart';
import 'package:news_application/pages/login_page.dart';
import 'package:news_application/pages/register_page.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {

  //initially show login page
  bool showLoginPage = true;

  //toggle between login and register page
  void tooglePage(){
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }
  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(onTap: tooglePage,);
    } else {
      return RegisterPage(onTap: tooglePage,);
    }
  }
}