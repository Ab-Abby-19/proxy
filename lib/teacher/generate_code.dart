import 'dart:async';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/material.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:location/location.dart';
import 'package:dio/dio.dart';

class GenerateCodePage extends StatefulWidget {
  final CookieJar cookieJar;
  final String courseCode;

  GenerateCodePage({required this.cookieJar, required this.courseCode});

  @override
  _GenerateCodePageState createState() => _GenerateCodePageState();
}

class _GenerateCodePageState extends State<GenerateCodePage> {
  late Timer _timer;
  int _remainingTime = 60;
  final info = NetworkInfo();
  String _addr = 'wlp2s0';
  double? _latitude = 51.507351;
  double? _longitude = -0.127758;
  String _code = '';
  bool sessionWorking = true;

  @override
  void initState() {
    super.initState();
    _startTimer();
    _generateRandomCode();
    // _getNetworkInfo();
    // _getLocation();
    // _requestLocationPermission();
  }

  @override
  Widget build(BuildContext context) {
    if (!sessionWorking) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Already have a session'),
          leading: Container(
            margin: EdgeInsets.all(7),
            child: Image.asset('images/app_logo.png', fit: BoxFit.contain),
          ),
        ),
        body: Center(
          child: Text('You already have a session running'),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('Generate Code', style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.white,
          leading: Container(
            margin: EdgeInsets.all(7),
            child: Image.asset('images/app_logo.png', fit: BoxFit.contain),
          ),
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
                  _code,
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
  }

  void _generateRandomCode() async {
    try {
      var dio = Dio();
      dio.interceptors.add(CookieManager(widget.cookieJar));

      List<Cookie> res = await widget.cookieJar
          .loadForRequest(Uri.parse('http://localhost:3000/teacher/login'));
      // print(res);
      if (res.isNotEmpty) {
        String token = res.first.value;
        Response response = await dio.post(
          'http://localhost:3000/teacher/create-session',
          data: {
            'courseID': widget.courseCode,
            'location': {
              'latitude': _latitude,
              'longitude': _longitude,
            },
            'networkInterface': _addr,
          },
          options: Options(headers: {'Authorization': 'Bearer $token'}),
        );
        // print(response.data);
        if (response.statusCode == 401) {
          setState(() {
            sessionWorking = false;
          });
          return;
        }
        String code = response.data['code'].toString();
        setState(() {
          _code = code;
        });
      }
    } catch (e) {
      throw Exception('Failed to generate random code: $e');
    }
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

  void _stopTimer() async {
    if (_timer.isActive) {
      try {
        _timer.cancel();
        List<Cookie> res = await widget.cookieJar
            .loadForRequest(Uri.parse('http://localhost:3000/teacher/login'));
        if (res.isNotEmpty) {
          String token = res.first.value;
          final dio = Dio();
          dio.interceptors.add(CookieManager(widget.cookieJar));

          Response response =
              await dio.post('http://localhost:3000/teacher/stop-session',
                  data: {
                    'sessionCode': _code,
                  },
                  options: Options(headers: {
                    'Authorization': 'Bearer $token',
                  }));
          print(response.data);
        }
      } catch (e) {
        print('Failed to stop timer: $e');
      }
    }
  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
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

  void _requestLocationPermission() async {
    var status = await Permission.location.status;
    if (status.isDenied) {
      var result = await Permission.location.request();
      if (result.isGranted) {
        print('Permission granted');
      } else {
        print('Permission denied');
      }
    } else if (status.isGranted) {
      print('Permission granted');
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
}
