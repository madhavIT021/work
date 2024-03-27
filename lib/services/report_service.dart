import '../models/report.dart';

class ReportService {
  Report generateReport() {
    //report from db
    return Report(
      title: 'Sample Report',
      completedTasks: 10,
      totalTasks: 20,
    );
  }
}
