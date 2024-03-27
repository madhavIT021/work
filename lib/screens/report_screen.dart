import 'package:flutter/material.dart';
import '../widgets/report_chart.dart';

class ReportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reporting and Analytics'),
      ),
      body: ReportChart(),
    );
  }
}
