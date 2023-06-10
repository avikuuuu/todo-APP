import 'package:flutter/material.dart';
import 'package:flutter_todo_rest_api/screens/add_page.dart';

class TODOListPage extends StatefulWidget {
  const TODOListPage({super.key});

  @override
  State<TODOListPage> createState() => _TODOListPageState();
}

class _TODOListPageState extends State<TODOListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text('TODO List')),
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: navigateToAddPage,
        label: const Text('Add TODO'),
      ),
    );
  }

  void navigateToAddPage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AddTodoPage()));
  }
}
