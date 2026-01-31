import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import '../models/todo_item.dart';

// Find the local path to the documents directory
Future<String> getLocalPath() async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

class FileHadler {
  String id = "";
  void setId(String id) {
    this.id = id;
  }

  // Create a reference to the specific file
  Future<File> get _localFile async {
    final path = await getLocalPath();
    return File('$path/todo-$id.json');
  }

  // Save the list of items
  Future<File> saveTodos(List<TodoItem> todos) async {
    final file = await _localFile;
    String jsonString = jsonEncode(todos.map((t) => t.toJson()).toList());
    return file.writeAsString(jsonString);
  }

  // Read the list of items
  Future<List<TodoItem>> readTodos() async {
    try {
      final file = await _localFile;
      if (!await file.exists()) return [];

      String content = await file.readAsString();
      List<dynamic> jsonList = jsonDecode(content);
      return jsonList.map((json) => TodoItem.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }
}