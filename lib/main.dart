import 'package:flutter/material.dart';
import 'package:hireme/models/User.dart';
import 'package:hireme/screens/login_signup.dart';
import 'package:hireme/screens/router.dart';
import 'package:hireme/services/authentication.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(HireMe());
}


class HireMe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().userStream,
      child: MaterialApp(
        title: 'Hireme App',
        theme: new ThemeData(
          primarySwatch: Colors.red,
        ),
        home: Router(),
      ),
    );
  }
}
