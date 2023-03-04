import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateTask extends StatefulWidget {
  const UpdateTask({super.key});

  @override
  State<UpdateTask> createState() => _UpdateTaskState();
}

class _UpdateTaskState extends State<UpdateTask> {
  final actionType = ['Pending', 'Complete'];
  String? selectedActionType;

  final CollectionReference task =
      FirebaseFirestore.instance.collection('task');

  TextEditingController taskTitle = TextEditingController();
  TextEditingController taskDes = TextEditingController();

  void updateTask(docId) {
    final data = {
      'title': taskTitle.text,
      'des': taskDes.text,
      'type': selectedActionType,
    };
    task.doc(docId).update(data).then((value) => Navigator.pop(context));
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;

    taskTitle.text = args['title'];
    taskDes.text = args['des'];
    selectedActionType = args['type'];
    final docId = args['id'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Task'),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: taskTitle,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), label: Text('Title')),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: taskDes,
                keyboardType: TextInputType.multiline,
                maxLength: 50,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), label: Text('Description')),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: DropdownButtonFormField(
                  value: selectedActionType,
                  decoration:
                      const InputDecoration(label: Text('Select Task Status')),
                  items: actionType
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ))
                      .toList(),
                  onChanged: (val) {
                    selectedActionType = val;
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                  onPressed: () {
                    updateTask(docId);
                  },
                  style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(
                          const Size(double.infinity, 50)),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.indigo)),
                  child: const Text(
                    'Update',
                    style: TextStyle(fontSize: 20.0),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
