import 'package:flutter/material.dart';
import 'teacher/teacher.dart';
import 'student/student.dart';
import 'admin/admin.dart';
import 'utils/notification_helper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final NotificationHelper notificationHelper = NotificationHelper();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App',
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 8, 8, 9),
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(secondary: Color.fromARGB(255, 23, 23, 24)),
      ),
      home: MainPage(notificationHelper: notificationHelper),
    );
  }
}


class MainPage extends StatelessWidget {
   final NotificationHelper notificationHelper;

  // Constructor
  MainPage({required this.notificationHelper});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Proxy Marker'),
        flexibleSpace: Container(
          decoration: BoxDecoration(color: Colors.white),
        ),
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(color: const Color.fromARGB(255, 8, 8, 8)),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TeacherPage()),
                  );
                },
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 1, 11, 45),
                        Color.fromARGB(255, 1, 47, 86),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(0.0),
                  ),
                  child: Center(
                    child: Text(
                      'TEACHER',
                      style: TextStyle(fontSize: 26, color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => StudentPage()),
                  );
                },
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 1, 11, 45),
                        Color.fromARGB(255, 1, 47, 86),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(0.0),
                  ),
                  child: Center(
                    child: Text(
                      'STUDENT',
                      style: TextStyle(fontSize: 26, color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AdminPage()),
                  );
                },
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 1, 11, 45),
                        Color.fromARGB(255, 1, 47, 86),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(0.0),
                  ),
                  child: Center(
                    child: Text(
                      'ADMIN',
                      style: TextStyle(fontSize: 26, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

