import 'package:flutter/material.dart';
import 'teacher_details.dart'; // Import TeacherDetailsPage


class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
                  controller: usernameController,
                  style: TextStyle(color: Colors.white), // Set text color to white
                  decoration: InputDecoration(
                    labelText: 'Username',
                    labelStyle: TextStyle(color: Colors.grey), // Set label color to grey
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  style: TextStyle(color: Colors.white), // Set text color to white
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.grey), // Set label color to grey
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

  void _login() {
    String enteredUsername = usernameController.text.toLowerCase().trim();
    String enteredPassword = passwordController.text.trim();

    if (enteredUsername == 'admin' && enteredPassword == 'jodhpur jana h') {
      // Correct credentials, navigate to the admin portal
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => TeacherDetailsPage()),
      );
    } else {
      // Incorrect credentials, show a message
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
  }
}
