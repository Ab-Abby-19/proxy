import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'new_password.dart'; // Import NewPasswordPage

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  bool showEmailField = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
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
                if (showEmailField)
                  _buildInputField(
                    controller: emailController,
                    labelText: 'Email',
                  ),
                if (!showEmailField)
                  _buildInputField(
                    controller: otpController,
                    labelText: 'Enter OTP',
                  ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (showEmailField) {
                      _submit_email();
                      setState(() {
                        showEmailField = false;
                      });
                    } else {
                      _submit_otp();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewPasswordPage(
                            email: emailController.text,
                          ),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 1, 11, 45),
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Text(
                    showEmailField ? 'Submit Email' : 'Submit OTP',
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

  void _submit_email() async {
    try {
      final dio = Dio();
      Response response =
          await dio.post('http://localhost:3000/student/send-otp', data: {
        'email': emailController.text,
      });
      print(response.data);
    } catch (e) {
      throw Exception('Failed to send OTP');
    }
  }

  void _submit_otp() async {
    try {
      final dio = Dio();
      Response response =
          await dio.post('http://localhost:3000/student/verify-otp', data: {
        'otp': otpController.text,
        'email': emailController.text,
      });
      print(response.data);
    } catch (e) {
      throw Exception('Failed to verify OTP');
    }
  }
}
