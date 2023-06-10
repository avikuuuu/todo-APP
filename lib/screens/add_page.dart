import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({super.key});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Todo')),
      body: ListView(padding: const EdgeInsets.all(20), children: [
        TextField(
          controller: titleController,
          decoration: InputDecoration(hintText: 'Tittle'),
        ),
        TextField(
          controller: descriptionController,
          decoration: InputDecoration(
            hintText: 'description',
          ),
          minLines: 5,
          maxLines: 10,
          keyboardType: TextInputType.multiline,
        ),
        const SizedBox(
          height: 15,
        ),
        ElevatedButton(onPressed: submitData, child: const Text("submit")),
      ]),
    );
  }

  void submitData() async {
    // Get the data from form
    final title = titleController.text;
    final description = descriptionController.text;
    final body = {
      "title": title,
      "description": description,
      "is_completed": false
    };
    // Submit data to the server
    final url = 'https://api.nstack.in/v1/todos';
    final uri = Uri.parse(url);
    final request = await http.post(uri,
        body: jsonEncode(body), headers: {'Content-Type': 'application/json'});

    // show success or fail message based on status
    if (request.statusCode == 201) {
      titleController.text = '';
      descriptionController.text = '';
      print("sucessfully executed");
      successMessage('creation sucessfully ');
    } else {
      print("failfully executed");
      showErrorMessage("failed to execute");
      print(request.body);
    }
  }

  void successMessage(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showErrorMessage(String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

 
}
