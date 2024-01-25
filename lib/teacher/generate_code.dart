import 'dart:async';
import 'package:flutter/material.dart';

class GenerateCodePage extends StatefulWidget {
  @override
  _GenerateCodePageState createState() => _GenerateCodePageState();
}

class _GenerateCodePageState extends State<GenerateCodePage> {
  late Timer _timer;
  int _remainingTime = 60; // Initial time in seconds

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Generate Code', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(color: const Color.fromARGB(255, 8, 8, 8)),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Generated Code:',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              SizedBox(height: 10),
              Text(
                _generateRandomCode(),
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
              SizedBox(height: 20),
              Text(
                'Remaining Time: $_remainingTime seconds',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _stopTimer();
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                ),
                child: Text(
                  'Stop',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _generateRandomCode() {
    // Implement your logic to generate a random code
    // For example, you can use a package like crypto to generate a secure random code
    return 'ABC123'; // Replace with your actual random code
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--;
        } else {
          _stopTimer();
          Navigator.pop(context);
        }
      });
    });
  }

  void _stopTimer() {
    if (_timer.isActive) {
      _timer.cancel();
    }
  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }
}
