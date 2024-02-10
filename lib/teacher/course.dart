import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:wifi/main.dart';
import 'add_course.dart'; // Import the necessary add course page
import 'base_course.dart';

class CoursePage extends StatefulWidget {
  final CookieJar cookieJar;
  final String apiUrl;

  CoursePage({required this.cookieJar, required this.apiUrl});

  @override
  _CoursePageState createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  late Future<List<Course>> courses;

  @override
  void initState() {
    super.initState();
    courses = fetchCourses();
  }

  @override
  Widget build(BuildContext context) {
    return _buildCoursePage(context);
  }

  Widget _buildCourseTable(BuildContext context, List<Course> courses) {
    if (courses.isEmpty) {
      return Text('No courses found',
          style: TextStyle(color: Colors.white, fontSize: 16));
    } else {
      return DataTable(
        columnSpacing: 10.0,
        headingTextStyle: TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        columns: [
          DataColumn(
              label: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Serial', style: TextStyle(fontSize: 14)),
              Text('Number', style: TextStyle(fontSize: 14))
            ],
          )),
          DataColumn(
              label: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Course', style: TextStyle(fontSize: 14)),
              Text('Name', style: TextStyle(fontSize: 14))
            ],
          )),
          DataColumn(
              label: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Join', style: TextStyle(fontSize: 14)),
              Text('Code', style: TextStyle(fontSize: 14))
            ],
          )),
        ],
        rows: courses.map((course) {
          return DataRow(
            cells: [
              DataCell(Text(
                course.serial.toString(),
                style: TextStyle(color: Colors.white),
              )),
              DataCell(MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    _navigateTo(
                        context,
                        BaseCoursePage(
                          courseCode: course.courseCode.toString(),
                          cookieJar: widget.cookieJar,
                          apiUrl: widget.apiUrl,
                        ));
                  },
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    onEnter: (event) {
                      setState(() {
                        course.isHovered = true;
                      });
                    },
                    onExit: (event) {
                      setState(() {
                        course.isHovered = false;
                      });
                    },
                    child: Text(
                      course.courseName.toString(),
                      style: _getCourseTextStyle(course.isHovered),
                    ),
                  ),
                ),
              )),
              DataCell(
                Text(
                  course.code,
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          );
        }).toList(),
      );
    }
  }

  TextStyle _getCourseTextStyle(bool isHovered) {
    return TextStyle(
      fontSize: 14,
      color: isHovered ? Colors.blue : Colors.white,
      decoration: TextDecoration.underline,
    );
  }

  Widget _buildCoursePage(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of Courses'),
        leading: IconButton(
          icon: Icon(Icons.logout),
          onPressed: () {
            _logout(context);
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(color: const Color.fromARGB(255, 8, 8, 8)),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: FutureBuilder<List<Course>>(
            future: courses,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCourseTable(context, snapshot.data!),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        _navigateTo(
                            context,
                            AddCoursePage(
                                cookieJar: widget.cookieJar,
                                apiUrl: widget.apiUrl));
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 1, 11, 45),
                      ),
                      child: Text(
                        'Add Course',
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

  void _navigateTo(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  Future<List<Course>> fetchCourses() async {
    try {
      List<Cookie> res = await widget.cookieJar
          .loadForRequest(Uri.parse('${widget.apiUrl}/teacher/login'));
      if (res.isNotEmpty) {
        String token = res.first.value;
        final dio = Dio();
        dio.interceptors.add(CookieManager(widget.cookieJar));

        Response response = await dio.get(
          '${widget.apiUrl}/teacher/courses',
          options: Options(headers: {'Authorization': 'Bearer $token'}),
        );
        print(response.data);
        if (response.statusCode == 200) {
          // print('response: ${response.data['courses']}');
          List<dynamic> data = response.data['courses'];
          List<Course> courses =
              data.map((course) => Course.fromJson(course)).toList();
          return courses;
        } else {
          throw Exception('Failed to load courses');
        }
      } else {
        throw Exception('Failed to load courses');
      }
    } catch (e) {
      throw Exception('Failed to load courses: $e');
    }
  }

  void _logout(BuildContext context) async {
    try {
      await widget.cookieJar.deleteAll();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainPage(cookieJar: widget.cookieJar),
        ),
      );
    } catch (e) {
      throw Exception('Error logging out: $e');
    }
  }
}

class Course {
  final int? serial;
  final dynamic courseCode;
  final dynamic code;
  final dynamic courseName;
  bool isHovered = false;

  Course(
      {required this.serial,
      required this.courseCode,
      required this.code,
      required this.courseName,
      required this.isHovered});

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      serial: json['serial'] ?? 1,
      courseCode: json['courseCode'],
      code: json['code'],
      courseName: json['courseName'],
      isHovered: false,
    );
  }
}
