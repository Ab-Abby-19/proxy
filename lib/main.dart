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
      title: 'Proxy Marker',
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 8, 8, 9),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Color.fromARGB(255, 23, 23, 24),
        ),
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
          decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              image: AssetImage(
                  'assets/your_logo.png'), // Replace with your logo image
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 8, 8, 8),
            image: DecorationImage(
              image: AssetImage(
                  'assets/background_image.png'), // Replace with your background image
              fit: BoxFit.cover,
            ),
          ),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildButton(context, 'TEACHER', TeacherPage(), '👨‍🏫'),
              SizedBox(height: 20),
              _buildButton(context, 'STUDENT', StudentPage(), '👩‍🎓'),
              SizedBox(height: 20),
              _buildButton(context, 'ADMIN', AdminPage(), '👨‍💼'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(
      BuildContext context, String label, Widget page, String emoji) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
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
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 26, color: Colors.white),
              ),
              SizedBox(width: 10),
              Text(
                emoji,
                style: TextStyle(fontSize: 26),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
