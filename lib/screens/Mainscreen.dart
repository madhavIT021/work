import 'package:flutter/material.dart';
import 'package:work/screens/task_screen.dart';
import 'package:work/screens/workflow_screen.dart';
import 'package:work/screens/report_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('TaskFlow'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Tasks'),
              Tab(text: 'Automation'),
              Tab(text: 'Reports'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            TaskScreen(),
            WorkflowScreen(),
            ReportScreen(),
          ],
        ),
      ),
    );
  }
}
