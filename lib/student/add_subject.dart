// lib/student/add_subject.dart
import 'package:flutter/material.dart';

class AddSubjectPage extends StatefulWidget {
  @override
  _AddSubjectPageState createState() => _AddSubjectPageState();
}

class _AddSubjectPageState extends State<AddSubjectPage> {
  TextEditingController subjectCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Join Course',
            style: TextStyle(color: const Color.fromARGB(255, 16, 16, 16))),
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
                controller: subjectCodeController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Course Code',
                  labelStyle: TextStyle(color: Colors.grey),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _addSubject();
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

  void _addSubject() {
    String subjectCode = subjectCodeController.text.trim();
    // Add logic to save the subject code or perform any other action
    Navigator.pop(context); // Return to the previous page (subject.dart)
  }
}
