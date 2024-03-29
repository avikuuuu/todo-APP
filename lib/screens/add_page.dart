import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_todo_rest_api/utils/snackbar_helper.dart';
import 'package:http/http.dart' as http;

class AddTodoPage extends StatefulWidget {
  final Map? todo;
  const AddTodoPage({super.key, this.todo});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  bool isEdit = false;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final todo = widget.todo;
    if (todo != null) {
      isEdit = true;
      final title = todo['title'];
      final description = todo['description'];
      titleController.text = title;
      descriptionController.text = description;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? 'Edit your Todo' : 'Add Todo')),
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
        ElevatedButton(
            onPressed: isEdit ? editData : submitData,
            child: Text(isEdit ? " Update " : "submit")),
      ]),
    );
  }

  void editData() async {
    final todo = widget.todo;
    if (todo == null) {
      print('you cannot edit without todo data');
      return;
    }
    final id = todo['_id'];
    // final isCompleted = todo?['is_completed'];
    final title = titleController.text;
    final description = descriptionController.text;
    final body = {
      "title": title,
      "description": description,
      "is_completed": false
    };

    final url = 'https://api.nstack.in/v1/todos/$id';
    final uri = Uri.parse(url);
    final request = await http.put(uri,
        body: jsonEncode(body), headers: {'Content-Type': 'application/json'});

    if (request.statusCode == 200) {
      // titleController.text = '';
      // descriptionController.text = '';
      // print("sucessfully updated");
      successMessage(context,'sucessfully updated ');
    } else {
      // print(" update failed");
      showErrorMessage(context,"update failed");
      // print(request.body);
    }
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
      successMessage(context,'creation sucessfully ');
    } else {
      print("failfully executed");
      showErrorMessage(context,"failed to execute");
      print(request.body);
    }
  }

  
}
