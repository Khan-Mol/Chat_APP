import 'package:syncfusion_flutter_calendar/calendar.dart';

class AppointmentRequest {
  String studentName;
  DateTime startTime;
  bool isAccepted;

  AppointmentRequest(this.studentName, this.startTime, this.isAccepted);
}

class AppointmentDataSource extends CalendarDataSource {
  AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}
