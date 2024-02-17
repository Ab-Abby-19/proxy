import 'package:flutter/material.dart';
import 'teacher/teacher.dart';
import 'student/student.dart';
import 'admin/admin.dart';
import 'utils/notification_helper.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

NotificationHelper notificationHelper = NotificationHelper();

const String API_URL =
    'https://a129-2401-4900-7a92-e09e-2e4e-b58a-c6df-33aa.ngrok-free.app';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await notificationHelper.initialize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.instance.requestPermission();

  runApp(MyApp(apiUrl: API_URL));
}

class MyApp extends StatelessWidget {
  final CookieJar? cookieJar;
  final String apiUrl;

  MyApp({this.cookieJar, required this.apiUrl});

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
      home: MainPage(cookieJar: cookieJar ?? CookieJar()),
    );
  }
}

class MainPage extends StatefulWidget {
  final CookieJar cookieJar;

  MainPage({required this.cookieJar});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
    _checkLoggedIn(context);

    requestPermission();
  }

  void requestPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      // Permission.location,
      Permission.notification,
      // Permission.nearbyWifiDevices,
    ].request();
    print(statuses);
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
                  context,
                  'TEACHER',
                  TeacherPage(
                    cookieJar: widget.cookieJar,
                    apiUrl: API_URL,
                  )),
              SizedBox(height: 20),
              _buildButton(
                  context,
                  'STUDENT',
                  StudentPage(
                      cookieJar: widget.cookieJar,
                      apiUrl: API_URL,
                      notificationHelper: notificationHelper)),
              SizedBox(height: 20),
              _buildButton(context, 'ADMIN', AdminPage(apiUrl: API_URL)),
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
          .loadForRequest(Uri.parse('${API_URL}/teacher/login'));
      print(cookies);
      if (cookies.isNotEmpty) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  TeacherPage(cookieJar: widget.cookieJar, apiUrl: API_URL)),
        );
      }
    } catch (e) {
      throw Exception('Error checking if user is logged in: $e');
    }
  }
}
