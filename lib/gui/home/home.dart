import 'package:flutter/material.dart';
import 'package:k_track/file_handler/master_handler.dart';
import 'package:k_track/gui/home/home_list.dart';
import 'package:k_track/models/list_item.dart';
import 'package:k_track/models/uuid.dart';

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'K-Track',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.yellow),
      ),
      home: const HomePage(title: "K-Track"),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MasterHandler masterHandler = MasterHandler();
  List<KListItem> _listList = [];
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    masterHandler.readMaster().then((value) => setState(() => _listList = value));
  }

  void _addList() {
    if (controller.text.isEmpty) return;
    setState(() {
      _listList.add(KListItem(name: controller.text, id: getUniqueId()));
      controller.clear();
    });
    masterHandler.saveTodos(_listList);
  }

  void _addListFromField(String text) {
    if (text.isEmpty) return;
    setState(() {
      _listList.add(KListItem(name: text, id: getUniqueId()));
      controller.clear();
    });
    masterHandler.saveTodos(_listList);
  }

  void _deleteListItem(int index) {
    setState(() {
      _listList.removeAt(index);
    });
    masterHandler.saveTodos(_listList);
  }

  void _renameListItem(int index, String name) {
    setState(() {
      _listList[index].name = name;
    });
    masterHandler.saveTodos(_listList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
        child: Column(
          children: <Widget>[
            Expanded(child: homePageGrid(_listList, _deleteListItem, _renameListItem)),
            Padding(
              padding: EdgeInsets.only(bottom: 30.0, left: 10.0, right: 10.0),
              child: TextField(
                autofocus: false,
                controller: controller,
                onSubmitted: _addListFromField,
                decoration: InputDecoration(
                  labelText: 'Create a new list',
                  hintText: "Enter name...",
                  suffixIcon: IconButton(icon: Icon(Icons.add), onPressed: _addList),
                ),
              ),
            )
          ],
        )
      ),
    );
  }
}
