import 'package:flutter/material.dart';
import 'package:flutter_connectdbdemo/adduser.dart';
import 'package:flutter_connectdbdemo/home.dart';
import 'package:flutter_connectdbdemo/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login':(context) => const Login(),
        '/register':(context) => const AddUser(),
        //'/update':(context) => const UpdateUser(),
        '/home':(context) => const Home(),
      },
    );
  }
}