import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_todo_rest_api/screens/add_page.dart';
import 'package:http/http.dart' as http;

class TODOListPage extends StatefulWidget {
  const TODOListPage({super.key});

  @override
  State<TODOListPage> createState() => _TODOListPageState();
}

class _TODOListPageState extends State<TODOListPage> {
  List items = [];
  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchTODO();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('TODO List')),
      ),
      body: Visibility(
        visible: isLoading,
        replacement: Center(child: CircularProgressIndicator()),
        child: RefreshIndicator(
          onRefresh: fetchTODO,
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index] as Map;
              return ListTile(
                leading: CircleAvatar(child: Text("${index + 1}")),
                title: Text(item['title']),
                subtitle: Text(item['description']),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: navigateToAddPage,
        label: const Text('Add TODO'),
      ),
    );
  }

  void navigateToAddPage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const AddTodoPage()));
  }

  Future<void> fetchTODO() async {
    final url = 'https://api.nstack.in/v1/todos?page=1&limit=10';
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map;
      final result = json['items'] as List;
      setState(() {
        items = result;
      });
    }

    setState(() {
      isLoading = true;
    });
  }
}
