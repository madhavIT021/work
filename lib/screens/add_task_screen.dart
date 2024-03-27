import 'package:flutter/material.dart';
import '../models/task.dart';
import '../services/task_service.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  late String _title;
  late String _description;
  late DateTime _deadline;

  TaskService _taskService = TaskService(); // Create an instance of TaskService

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Task'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              onChanged: (value) {
                setState(() {
                  _title = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Title',
              ),
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  _description = value;
                });
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
                      _deadline = date;
                    });
                  }
                });
              },
              child: Text('Select Deadline'),
            ),
            ElevatedButton(
              onPressed: () {
                Task newTask = Task(
                  title: _title,
                  description: _description,
                  deadline: _deadline,
                );
                _taskService.addTask(newTask); // Use the instance to access addTask method
                Navigator.pop(context);
              },
              child: Text('Add Task'),
            ),
          ],
        ),
      ),
    );
  }
}
