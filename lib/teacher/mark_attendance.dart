import 'package:flutter/material.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

class MarkAttendancePage extends StatelessWidget {
  final String courseCode;
  final CookieJar cookieJar;

  MarkAttendancePage({required this.courseCode, required this.cookieJar});

  final rollNumberController = TextEditingController();

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

  void _submitRollNumber(BuildContext context) async {
    String enteredRollNumber = rollNumberController.text.trim();

    if (enteredRollNumber.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter a roll number'),
        ),
      );
      return;
    } else {
      List<Cookie> res = await cookieJar
          .loadForRequest(Uri.parse('http://localhost:3000/teacher/login'));
      try {
        if (res.isNotEmpty) {
          String token = res.first.value;
          final dio = Dio();
          dio.interceptors.add(CookieManager(cookieJar));

          Response response =
              await dio.post('http://localhost:3000/teacher/mark-attendance',
                  data: {
                    'studentRollNo': enteredRollNumber,
                    'courseId': courseCode,
                  },
                  options: Options(headers: {
                    'Authorization': 'Bearer $token',
                  }));
          print(response.data);
          if (response.statusCode == 200) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Attendance marked successfully'),
              ),
            );
          } else if (response.statusCode == 201) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Already marked attendance for this roll number'),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Failed to mark attendance'),
              ),
            );
          }
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to mark attendance: $e'),
          ),
        );
      }
    }
    Navigator.pop(context);
  }

  void _navigateTo(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }
}
