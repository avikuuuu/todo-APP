import 'package:flutter/material.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({super.key});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Todo')),
      body: ListView(padding: const EdgeInsets.all(20), children: [
        TextField(
          decoration: InputDecoration(hintText: 'Tittle'),
        ),
        TextField(
          decoration: InputDecoration(
            hintText: 'description',
          ),
          minLines: 5,
          maxLines: 10,
          keyboardType: TextInputType.multiline,
        ),
        SizedBox(
          height: 15,
        ),
        ElevatedButton(onPressed: submitData, child: Text("submit")),
      ]),
    );
  }

  void submitData() {}
}
