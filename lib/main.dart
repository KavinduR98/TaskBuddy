import 'package:flutter/material.dart';
import 'package:todo_app_firebase/project/add.dart';
import 'project/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
