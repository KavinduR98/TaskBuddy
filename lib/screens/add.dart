import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final actionType = ['Pending', 'Complete'];
  String? selectedActionType;

  final CollectionReference task =
      FirebaseFirestore.instance.collection('task');

  TextEditingController taskTitle = TextEditingController();
  TextEditingController taskDes = TextEditingController();

  void addTask() {
    final data = {
      'title': taskTitle.text,
      'des': taskDes.text,
      'type': selectedActionType
    };
    task.add(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Task'),
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
                  addTask();
                  Navigator.pop(context);
                },
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(
                    const Size(double.infinity, 50),
                  ),
                  backgroundColor: MaterialStateProperty.all(Colors.indigo),
                ),
                child: const Text(
                  'Submit',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
