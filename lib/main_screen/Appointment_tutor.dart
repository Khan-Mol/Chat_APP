import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter_chat_app/Classes/Appointment_Request.dart';
import 'package:flutter_chat_app/main_screen/Appointment_student.dart';

class TutorScreen extends StatefulWidget {
  const TutorScreen({super.key});

  @override
  TutorScreenState createState() => TutorScreenState();
}

class TutorScreenState extends State<TutorScreen> {
  List<AppointmentRequest> pendingRequests = [];
  List<Appointment> appointments = [];

  // Method to accept an appointment from the tutor side
  void acceptAppointment(int index) {
    setState(() {
      var request = pendingRequests[index];
      var acceptedAppointment = Appointment(
        startTime: request.startTime,
        endTime: request.startTime.add(const Duration(minutes: 30)),
        subject: '${request.studentName} - Accepted',
        color: Colors.green,
      );
      appointments.add(acceptedAppointment); // Add to the unified list
      pendingRequests.removeAt(index);
    });
  }

  // Method to reject an appointment from the tutor side
  void rejectAppointment(int index) {
    setState(() {
      pendingRequests.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tutor Calendar'),
      ),
      body: SingleChildScrollView( // Add scrollability
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Text('Tutor Calendar', style: TextStyle(fontSize: 18)),
              SizedBox(
                height: 400, // Fixed height for calendar
                child: SfCalendar(
                  view: CalendarView.month,
                  dataSource: AppointmentDataSource(appointments),
                  monthViewSettings: const MonthViewSettings(
                    appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text('Pending Appointment Requests:', style: TextStyle(fontSize: 16)),
              SizedBox(
                height: 300, // Add a fixed height or use Expanded
                child: ListView.builder(
                  itemCount: pendingRequests.length,
                  itemBuilder: (context, index) {
                    var request = pendingRequests[index];
                    return ListTile(
                      title: Text('Request from ${request.studentName}'),
                      subtitle: Text('Time: ${request.startTime}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.check, color: Colors.green),
                            onPressed: () => acceptAppointment(index),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close, color: Colors.red),
                            onPressed: () => rejectAppointment(index),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
