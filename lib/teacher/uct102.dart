import 'package:flutter/material.dart';
import 'generate_code.dart'; // Import the GenerateCodePage
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class UCT102Page extends StatelessWidget {
  final String viewAttendanceUrl = 'YOUR_VIEW_ATTENDANCE_URL_FOR_UCT102';
  final String viewAttendanceByDateUrl =
      'YOUR_VIEW_ATTENDANCE_BY_DATE_URL_FOR_UCT102';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UCT102 Page'),
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(color: const Color.fromARGB(255, 8, 8, 8)),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildButton(context, 'Generate Code', GenerateCodePage()),
              SizedBox(height: 20),
              _buildWebViewButton(
                  context, 'View Attendance', viewAttendanceUrl),
              SizedBox(height: 20),
              _buildWebViewButton(
                  context, 'View Attendance by Date', viewAttendanceByDateUrl),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String label, Widget page) {
    return InkWell(
      onTap: () {
        // Navigate to the specified page
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
          borderRadius: BorderRadius.circular(0.0),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(fontSize: 26, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildWebViewButton(BuildContext context, String label, String url) {
    return InkWell(
      onTap: () {
        // Open the WebView for Google Sheets
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WebviewScaffold(
              appBar: AppBar(
                title: Text(label),
              ),
              url: url,
            ),
          ),
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
          borderRadius: BorderRadius.circular(0.0),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(fontSize: 26, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
