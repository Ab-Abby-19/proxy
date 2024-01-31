import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wifi/student/subject.dart';

class AddSubjectPage extends StatefulWidget {
  final CookieJar cookieJar;

  AddSubjectPage({required this.cookieJar});

  @override
  _AddSubjectPageState createState() => _AddSubjectPageState();
}

class _AddSubjectPageState extends State<AddSubjectPage> {
  TextEditingController subjectCodeController = TextEditingController();

  final cookieJar = CookieJar();
  final dio = Dio();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Join Course',
            style: TextStyle(color: const Color.fromARGB(255, 16, 16, 16))),
      ),
      body: Container(
        decoration: BoxDecoration(color: const Color.fromARGB(255, 8, 8, 8)),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: subjectCodeController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Course Code',
                  labelStyle: TextStyle(color: Colors.grey),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _addSubject();
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
    );
  }

  void _addSubject() async {
    String subjectCode = subjectCodeController.text.trim();

    try {
      List<Cookie> res = await widget.cookieJar
          .loadForRequest(Uri.parse('http://localhost:3000/student/login'));

      if (res.isNotEmpty) {
        String token = res.first.value;
        Response response =
            await dio.post('http://localhost:3000/student/join-course',
                data: {
                  'code': subjectCode,
                },
                options: Options(headers: {"Authorization": "Bearer $token"}));
        print(response.data);
        _navigateTo(context, StudentSubjectPage(cookieJar: cookieJar));
      }
    } catch (e) {
      print(e);
    }

    Navigator.pop(context); // Return to the previous page (subject.dart)
  }

  void _navigateTo(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }
}
