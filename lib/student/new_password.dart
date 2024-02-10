import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wifi/student/student.dart';
import 'package:cookie_jar/cookie_jar.dart';

class NewPasswordPage extends StatefulWidget {
  final String email;
  final CookieJar cookieJar;
  final String apiUrl;

  NewPasswordPage(
      {required this.email, required this.cookieJar, required this.apiUrl});

  @override
  _NewPasswordPageState createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Password'),
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
                _buildInputField(
                  controller: newPasswordController,
                  labelText: 'New Password',
                  obscureText: true,
                ),
                SizedBox(height: 20),
                _buildInputField(
                  controller: confirmPasswordController,
                  labelText: 'Confirm Password',
                  obscureText: true,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Handle password submission
                    // You can implement password update logic here

                    // Navigate back to the TeacherPage
                    Navigator.popUntil(context, ModalRoute.withName('/'));
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

  Widget _buildInputField({
    required TextEditingController controller,
    required String labelText,
    bool obscureText = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.grey),
      ),
    );
  }

  void _submitForm() async {
    String newPassword = newPasswordController.text;
    String confirmPassword = confirmPasswordController.text;

    if (newPassword != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Passwords do not match'),
        ),
      );
      return;
    }

    try {
      var dio = Dio();
      Response response =
          await dio.post('${widget.apiUrl}/student/reset-password', data: {
        'cemail': widget.email,
        'newPassword': newPassword,
      });
      print(response.data);
      _navigateTo(
          context,
          StudentPage(
            cookieJar: widget.cookieJar,
            apiUrl: widget.apiUrl,
          ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
        ),
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
