import 'package:flutter/material.dart';
import 'package:flutter_schooldev/pages/auth/authentication.dart';
import 'package:flutter_schooldev/pages/auth/root_page.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'SchoolDev',
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(
          primarySwatch: Colors.lightGreen,
        ),
        home: new RootPage(auth: new Auth()));
  }
}
