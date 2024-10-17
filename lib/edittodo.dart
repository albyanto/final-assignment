import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/firstpage.dart';

class UpdatePage extends StatefulWidget {
  final int dataIndex;
  const UpdatePage({super.key, required this.dataIndex});

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  TextEditingController editController = TextEditingController();
  List<String> datalist = [];
  bool validate = false;

  @override
  void initState() {
    super.initState();
    GetData();
  }

  Future<void> GetData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? todoList = prefs.getStringList('todoList');
    if (todoList != null && todoList.isNotEmpty) {
      setState(() {
        datalist = todoList;
        editController.text = datalist[widget.dataIndex];
      });
    }
  }

  Future<void> updateData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    datalist[widget.dataIndex] = editController.text;
    await prefs.setStringList('todoList', datalist);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const firstpage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          "Edit Task",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 4, 45, 83),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            TextField(
              controller: editController,
              decoration: InputDecoration(
                errorText: validate ? 'Value Cant Be Empty' : null,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                        Color.fromARGB(255, 210, 207, 184)),
                  ),
                  onPressed: () {
                    editController.clear();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => const firstpage()));
                  },
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                      fontSize: 15,
                      color: Color.fromARGB(255, 4, 45, 83),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                        Color.fromARGB(255, 4, 45, 83)),
                  ),
                  onPressed: () {
                    if (editController.text.isEmpty) {
                      setState(() {
                        validate = true;
                      });
                    } else {
                      setState(() {
                        validate = false;
                        updateData();
                      });
                    }
                  },
                  child: const Text(
                    "Done",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
