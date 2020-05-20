import 'package:flutter/material.dart';
import 'package:hireme/models/User.dart';
import 'package:hireme/screens/home.dart';
import 'package:hireme/screens/login_signup.dart';
import 'package:provider/provider.dart';

class Router extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    if (user == null) {
      return LoginSignup();
    } else {
      return HomePage();
    }
  }
}
