import 'package:flutter/material.dart';
import 'package:k_track/models/list_item.dart';
import 'package:super_context_menu/super_context_menu.dart';

class ContextMenuWrapper extends StatelessWidget {
  final Widget child;
  final VoidCallback deleteCallback;
  final Function(String name) renameCallback;
  final KListItem todoItem;

  const ContextMenuWrapper({super.key, required this.child, required this.deleteCallback, required this.renameCallback, required this.todoItem});

  void _showRenameDialog(BuildContext context) {
    final TextEditingController controller = TextEditingController(text: todoItem.name);

    showAdaptiveDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Rename Item"),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(hintText: "Enter new name"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              final newName = controller.text.trim();
              if (newName.isNotEmpty) {
                renameCallback(newName);
                Navigator.pop(context);
              }
            },
            child: const Text("Rename"),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Delete"),
          content: const Text("Are you sure you want to go ahead? This action is not reversible."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              style: TextButton.styleFrom(foregroundColor: Colors.lightBlue),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                deleteCallback();
                Navigator.pop(context); // Close dialog
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ContextMenuWidget(
      child: child,
      menuProvider: (_) {
        return Menu(children: [
          MenuAction(title: "Rename", image: MenuImage.icon(Icons.edit), callback: (){
            _showRenameDialog(context);
          }),
          MenuAction(title: "Delete", image: MenuImage.icon(Icons.delete), attributes: MenuActionAttributes(destructive: true), callback: (){
            _confirmDelete(context);
          })
        ]);
      }
    );
  }
}