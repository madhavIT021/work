import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task.dart';
import '../widgets/task_list.dart';
import 'dart:convert';

class TaskScreen extends StatefulWidget {
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  late List<Task> _tasks = [];
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    _prefs = await SharedPreferences.getInstance();
    List<String>? tasksJson = _prefs.getStringList('tasks');
    if (tasksJson != null) {
      _tasks = tasksJson.map((taskJson) => Task.fromJson(taskJson)).toList();
    } else {
      _tasks = [];
    }
    setState(() {});
  }

  Future<void> _saveTasks() async {
    List<String> tasksJson =
        _tasks.map((task) => jsonEncode(task.toJson())).toList();
    await _prefs.setStringList('tasks', tasksJson);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Management'),
      ),
      body: TaskList(
        tasks: _tasks,
        onDelete: (index) {
          setState(() {
            _tasks.removeAt(index);
            _saveTasks();
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              String title = '';
              String description = '';
              DateTime? deadline;

              return AlertDialog(
                title: Text('Add Task'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextField(
                      onChanged: (value) {
                        title = value;
                      },
                      decoration: InputDecoration(
                        labelText: 'Title',
                      ),
                    ),
                    TextField(
                      onChanged: (value) {
                        description = value;
                      },
                      decoration: InputDecoration(
                        labelText: 'Description',
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100),
                        ).then((date) {
                          if (date != null) {
                            setState(() {
                              deadline = date;
                            });
                          }
                        });
                      },
                      child: Text('Select Deadline'),
                    ),
                  ],
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Task newTask = Task(
                        title: title,
                        description: description,
                        deadline: deadline ?? DateTime.now(),
                      );
                      setState(() {
                        _tasks.add(newTask);
                        _saveTasks();
                      });
                      Navigator.of(context).pop();
                    },
                    child: Text('Add Task'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
