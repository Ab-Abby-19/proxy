import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:fl_chart/fl_chart.dart';

class ViewAttendancePage extends StatefulWidget {
  final CookieJar cookieJar;
  final String subjectCode;

  ViewAttendancePage({required this.cookieJar, required this.subjectCode});

  @override
  _ViewAttendancePageState createState() => _ViewAttendancePageState();
}

class _ViewAttendancePageState extends State<ViewAttendancePage> {
  final cookieJar = CookieJar();
  final dio = Dio();
  int totalSessions = 15;
  int attendedSessions = 10;
  int leftSessions = 2;

  @override
  void initState() {
    super.initState();
    // getAttendance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.subjectCode} Attendance',
            style: TextStyle(color: const Color.fromARGB(255, 16, 16, 16))),
      ),
      body: Container(
        decoration: BoxDecoration(color: const Color.fromARGB(255, 8, 8, 8)),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: _buildAttendanceChart(context),
          ),
        ),
      ),
    );
  }

  Widget _buildAttendanceChart(BuildContext context) {
    try {
      if (totalSessions != 0) {
        int absentSessions = totalSessions - attendedSessions - leftSessions;

        double attendedPercentage = (attendedSessions / totalSessions) * 100;
        double absentPercentage = (absentSessions / totalSessions) * 100;
        double leftPercentage = (leftSessions / totalSessions) * 100;

        String status = '';

        if (attendedPercentage >= 75) {
          status = 'On the right track';
        } else if (attendedPercentage >= 50 && leftPercentage < 10) {
          status = 'Consistent attendance with a few misses';
        } else {
          status = 'Potential attendance issues';
        }

        return Column(
          children: [
            SizedBox(
              height: 370,
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      color: const Color.fromARGB(255, 76, 86, 175),
                      value: attendedPercentage,
                      title:
                          'Attended\n${attendedPercentage.toStringAsFixed(2)}%',
                      radius: 50,
                      titleStyle: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    PieChartSectionData(
                      color: Color.fromARGB(255, 153, 160, 221),
                      value: absentPercentage,
                      title: 'Absent\n${absentPercentage.toStringAsFixed(2)}%',
                      radius: 50,
                      titleStyle: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    PieChartSectionData(
                      color: Color.fromARGB(255, 183, 185, 202),
                      value: leftPercentage,
                      title: 'Left\n${leftPercentage.toStringAsFixed(2)}%',
                      radius: 50,
                      titleStyle: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Attendance Status: $status',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        );
      } else {
        throw Exception('Error fetching attendance data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  void getAttendance() async {
    try {
      List<Cookie> res = await widget.cookieJar
          .loadForRequest(Uri.parse('http://localhost:3000/student/login'));
      if (res.isNotEmpty) {
        String token = res.first.value;
        final dio = Dio();
        dio.interceptors.add(CookieManager(widget.cookieJar));

        Response response = await dio.get(
          'http://localhost:3000/student/attendance',
          data: {
            'courseID': widget.subjectCode,
          },
          options: Options(headers: {'Authorization': 'Bearer $token'}),
        );
        print(response.data);
        if (response.statusCode == 200) {
          setState(() {
            totalSessions = response.data['totalSessions'];
            attendedSessions = response.data['attendedSessions'];
            leftSessions = response.data['leftSessions'];
          });
        } else {
          throw Exception('Failed to load attendance');
        }
      } else {
        throw Exception('Failed to load attendance');
      }
    } catch (e) {
      throw Exception('Failed to load attendance: $e');
    }
  }
}
