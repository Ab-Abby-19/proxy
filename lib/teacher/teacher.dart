// lib/teacher/teacher_page.dart
import 'package:flutter/material.dart';
import 'course.dart'; // Import CoursePage
import 'forgot_password.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';

class TeacherPage extends StatefulWidget {
  final CookieJar cookieJar;
  final String apiUrl;

  TeacherPage({required this.cookieJar, required this.apiUrl});

  @override
  _TeacherPageState createState() => _TeacherPageState();
}

class _TeacherPageState extends State<TeacherPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _checkLoggedIn(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Teacher Login Portal'),
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
                TextField(
                  controller: emailController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.grey),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.grey),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _login(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 1, 11, 45),
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Text(
                    'Login',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ForgotPasswordPage(
                          apiUrl: widget.apiUrl,
                        ),
                      ),
                    );
                  },
                  child: Text('Forgot Password?'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _login(BuildContext context) async {
    String enteredEmail = emailController.text.toLowerCase().trim();
    String enteredPassword = passwordController.text.trim();

    final cookieJar = CookieJar();
    final dio = Dio();
    dio.interceptors.add(CookieManager(cookieJar));

    try {
      Response response = await dio.post(
        '${widget.apiUrl}/teacher/login',
        data: {
          'email': enteredEmail,
          'password': enteredPassword,
        },
      );

      if (response.statusCode == 200) {
        String token = response.data['token'];
        print(token);
        List<Cookie> cookies = [Cookie('token', token)];
        await cookieJar.saveFromResponse(
            Uri.parse('${widget.apiUrl}/teacher/login'), cookies);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                CoursePage(cookieJar: cookieJar, apiUrl: widget.apiUrl),
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Login Failed'),
              content: Text('Incorrect email or password.'),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      print('Dio error: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Network Error'),
            content: Text('Check your network connection and try again.'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  void _checkLoggedIn(BuildContext context) async {
    final cookieJar = CookieJar();
    final dio = Dio();
    dio.interceptors.add(CookieManager(cookieJar));

    try {
      List<Cookie> cookies = await cookieJar
          .loadForRequest(Uri.parse('${widget.apiUrl}/teacher/login'));
      print(cookies);
      if (cookies.isNotEmpty) {
        _navigateTo(
            context, CoursePage(cookieJar: cookieJar, apiUrl: widget.apiUrl));
      }
    } catch (e) {
      print('Dio error: $e');
    }
  }

  void _navigateTo(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }
}
