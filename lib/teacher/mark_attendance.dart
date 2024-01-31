import 'package:flutter/material.dart';

class MarkAttendancePage extends StatelessWidget {
  TextEditingController rollNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mark Attendance'),
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(color: const Color.fromARGB(255, 8, 8, 8)),
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: rollNumberController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Enter Roll Number',
                    labelStyle: TextStyle(color: Colors.grey),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _submitRollNumber(context);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 1, 11, 45),
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
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
      ),
    );
  }

  void _submitRollNumber(BuildContext context) {
    // Handle the submission logic
    String enteredRollNumber = rollNumberController.text.trim();

    // Here you can implement your logic for marking attendance
    // For now, let's just navigate back to the previous page
    Navigator.pop(context);
  }
}
