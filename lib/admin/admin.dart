import 'package:flutter/material.dart';
import 'teacher_details.dart'; // Import TeacherDetailsPage
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    print('INIt STATE');
    super.initState();
    _checkExistingCookies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Login Portal'),
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
                  style:
                      TextStyle(color: Colors.white), // Set text color to white
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(
                        color: Colors.grey), // Set label color to grey
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  style:
                      TextStyle(color: Colors.white), // Set text color to white
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(
                        color: Colors.grey), // Set label color to grey
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _checkExistingCookies() async {
    final cookieJar = CookieJar();
    final dio = Dio();
    dio.interceptors.add(CookieManager(cookieJar));

    print('checkubng');
    List<Cookie> cookies = await cookieJar
        .loadForRequest(Uri.parse('http://localhost:3000/admin/login'));
    if (cookies.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => TeacherDetailsPage(cookieJar: cookieJar)),
      );
    }
  }

  void _login() async {
    String enteredEmail = emailController.text.toLowerCase().trim();
    String enteredPassword = passwordController.text.trim();

    final cookieJar = CookieJar();
    final dio = Dio();
    dio.interceptors.add(CookieManager(cookieJar));

    print('Email: $enteredEmail');
    print('Password: $enteredPassword');
    try {
      Response response = await dio.post(
        'http://localhost:3000/admin/login',
        data: {
          'email': enteredEmail,
          'password': enteredPassword,
        },
      );

      if (response.statusCode == 200) {
        print('Login successful');
        // print(response.data);
        String token = response.data['token'];
        print(token);
        List<Cookie> cookies = [Cookie('token', token)];
        await cookieJar.saveFromResponse(
            Uri.parse('http://localhost:3000/admin/login'), cookies);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => TeacherDetailsPage(cookieJar: cookieJar)),
        );
      } else {
        print('Login failed');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Incorrect Credentials'),
              content: Text('Please check your username and password.'),
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
}
