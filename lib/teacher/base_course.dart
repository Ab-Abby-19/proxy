import 'package:flutter/material.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'generate_code.dart';
import 'mark_attendance.dart';

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
  @override
  void initState() {
    super.initState();
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
              FutureBuilder<String>(
                future: viewAttendanceUrl,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return _buildWebViewButton(
                      context,
                      'View Attendance',
                      snapshot.data ?? '',
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
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

  Widget _buildWebViewButton(BuildContext context, String label, String url) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WebviewScaffold(
              appBar: AppBar(
                title: Text(label),
              ),
              url: url,
              withLocalStorage: true,
              withJavascript: true,
              hidden: true,
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

  Future<String> get viewAttendanceUrl async {
    try {
      List<Cookie> res = await widget.cookieJar
          .loadForRequest(Uri.parse('${widget.apiUrl}/teacher/login'));
      if (res.isNotEmpty) {
        String token = res.first.value;
        print('token: $token');
        // final dio = Dio();
        // dio.interceptors.add(CookieManager(cookieJar));

        // Response response = await dio.get('${widget.apiUrl}/teacher/sheet',
        //     data: {courseCode: widget.courseCode},
        //     options: Options(headers: {'Authorization': 'Bearer $token'}));
        // String url = response.data['url'];
        String url =
            "https://docs.google.com/spreadsheets/d/1l2D02v-9vRWW_g6XtueEcTpq9lIliOMplBEcv66Hbd0/edit#gid=0";
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
