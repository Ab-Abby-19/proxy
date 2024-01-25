import 'package:flutter/material.dart';

class AddCoursePage extends StatelessWidget {
  final TextEditingController subjectCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Course', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(color: const Color.fromARGB(255, 8, 8, 8)),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Enter Subject Code:',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              SizedBox(height: 10),
              TextField(
                controller: subjectCodeController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Subject Code',
                  labelStyle: TextStyle(color: Colors.grey),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _submitCourse(context);
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

  void _submitCourse(BuildContext context) {
    // Perform any necessary validation or processing
    // You can store the subject code, show a success message, etc.

    // Navigate back to the previous page (CoursePage)
    Navigator.pop(context);
  }
}
