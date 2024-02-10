// lib/student/login_page.dart
import 'package:flutter/material.dart';
import 'package:wifi/student/subject.dart';
import 'create_account.dart'; // Import the necessary create account page
import 'forgot_password.dart'; // Import the forgot password page
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';

class StudentPage extends StatefulWidget {
  final CookieJar cookieJar;
  final String apiUrl;

  StudentPage({required this.cookieJar, required this.apiUrl});

  @override
  _StudentPageState createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Portal Login'),
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
                    _login();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 1, 11, 45),
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
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    // Navigate to Forgot Password Page
                    _navigateTo(
                        context,
                        ForgotPasswordPage(
                            cookieJar: widget.cookieJar,
                            apiUrl: widget.apiUrl));
                  },
                  child: Text(
                    'Forgot Password?',
                  ),
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    // Navigate to Create Account Page
                    _navigateTo(
                        context,
                        CreateAccountPage(
                            cookieJar: widget.cookieJar,
                            apiUrl: widget.apiUrl));
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _login() async {
    String enteredEmail = emailController.text.toLowerCase().trim();
    String enteredPassword = passwordController.text.trim();

    final cookieJar = CookieJar();
    final dio = Dio();
    dio.interceptors.add(CookieManager(cookieJar));

    try {
      Response response =
          await dio.post('${widget.apiUrl}/student/login', data: {
        'email': enteredEmail,
        'password': enteredPassword,
      });

      String token = response.data['token'];
      List<Cookie> cookies = [Cookie('token', token)];
      await cookieJar.saveFromResponse(
          Uri.parse('${widget.apiUrl}/student/login'), cookies);

      _navigateTo(
          context,
          StudentSubjectPage(
            cookieJar: cookieJar,
            apiUrl: widget.apiUrl,
          ));
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

  void _navigateTo(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }
}
