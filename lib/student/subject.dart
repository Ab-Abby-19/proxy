// lib/student/subject.dart
import 'package:flutter/material.dart';
import 'package:wifi/utils/notification_helper.dart';
import 'add_subject.dart'; // Import the necessary add subject page
import 'uct101.dart'; // Import the necessary UCT101 page
import 'uct102.dart'; // Import the necessary UCT102 page
import 'uct101_attendance.dart'; // Import the UCT101 Attendance Page
import 'uct102_attendance.dart'; // Import the UCT102 Attendance Page

class StudentSubjectPage extends StatefulWidget {
  @override
  _StudentSubjectPageState createState() => _StudentSubjectPageState();
}

class _StudentSubjectPageState extends State<StudentSubjectPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of Courses',
            style: TextStyle(color: const Color.fromARGB(255, 16, 16, 16))),
      ),
      body: Container(
        decoration: BoxDecoration(color: const Color.fromARGB(255, 8, 8, 8)),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSubjectTable(context),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Navigate to Add Subject Page
                  _navigateTo(context, AddSubjectPage());
                },
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 1, 11, 45),
                ),
                child: Text(
                  'Join Course',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubjectTable(BuildContext context) {
    return DataTable(
      columnSpacing: 10.0, // Adjust column spacing as needed
      headingTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
      columns: [
        DataColumn(
          label: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Serial', style: TextStyle(fontSize: 12)),
              Text('Number', style: TextStyle(fontSize: 12)),
            ],
          ),
        ),
        DataColumn(
          label: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Subject', style: TextStyle(fontSize: 12)),
              Text('Code', style: TextStyle(fontSize: 12)),
            ],
          ),
        ),
        DataColumn(
          label: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Attendance', style: TextStyle(fontSize: 14)),
            ],
          ),
        ),
        DataColumn(
          label: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Percentage', style: TextStyle(fontSize: 14)),
            ],
          ),
        ),
      ],
      rows: [
        DataRow(
          cells: [
            DataCell(Text('1', style: TextStyle(color: Colors.white))),
            DataCell(
              GestureDetector(
                onTap: () {
                 _navigateTo(context, UCT101Page(notificationHelper: NotificationHelper()));
                },
                child: Text(
                  'UCT101',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            DataCell(
              GestureDetector(
                onTap: () {
                  _navigateTo(context, UCT101AttendancePage());
                },
                child: Text(
                  '15/20',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            DataCell(Text('75%', style: TextStyle(color: Colors.white))),
          ],
        ),
        DataRow(
          cells: [
            DataCell(Text('2', style: TextStyle(color: Colors.white))),
            DataCell(
              GestureDetector(
                onTap: () {
                  _navigateTo(context, UCT102Page());
                },
                child: Text(
                  'UCT102',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            DataCell(
              GestureDetector(
                onTap: () {
                  _navigateTo(context, UCT102AttendancePage());
                },
                child: Text(
                  '18/20',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            DataCell(Text('90%', style: TextStyle(color: Colors.white))),
          ],
        ),
        // Add more rows as needed
      ],
    );
  }

  void _navigateTo(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }
}
