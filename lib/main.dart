import 'package:flutter/material.dart';
import 'package:todo_app_firebase/screens/add.dart';
import 'package:todo_app_firebase/screens/login.dart';
import 'package:todo_app_firebase/screens/splash.dart';
import 'screens/home.dart';
import 'screens/update.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapShot) {
          // Check for Errors
          if (snapShot.hasError) {
            print("Something Went Wrong");
          }
          if (snapShot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return MaterialApp(
            title: "Todo App with Firebase Authentication",
            theme: ThemeData(
              primarySwatch: Colors.indigo,
            ),
            debugShowCheckedModeBanner: false,
            routes: {
              '/': (context) => const Splash(),
              '/login': (context) => const Login(),
              '/add': (context) => const AddTask(),
              '/update': (context) => const UpdateTask()
            },
            initialRoute: '/',
          );
        });
  }
}
