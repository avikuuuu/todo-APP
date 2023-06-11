import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_todo_rest_api/screens/add_page.dart';
import 'package:flutter_todo_rest_api/utils/snackbar_helper.dart';
import 'package:flutter_todo_rest_api/todo%20services/todo_services.dart';
import 'package:flutter_todo_rest_api/widgets/todo_card.dart';
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
          child: Visibility(
            visible: items.isNotEmpty,
            replacement: Center(
              child: Text(
                'No Todo Item',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            child: ListView.builder(
              itemCount: items.length,
              padding: EdgeInsets.all(10),
              itemBuilder: (context, index) {
                final item = items[index] as Map;
                final id = item['_id'] as String;
                return TodoCard(index: index, item: item, navigateEdit:navigateToEditPage,delteByID: deleteById,);
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: navigateToAddPage,
        label: const Text('Add TODO'),
      ),
    );
  }

  Future<void> navigateToEditPage(Map item) async {
    await Navigator.push(context,
        MaterialPageRoute(builder: (context) => AddTodoPage(todo: item)));

    setState(() {
      isLoading = true;
    });

    fetchTODO();
  }

  Future<void> navigateToAddPage() async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => AddTodoPage()));

    setState(() {
      isLoading = true;
    });

    fetchTODO();
  }

  Future<void> deleteById(String id) async {
    final isSuccess = await TodoServices.deleteById(id);

    if (isSuccess) {
      successMessage(context, 'deleted successfully');
      final filtered = items.where((element) => element['_id'] != id).toList();
      setState(() {
        items = filtered;
      });
    } else {
      showErrorMessage(context, 'failed to delete');
    }
  }

  Future<void> fetchTODO() async {
    final response = await TodoServices.fetchtodos();

    if (response != null) {
      setState(() {
        items = response;
      });
    } else {
      showErrorMessage(context, 'failed to fetch');
    }

    setState(() {
      isLoading = true;
    });
  }
}
