import 'package:flutter/material.dart';
import 'package:k_track/file_handler/file_handler.dart';
import 'package:k_track/models/todo_item.dart';

class TodoApp extends StatefulWidget {
  const TodoApp({super.key, required this.id, required this.name});

  final String id;
  final String name;

  @override
  _TodoAppState createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  final FileHadler fileHandler = FileHadler();
  final TextEditingController controller = TextEditingController();
  List<TodoItem> _todoList = [];

  @override
  void initState() {
    super.initState();
    fileHandler.setId(widget.id);
    // Load data from file when app starts
    fileHandler.readTodos().then((value) => setState(() => _todoList = value));
  }

  void _addTodo() {
    if (controller.text.isEmpty) return;
    setState(() {
      _todoList.add(TodoItem(title: controller.text));
      controller.clear();
    });
    fileHandler.saveTodos(_todoList);
  }

  void _addTodoFromField(String text) {
    if (text.isEmpty) return;
    setState(() {
      _todoList.add(TodoItem(title: text));
      controller.clear();
    });
    fileHandler.saveTodos(_todoList);
  }

  void _toggleTodo(int index) {
    setState(() => _todoList[index].isDone = !_todoList[index].isDone);
    fileHandler.saveTodos(_todoList);
  }

  void _deleteTodo(int index) {
    setState(() => _todoList.removeAt(index));
    fileHandler.saveTodos(_todoList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.name)),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: controller,
              onSubmitted: _addTodoFromField,
              decoration: InputDecoration(
                labelText: 'Create a task',
                hintText: "Enter your task...",
                suffixIcon: IconButton(icon: Icon(Icons.add), onPressed: _addTodo),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _todoList.length,
              itemBuilder: (context, index) {
                final item = _todoList[index];
                return ListTile(
                  leading: Checkbox(
                    value: item.isDone,
                    onChanged: (_) => _toggleTodo(index),
                  ),
                  title: Text(
                    item.title,
                    style: TextStyle(
                      decoration: item.isDone ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteTodo(index),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}