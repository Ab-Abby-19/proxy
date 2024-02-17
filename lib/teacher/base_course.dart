import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'generate_code.dart';
import 'mark_attendance.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

class BaseCoursePage extends StatefulWidget {
  final String courseCode;
  final CookieJar cookieJar;
  final String apiUrl;

  BaseCoursePage(
      {required this.courseCode,
      required this.cookieJar,
      required this.apiUrl});

  @override
  _BaseCoursePageState createState() => _BaseCoursePageState();
}

class _BaseCoursePageState extends State<BaseCoursePage> {
  String? googleSheetUrl;

  @override
  void initState() async {
    super.initState();
    _initializeGoogleSheetUrl();
  }

  Future<void> _initializeGoogleSheetUrl() async {
    try {
      googleSheetUrl = await viewAttendanceUrl;
    } catch (e) {
      print('Error initializing Google Sheet URL: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.courseCode} Page'),
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(color: const Color.fromARGB(255, 8, 8, 8)),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildButton(
                  context,
                  'Generate Code',
                  GenerateCodePage(
                    courseCode: widget.courseCode,
                    cookieJar: widget.cookieJar,
                    apiUrl: widget.apiUrl,
                  )),
              SizedBox(height: 20),
              _buildButton(
                  context,
                  'Mark Attendance',
                  MarkAttendancePage(
                    courseCode: widget.courseCode,
                    cookieJar: widget.cookieJar,
                    apiUrl: widget.apiUrl,
                  )),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _launchURL,
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
                      'View Attendance',
                      style: TextStyle(fontSize: 26, color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchURL() async {
    try {
      // Ensure that googleSheetUrl is initialized before launching the URL
      if (googleSheetUrl == null) {
        print('Google Sheet URL is not initialized. Initializing...');
        await _initializeGoogleSheetUrl();
      }

      String url = googleSheetUrl!;
      print('Launching URL: $url');

      // Launch the URL
      if (!await launchUrl(Uri.parse(url))) {
        throw Exception('Could not launch');
      }
    } catch (e) {
      print('Error launching URL: $e');
    }
  }

  Widget _buildButton(BuildContext context, String label, Widget page) {
    return InkWell(
      onTap: () {
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

  Future<String> get viewAttendanceUrl async {
    try {
      CookieJar cookieJar = widget.cookieJar;

      List<Cookie> res = await widget.cookieJar
          .loadForRequest(Uri.parse('${widget.apiUrl}/teacher/login'));
      if (res.isNotEmpty) {
        String token = res.first.value;
        print('token: $token');
        final dio = Dio();
        dio.interceptors.add(CookieManager(cookieJar));

        Response response = await dio.get('${widget.apiUrl}/teacher/sheet',
            data: {
              'courseCode': widget.courseCode,
            },
            options: Options(headers: {'Authorization': 'Bearer $token'}));
        String url = response.data['url'];
        print('URL: $url');
        // String url =
        // "https://docs.google.com/spreadsheets/d/1l2D02v-9vRWW_g6XtueEcTpq9lIliOMplBEcv66Hbd0/edit#gid=0";
        // print('URL: $url');
        return url;
      } else {
        throw Exception('Failed to load attendance URL');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to load attendance URL');
    }
  }
}
