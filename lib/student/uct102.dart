// lib/student/uct102.dart
import 'package:flutter/material.dart';

class UCT102Page extends StatefulWidget {
  @override
  _UCT102PageState createState() => _UCT102PageState();
}

class _UCT102PageState extends State<UCT102Page> {
  TextEditingController attendanceCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UCT102 Page'),
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
    Navigator.pop(context); // Return to the previous page (subject.dart)
  }
}
