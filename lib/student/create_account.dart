// lib/create_account.dart
import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:wifi/student/student.dart';

class CreateAccountPage extends StatefulWidget {
  final CookieJar cookieJar;
  final String apiUrl;

  CreateAccountPage({required this.cookieJar, required this.apiUrl});

  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rollNumberController = TextEditingController();
  TextEditingController branchController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController batchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Account'),
      ),
      body: Container(
        decoration: BoxDecoration(color: const Color.fromARGB(255, 8, 8, 8)),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: nameController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Name',
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
                TextField(
                  controller: rollNumberController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Roll Number',
                    labelStyle: TextStyle(color: Colors.grey),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: branchController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Branch',
                    labelStyle: TextStyle(color: Colors.grey),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: yearController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Year',
                    labelStyle: TextStyle(color: Colors.grey),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: batchController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Batch',
                    labelStyle: TextStyle(color: Colors.grey),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _submitForm();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 1, 11, 45),
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

  void _submitForm() async {
    // Validate if all fields are filled
    if (_areAllFieldsFilled()) {
      // Redirect to the previous login page
      final dio = Dio();
      try {
        Response response =
            await dio.post('${widget.apiUrl}/student/signup', data: {
          "userName": nameController.text,
          "email": emailController.text,
          "password": passwordController.text,
          "rollNo": rollNumberController.text,
          "branch": branchController.text,
          "year": yearController.text,
          "batch": batchController.text,
        });
        print(response.data);
        _navigateTo(
            context,
            StudentPage(
              cookieJar: widget.cookieJar,
              apiUrl: widget.apiUrl,
            ));
      } catch (e) {
        print('Error: $e');
      }
      Navigator.pop(context);
    } else {
      // Show an error message or take appropriate action
      // For simplicity, showing a snackbar in this example
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in all fields.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  bool _areAllFieldsFilled() {
    return nameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        rollNumberController.text.isNotEmpty &&
        branchController.text.isNotEmpty &&
        yearController.text.isNotEmpty &&
        batchController.text.isNotEmpty;
  }

  void _navigateTo(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }
}
