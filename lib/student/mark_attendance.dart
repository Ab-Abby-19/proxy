import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:location/location.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wifi/student/view_attendance.dart';

class MarkAttendancePage extends StatefulWidget {
  final CookieJar cookieJar;
  final String subjectCode;

  MarkAttendancePage({required this.cookieJar, required this.subjectCode});

  @override
  _MarkAttendancePageState createState() => _MarkAttendancePageState();
}

class _MarkAttendancePageState extends State<MarkAttendancePage> {
  TextEditingController attendanceCodeController = TextEditingController();
  double? _latitude = 51.507351;
  double? _longitude = -0.127758;
  String _addr = 'wlp2s0';
  final coookieJar = CookieJar();
  final dio = Dio();
  final info = NetworkInfo();

  @override
  void initState() {
    super.initState();
    dio.interceptors.add(CookieManager(coookieJar));
    // _getLocation();
    _getNetworkInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('${widget.subjectCode} Attendance',
              style: TextStyle(color: const Color.fromARGB(255, 16, 16, 16))),
        ),
        body: Container(
            decoration:
                BoxDecoration(color: const Color.fromARGB(255, 8, 8, 8)),
            width: double.infinity,
            child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: attendanceCodeController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Attendance Code',
                        labelStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        _submitAttendanceCode();
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
                ))));
  }

  void _submitAttendanceCode() async {
    try {
      List<Cookie> res = await widget.cookieJar
          .loadForRequest(Uri.parse('http://localhost:3000/student/login'));
      print(res);
      if (res.isNotEmpty) {
        String token = res.first.value;
        Response response = await dio.post(
          'http://localhost:3000/student/attendance',
          data: {
            'code': attendanceCodeController.text.trim(),
            'courseID': widget.subjectCode,
            'location': {
              'latitude': _latitude,
              'longitude': _longitude,
            },
            'networkInterface': _addr,
          },
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }),
        );
        print(response.data);
        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Attendance marked successfully'),
            ),
          );
        } else if (response.statusCode == 201) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Session is off'),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(response.data['message']),
            ),
          );
        }
        // _navigateTo(
        //     context,
        //     ViewAttendancePage(
        //         cookieJar: widget.cookieJar, subjectCode: widget.subjectCode));
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _getLocation() async {
    try {
      // _requestLocationPermission();
      var location = Location();
      var currLocation = await location.getLocation();
      setState(() {
        _latitude = currLocation.latitude;
        _longitude = currLocation.longitude;
      });
    } catch (e) {
      print('Failed to get location: $e');
    }
  }

  Future<void> _getNetworkInfo() async {
    try {
      // _requestLocationPermission();
      final wifiBroadCast = await info.getWifiBroadcast();
      print('Wifi broadcast: $wifiBroadCast');
      if (wifiBroadCast != null) {
        setState(() {
          _addr = wifiBroadCast;
        });
      }
      print(wifiBroadCast);
    } catch (e) {
      print('Failed to get network info: $e');
    }
  }

  void _navigateTo(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }
}
