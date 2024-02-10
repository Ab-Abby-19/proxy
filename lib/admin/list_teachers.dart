// lib/admin/list_teachers.dart
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/material.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';

class ListTeachersPage extends StatefulWidget {
  final CookieJar cookieJar;
  final String apiUrl;

  ListTeachersPage({required this.cookieJar, required this.apiUrl});

  @override
  _ListTeachersPageState createState() => _ListTeachersPageState();
}

class _ListTeachersPageState extends State<ListTeachersPage> {
  late Future<List<Teacher>> teachers;

  @override
  void initState() {
    super.initState();
    teachers = fetchTeachers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'List of Teachers',
            style: TextStyle(color: const Color.fromARGB(255, 17, 16, 16)),
          ),
        ),
        body: Container(
            decoration:
                BoxDecoration(color: const Color.fromARGB(255, 17, 16, 16)),
            width: double.infinity,
            height: double.infinity,
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: FutureBuilder<List<Teacher>>(
                  future: teachers,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return DataTable(
                          columnSpacing: 10.0,
                          headingRowColor: MaterialStateColor.resolveWith(
                              (states) => Color.fromARGB(255, 1, 11, 45)),
                          headingTextStyle: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
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
                                Text('List of', style: TextStyle(fontSize: 14)),
                                Text('Teachers', style: TextStyle(fontSize: 14))
                              ],
                            )),
                            DataColumn(
                                label: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Email', style: TextStyle(fontSize: 14)),
                                // Text('Created', style: TextStyle(fontSize: 14))
                              ],
                            ))
                          ],
                          rows: snapshot.data!.map((teacher) {
                            return DataRow(
                              cells: [
                                DataCell(Text(teacher.serial.toString(),
                                    style: TextStyle(color: Colors.white))),
                                DataCell(Text(teacher.userName,
                                    style: TextStyle(color: Colors.white))),
                                DataCell(Text(teacher.email,
                                    style: TextStyle(color: Colors.white))),
                              ],
                            );
                          }).toList());
                    }
                  },
                ))));
  }

  Future<List<Teacher>> fetchTeachers() async {
    try {
      List<Cookie> res = await widget.cookieJar
          .loadForRequest(Uri.parse('${widget.apiUrl}/admin/login'));
      if (res.isNotEmpty) {
        String token = res.first.value;

        final dio = Dio();
        dio.interceptors.add(CookieManager(widget.cookieJar));

        Response response = await dio.get('${widget.apiUrl}/admin/teachers',
            options: Options(headers: {'Authorization': 'Bearer $token'}));
        // print(response.data);

        if (response.statusCode == 200) {
          List<dynamic> data = response.data['teachers'];
          List<Teacher> teachers =
              data.map((json) => Teacher.fromJson(json)).toList();
          print(teachers);
          return teachers;
        } else {
          throw Exception('Failed bruh!');
        }
      } else {
        throw Exception('Failed to load teachers');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}

class Teacher {
  final dynamic serial;
  final String userName;
  final String email;

  Teacher({
    required this.serial,
    required this.userName,
    required this.email,
  });

  factory Teacher.fromJson(Map<String, dynamic> json) {
    print(json);
    return Teacher(
        serial: json['__v'], userName: json['userName'], email: json['email']);
  }
}
