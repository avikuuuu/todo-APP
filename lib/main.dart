import 'package:flutter/material.dart';
import 'package:flutter_todo_rest_api/screens/todo_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TODO REST CRUD APP',
      theme: ThemeData.dark(),
      home: TODOListPage(),
    );
  }
}
