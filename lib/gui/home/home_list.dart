import 'package:flutter/material.dart';
import 'package:k_track/gui/home/context_menu.dart';
import 'package:k_track/gui/list/list.dart';
import 'package:k_track/models/list_item.dart';

GridView homePageGrid(List<KListItem> todos, Function (int index) deleteCallback, Function (int index, String name) renameCallback) {
 return GridView.builder(
    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
      childAspectRatio: 1,
      maxCrossAxisExtent: 200,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10
    ),
    itemCount: todos.length,
    itemBuilder: (context, index) {
      final item = todos[index];
      return ContextMenuWrapper(
        deleteCallback: () {
          deleteCallback(index);
        },
        renameCallback: (String name) {
          renameCallback(index, name);
        },
        todoItem: item,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => TodoApp(id: item.id, name: item.name,)));
          },
          style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0))),
          child: Text(item.name)
        ),
      );
    },
  );
}