import 'package:flutter/material.dart';
import 'teacher/teacher.dart';
import 'student/student.dart';
import 'admin/admin.dart';
import 'utils/notification_helper.dart';
import 'package:cookie_jar/cookie_jar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final NotificationHelper notificationHelper = NotificationHelper();
  final CookieJar? cookieJar;

  MyApp({this.cookieJar});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ProXi',
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 8, 8, 9),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Color.fromARGB(255, 23, 23, 24),
        ),
      ),
      home: MainPage(
          // notificationHelper: notificationHelper,
          cookieJar: cookieJar ?? CookieJar()),
    );
  }
}

class MainPage extends StatefulWidget {
  final CookieJar cookieJar;
  // final NotificationHelper notificationHelper;

  // Constructor
  MainPage({required this.cookieJar});
  // MainPage({required this.notificationHelper, required this.cookieJar});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
    _checkLoggedIn(context);
    // widget.notificationHelper.configureSelectNotificationSubject(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ProXi'),
        leading: Container(
          margin: EdgeInsets.all(7),
          child: Image.asset('images/app_logo.png', fit: BoxFit.contain),
        ),
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 8, 8, 8),
          ),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildButton(
                  context, 'TEACHER', TeacherPage(cookieJar: widget.cookieJar)),
              SizedBox(height: 20),
              _buildButton(
                  context, 'STUDENT', StudentPage(cookieJar: widget.cookieJar)),
              SizedBox(height: 20),
              _buildButton(context, 'ADMIN', AdminPage()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String label, Widget page) {
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
            ],
          ),
        ),
      ),
    );
  }

  void _checkLoggedIn(BuildContext context) async {
    try {
      List<Cookie> cookies = await widget.cookieJar
          .loadForRequest(Uri.parse('http://localhost:3000/teacher/login'));
      print(cookies);
      if (cookies.isNotEmpty) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => TeacherPage(cookieJar: widget.cookieJar)),
        );
      }
    } catch (e) {
      throw Exception('Error checking if user is logged in: $e');
    }
  }
}
