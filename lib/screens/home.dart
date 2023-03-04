import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app_firebase/screens/login.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CollectionReference task =
      FirebaseFirestore.instance.collection('task');

  void deleteTask(docId) {
    task.doc(docId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: AppBar(
            title: Row(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const Text('TaskBuddy'),
                const SizedBox(
                  width: 240,
                ),
                IconButton(
                    onPressed: () async => {
                          await FirebaseAuth.instance.signOut(),
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Login(),
                              ),
                              (route) => false)
                        },
                    icon: const Icon(Icons.logout))
              ],
            ),
            backgroundColor: Colors.indigo,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add');
        },
        backgroundColor: Colors.indigo,
        child: const Icon(
          Icons.add,
          size: 40.0,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: StreamBuilder(
        stream: task.orderBy('title').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot taskSnap = snapshot.data!.docs[index];
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 80.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(255, 233, 233, 233),
                            blurRadius: 10.0,
                            spreadRadius: 15.0,
                          )
                        ]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: CircleAvatar(
                              backgroundColor: Colors.indigo,
                              radius: 30.0,
                              child: Text(
                                taskSnap['type'],
                                style: const TextStyle(
                                    fontSize: 12.0, color: Colors.amber),
                              ),
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              taskSnap['title'],
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              taskSnap['des'],
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/update',
                                    arguments: {
                                      'title': taskSnap['title'],
                                      'des': taskSnap['des'],
                                      'type': taskSnap['type'],
                                      'id': taskSnap.id,
                                    });
                              },
                              icon: const Icon(Icons.edit),
                              iconSize: 30.0,
                              color: Colors.green[600],
                            ),
                            IconButton(
                              onPressed: () {
                                deleteTask(taskSnap.id);
                              },
                              icon: const Icon(Icons.delete),
                              iconSize: 30.0,
                              color: Colors.red,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
