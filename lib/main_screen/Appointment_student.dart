import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter_chat_app/Classes/Appointment_Request.dart';
import 'package:flutter_chat_app/main_screen/Appointment_tutor.dart';

class StudentScreen extends StatefulWidget {
  const StudentScreen({super.key});

  @override
  StudentScreenState createState() => StudentScreenState();
}

class StudentScreenState extends State<StudentScreen> {
  List<AppointmentRequest> pendingRequests = []; // For tutor
  List<Appointment> appointments = []; // Shared appointments
  List<String> rejectedRequests = []; // To track rejected requests

  // Method to request an appointment from the student side
  void requestAppointment(String studentName, DateTime startTime) {
    setState(() {
      pendingRequests.add(AppointmentRequest(studentName, startTime, false));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Calendar'),
      ),
      body: SingleChildScrollView( // Add scrollability
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Text('Student Calendar', style: TextStyle(fontSize: 18)),
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
              ElevatedButton(
                onPressed: () => _showRequestDialog(context),
                child: const Text('Request Appointment'),
              ),
              // Display rejected requests
              if (rejectedRequests.isNotEmpty) ...[
                const SizedBox(height: 20),
                const Text('Rejected Requests:', style: TextStyle(fontSize: 16)),
                ...rejectedRequests
                    .map((name) => Text('Request from $name was rejected.'))
                    .toList(),
              ],
            ],
          ),
        ),
      ),
    );
  }

  // Dialog for requesting an appointment
  void _showRequestDialog(BuildContext context) {
    final nameController = TextEditingController();
    DateTime selectedTime = DateTime.now();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Request Appointment'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Student Name'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              child: const Text('Pick Date & Time'),
              onPressed: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
                );
                if (pickedDate != null) {
                  TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (pickedTime != null) {
                    selectedTime = DateTime(
                      pickedDate.year,
                      pickedDate.month,
                      pickedDate.day,
                      pickedTime.hour,
                      pickedTime.minute,
                    );
                  }
                }
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (nameController.text.isNotEmpty) {
                requestAppointment(nameController.text, selectedTime);
              }
              Navigator.pop(context);
            },
            child: const Text('Request'),
          ),
        ],
      ),
    );
  }
}
