import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AddTeacherPage extends StatefulWidget {
  final CookieJar cookieJar;
  final String apiUrl;

  AddTeacherPage({required this.cookieJar, required this.apiUrl});
  @override
  _AddTeacherPageState createState() => _AddTeacherPageState();
}

class _AddTeacherPageState extends State<AddTeacherPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final cookieJar = CookieJar();
  final dio = Dio();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Teacher'),
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
                  controller: usernameController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Username',
                    labelStyle: TextStyle(color: Colors.grey),
                  ),
                ),
                SizedBox(height: 20),
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
                    _submit();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 1, 11, 45),
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

  void _submit() async {
    String enteredUsername = usernameController.text.trim();
    String enteredEmail = emailController.text.trim();
    String enteredPassword = passwordController.text.trim();

    try {
      // fetch the cookie - token
      List<Cookie> results = await widget.cookieJar
          .loadForRequest(Uri.parse('${widget.apiUrl}/admin/login'));
      print(results);

      if (results.isNotEmpty) {
        String token = results.first.value;
        Response response =
            await dio.post('${widget.apiUrl}/admin/create-teacher',
                data: {
                  'userName': enteredUsername,
                  'email': enteredEmail,
                  'password': enteredPassword,
                },
                options: Options(headers: {'Authorization': 'Bearer $token'}));
        print(response.data);
      }
    } catch (e) {
      print(e);
      print('Error creating teacher');
    }

    Navigator.pop(context);
  }
}
