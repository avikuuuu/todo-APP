import 'package:flutter/material.dart';

class TodoCard extends StatelessWidget {
  final int index;
  final Map item;
  final Function(Map) navigateEdit;
  final Function(String) delteByID;
  const TodoCard(
      {super.key,
      required this.index,
      required this.item,
      required this.navigateEdit,
      required this.delteByID});

  @override
  Widget build(BuildContext context) {
    final id = item['_id'] as String;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
      child: ListTile(
        leading: CircleAvatar(child: Text("${index + 1}")),
        title: Text(item['title']),
        subtitle: Text(item['description']),
        trailing: PopupMenuButton(onSelected: (value) {
          if (value == 'edit') {
            navigateEdit(item);
          } else if (value == 'delete') {
            delteByID(id);
          }
        }, itemBuilder: (context) {
          return [
            PopupMenuItem(
              child: Text('Edit'),
              value: 'edit',
            ),
            PopupMenuItem(
              child: Text('Delete'),
              value: 'delete',
            ),
          ];
        }),
      ),
    );
    ;
  }
}
