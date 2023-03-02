import 'package:flutter/material.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final actionType = ['P', 'C'];
  String? selectedActionType;

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
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            // ignore: prefer_const_constructors
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: const TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), label: Text('Title')),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                keyboardType: TextInputType.multiline,
                maxLength: 50,
                decoration: InputDecoration(
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
                  onPressed: () {},
                  style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(
                          const Size(double.infinity, 50)),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.indigo)),
                  child: const Text(
                    'Submit',
                    style: TextStyle(fontSize: 20.0),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
