import 'package:flutter/material.dart';
import 'package:wifi/utils/notification_helper.dart';

class UCT101Page extends StatefulWidget {
  final NotificationHelper notificationHelper;

  // Constructor
  UCT101Page({required this.notificationHelper});

  @override
  _UCT101PageState createState() => _UCT101PageState();
}


class _UCT101PageState extends State<UCT101Page> {
  TextEditingController attendanceCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UCT101 Page'),
      ),
      body: Container(
        decoration: BoxDecoration(color: const Color.fromARGB(255, 8, 8, 8)),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: attendanceCodeController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Attendance Code',
                  labelStyle: TextStyle(color: Colors.grey),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _submitAttendanceCode();
                },
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 1, 11, 45),
                ),
                child: Text(
                  'Submit',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitAttendanceCode() {
    String attendanceCode = attendanceCodeController.text.trim();
    // Add logic to handle the attendance code or perform any other action

    // Show notification
    widget.notificationHelper.showNotification(
      'Attendance Submitted',
      'Your attendance for UCT101 has been submitted successfully.',
    );

    Navigator.pop(context); // Return to the previous page (subject.dart)
  }
}