// lib/update_details.dart
import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:wifi/student/subject.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

class UpdateDetailsPage extends StatefulWidget {
  final CookieJar cookieJar;
  final String apiUrl;

  UpdateDetailsPage({required this.cookieJar, required this.apiUrl});

  @override
  _UpdateDetailsPageState createState() => _UpdateDetailsPageState();
}

class _UpdateDetailsPageState extends State<UpdateDetailsPage> {
  TextEditingController rollNumberController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();
  TextEditingController batchController = TextEditingController();
  TextEditingController yearController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // You can prefill the fields with the existing details here
    // For example:
    // rollNumberController.text = existingRollNumber;
    // contactNumberController.text = existingContactNumber;
    // batchController.text = existingBatch;
    // yearController.text = existingYear;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Details'),
      ),
      body: Container(
        decoration: BoxDecoration(color: const Color.fromARGB(255, 8, 8, 8)),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: rollNumberController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Roll Number',
                    labelStyle: TextStyle(color: Colors.grey),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: contactNumberController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Contact Number',
                    labelStyle: TextStyle(color: Colors.grey),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: batchController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Batch',
                    labelStyle: TextStyle(color: Colors.grey),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: yearController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Year',
                    labelStyle: TextStyle(color: Colors.grey),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _submitForm();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 1, 11, 45),
                  ),
                  child: Text(
                    'Update',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submitForm() async {
    if (_areAllFieldsFilled()) {
      try {
        List<Cookie> res = await widget.cookieJar
            .loadForRequest(Uri.parse('${widget.apiUrl}/student/login'));
        if (res.isNotEmpty) {
          final dio = Dio();
          dio.interceptors.add(CookieManager(widget.cookieJar));

          final response = await dio.post(
            '${widget.apiUrl}/student/update',
            data: {
              'rollNumber': rollNumberController.text,
              'contactNumber': contactNumberController.text,
              'batch': batchController.text,
              'year': yearController.text,
            },
          );
          print(response.data);
        }
      } catch (e) {
        print('Error: $e');
      }
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in all fields.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  bool _areAllFieldsFilled() {
    return rollNumberController.text.isNotEmpty &&
        contactNumberController.text.isNotEmpty &&
        batchController.text.isNotEmpty &&
        yearController.text.isNotEmpty;
  }

  void _navigateTo(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }
}
