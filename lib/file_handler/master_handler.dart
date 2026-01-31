import 'dart:io';
import 'dart:convert';
import 'package:k_track/file_handler/file_handler.dart';
import 'package:k_track/models/list_item.dart';

class MasterHandler {
  // Create a reference to the specific master file
  Future<File> get _file async {
    final path = await getLocalPath();
    return File('$path/master.array');
  }

  // Read the list of todos
  Future<List<KListItem>> readMaster() async {
    try {
      final file = await _file;
      if (!await file.exists()) return [];

      String content = await file.readAsString();
      List<dynamic> jsonList = jsonDecode(content);
      return jsonList.map((json) => KListItem.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }

  // Save the list of items
  Future<File> saveTodos(List<KListItem> todos) async {
    final file = await _file;
    String jsonString = jsonEncode(todos.map((t) => t.toJson()).toList());
    return file.writeAsString(jsonString);
  }
}