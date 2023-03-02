import 'package:flutter/material.dart';
import 'package:todo_app_firebase/project/add.dart';
import 'project/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Demo App",
      routes: {
        '/': (context) => const HomePage(),
        '/add': (context) => const AddTask()
      },
      initialRoute: '/',
    );
  }
}
