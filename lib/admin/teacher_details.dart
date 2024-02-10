// lib/admin/teacher_details.dart
import 'package:flutter/material.dart';
import 'add_teacher.dart'; // Import AddTeacherPage
import 'list_teachers.dart'; // Import ListTeachersPage
import 'package:cookie_jar/cookie_jar.dart';

class TeacherDetailsPage extends StatelessWidget {
  final CookieJar cookieJar;
  final String apiUrl;

  TeacherDetailsPage({required this.cookieJar, required this.apiUrl});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
      ),
      body: Container(
        decoration: BoxDecoration(color: const Color.fromARGB(255, 8, 8, 8)),
        width: double.infinity,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _navigateTo(
                        context,
                        AddTeacherPage(
                          cookieJar: cookieJar,
                          apiUrl: apiUrl,
                        ));
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 1, 11, 45),
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Text(
                    'Add Teacher',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _navigateTo(
                        context,
                        ListTeachersPage(
                          cookieJar: cookieJar,
                          apiUrl: apiUrl,
                        ));
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 1, 11, 45),
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Text(
                    'List of Teachers',
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

  void _navigateTo(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }
}
