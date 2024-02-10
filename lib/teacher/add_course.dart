import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wifi/teacher/course.dart';

class AddCoursePage extends StatefulWidget {
  final CookieJar cookieJar;
  final String apiUrl;

  AddCoursePage({required this.cookieJar, required this.apiUrl});

  @override
  _AddCoursePageState createState() => _AddCoursePageState();
}

class _AddCoursePageState extends State<AddCoursePage> {
  final TextEditingController subjectCodeController = TextEditingController();
  final TextEditingController subjectNameController = TextEditingController();

  final cookieJar = CookieJar();
  final dio = Dio();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Course', style: TextStyle(color: Colors.black)),
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
                'Enter Subject Code:',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              SizedBox(height: 10),
              TextField(
                controller: subjectCodeController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Subject Code',
                  labelStyle: TextStyle(color: Colors.grey),
                ),
              ),
              Text(
                'Enter Subject Name:',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              SizedBox(height: 8),
              TextField(
                controller: subjectNameController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Subject Name',
                  labelStyle: TextStyle(color: Colors.grey),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _submitCourse(context);
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

  void _submitCourse(BuildContext context) async {
    String enteredSubjectCode = subjectCodeController.text.trim();
    String enteredSubjectName = subjectNameController.text.trim();

    try {
      List<Cookie> res = await widget.cookieJar
          .loadForRequest(Uri.parse('${widget.apiUrl}/teacher/login'));
      print(res);

      if (res.isNotEmpty) {
        String token = res.first.value;
        Response response =
            await dio.post('${widget.apiUrl}/teacher/create-course',
                data: {
                  'courseCode': enteredSubjectCode,
                  'courseName': enteredSubjectName,
                },
                options: Options(headers: {'Authorization': 'Bearer $token'}));
        print(response.data);
        _navigateTo(
            context, CoursePage(cookieJar: cookieJar, apiUrl: widget.apiUrl));
      }
    } catch (e) {
      print(e);
    }
    Navigator.pop(context);
  }

  void _navigateTo(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }
}
