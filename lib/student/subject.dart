// lib/student/subject.dart
import 'package:flutter/material.dart';
import 'add_subject.dart'; // Import the necessary add subject page
import 'uct101_attendance.dart';
import 'view_attendance.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';

class StudentSubjectPage extends StatefulWidget {
  final CookieJar cookieJar;

  StudentSubjectPage({required this.cookieJar});

  @override
  _StudentSubjectPageState createState() => _StudentSubjectPageState();
}

class _StudentSubjectPageState extends State<StudentSubjectPage> {
  Future<List<Subject>> subjects = Future.value([]);

  @override
  void initState() {
    super.initState();
    subjects = fetchSubjects();
  }

  @override
  Widget build(BuildContext context) {
    return _buildCoursePage(context);
  }

  Widget _buildSubjectTable(BuildContext context, List<Subject> subjects) {
    if (subjects.isEmpty) {
      return Text('No courses found',
          style: TextStyle(color: Colors.white, fontSize: 16));
    } else {
      return DataTable(
        columnSpacing: 10.0, // Adjust column spacing as needed
        headingTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        columns: [
          DataColumn(
            label: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Serial', style: TextStyle(fontSize: 12)),
                Text('Number', style: TextStyle(fontSize: 12)),
              ],
            ),
          ),
          DataColumn(
            label: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Subject', style: TextStyle(fontSize: 12)),
                Text('Code', style: TextStyle(fontSize: 12)),
              ],
            ),
          ),
          DataColumn(
            label: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Subject', style: TextStyle(fontSize: 12)),
                Text('Name', style: TextStyle(fontSize: 12)),
              ],
            ),
          ),
        ],
        rows: subjects.map((subject) {
          return DataRow(
            cells: [
              DataCell(Text(
                subject.serial.toString(),
                style: TextStyle(color: Colors.white),
              )),
              DataCell(
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      _navigateTo(
                          context,
                          ViewAttendancePage(
                            cookieJar: widget.cookieJar,
                            subjectCode: subject.courseCode,
                          ));
                    },
                    child: Text(
                      subject.courseCode,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              DataCell(
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      _navigateTo(context, UCT101AttendancePage()); //TODO:
                    },
                    child: Text(
                      subject.courseName,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          );
        }).toList(),
      );
    }
  }

  Widget _buildCoursePage(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of Courses',
            style: TextStyle(color: const Color.fromARGB(255, 16, 16, 16))),
      ),
      body: Container(
        decoration: BoxDecoration(color: const Color.fromARGB(255, 8, 8, 8)),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: FutureBuilder<List<Subject>>(
            future: subjects,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.data == null) {
                return Container();
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (snapshot.data != null)
                      _buildSubjectTable(context, snapshot.data!),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        _navigateTo(
                            context,
                            AddSubjectPage(
                              cookieJar: widget.cookieJar,
                            ));
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 1, 11, 45),
                      ),
                      child: Text(
                        'Join Course',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Future<List<Subject>> fetchSubjects() async {
    try {
      List<Cookie> res = await widget.cookieJar
          .loadForRequest(Uri.parse('http://localhost:3000/student/login'));
      if (res.isNotEmpty) {
        String token = res.first.value;
        // print(token);
        final dio = Dio();
        dio.interceptors.add(CookieManager(widget.cookieJar));

        Response response = await dio.get(
            'http://localhost:3000/student/courses',
            options: Options(headers: {'Authorization': 'Bearer $token'}));
        print(response.data);
        List<dynamic> data = response.data['courses'];
        List<Subject> subjects =
            data.map((subject) => Subject.fromJson(subject)).toList();
        return subjects;
      } else {
        throw Exception('Failed to load subjects');
      }
    } catch (e) {
      throw Exception('Failed to load subjects');
    }
  }

  void _navigateTo(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }
}

class Subject {
  final int? serial;
  final String courseCode;
  final String courseName;

  Subject(
      {required this.serial,
      required this.courseCode,
      required this.courseName});

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      serial: json['serial'] ?? 1,
      courseCode: json['courseCode'],
      courseName: json['courseName'],
    );
  }
}
