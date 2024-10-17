import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/edittodo.dart';

class firstpage extends StatefulWidget {
  const firstpage({super.key});

  @override
  State<firstpage> createState() => _firstpageState();
}

class _firstpageState extends State<firstpage> {
  @override
  void initState() {
    super.initState();

    initialList();
  }

  Future<void> saveTodoList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('todoList', datalist);
  }

  Future<void> initialList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? todoList = prefs.getStringList('todoList');

    if (todoList != null) {
      setState(() {
        datalist = todoList;
        print("ffff");
      });
      print("ff454545ff");
    }
    print(todoList);
  }

  Future<void> RemoveDataList(int val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? todoList = prefs.getStringList('todoList');
    todoList!.removeAt(val);
    prefs.setStringList('todoList', todoList);
    print(todoList);
  }

  List<String> datalist = [];
  TextEditingController TextController = TextEditingController();
  void addItem() {
    if (TextController.text.isNotEmpty) {
      setState(() {
        datalist.add(TextController.text);
      });
      TextController.clear();
    }
  }

  void DeleteItem(int val) {
    setState(() {
      datalist.removeAt(val);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            color: Color.fromARGB(255, 246, 246, 246),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.20,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 4, 45, 83),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 20, left: 20),
                              child: Row(
                                children: [
                                  Image.asset(
                                    "lib/assest/profile.png",
                                    height: 100,
                                  ),
                                  SizedBox(
                                    width: 40,
                                  ),
                                  Text(
                                    "Alby Anto",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: const Color.fromARGB(
                                            255, 255, 255, 255),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.10,
                        color: Color.fromARGB(255, 248, 248, 248),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                SizedBox(width: 10),
                                Text(
                                  "My Tasks",
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: Color.fromARGB(255, 4, 45, 83),
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.60,
                        color: Color.fromARGB(255, 248, 248, 248),
                        child: ListView.builder(
                            itemCount: datalist.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, bottom: 20),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color.fromARGB(255, 215, 215, 214),
                                  ),
                                  child: ListTile(
                                    title: Text(
                                      datalist[index],
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color:
                                              Color.fromARGB(255, 4, 45, 83)),
                                    ),
                                    trailing: PopupMenuButton<String>(
                                      icon: Icon(
                                        Icons.more_vert,
                                        color: Color.fromARGB(255, 4, 45, 83),
                                        size: 30,
                                      ),
                                      onSelected: (String value) {
                                        if (value == 'edit') {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      UpdatePage(
                                                        dataIndex: index,
                                                      )));
                                        } else if (value == 'delete') {
                                          setState(() {
                                            DeleteItem(index);
                                            saveTodoList();
                                          });
                                        }
                                      },
                                      itemBuilder: (BuildContext context) {
                                        return [
                                          PopupMenuItem<String>(
                                            value: 'edit',
                                            child: Text(
                                              'Edit',
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 4, 45, 83)),
                                            ),
                                          ),
                                          PopupMenuItem<String>(
                                            value: 'delete',
                                            child: Text(
                                              'Delete',
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 4, 45, 83)),
                                            ),
                                          ),
                                        ];
                                      },
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.10,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                SizedBox(width: 10),
                                Expanded(
                                  child: SizedBox(
                                    height: 40,
                                    child: TextField(
                                      controller: TextController,
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          height: 1.0,
                                          color:
                                              Color.fromARGB(255, 27, 27, 28)),
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor:
                                            Color.fromARGB(255, 255, 255, 254),
                                        border: OutlineInputBorder(),
                                        hintText: 'Add Task',
                                      ),
                                    ),
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        addItem();
                                        saveTodoList();

                                        print(datalist);
                                      });
                                    },
                                    icon: Icon(
                                      Icons.add,
                                      size: 40,
                                      color: Color.fromARGB(255, 4, 45, 83),
                                    ))
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
