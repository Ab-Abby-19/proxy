import 'package:flutter/material.dart';
import 'add_course.dart'; // Import the necessary add course page
import 'uct101.dart'; // Import the necessary UCT101 page
import 'uct102.dart'; // Import the necessary UCT102 page

class CoursePage extends StatefulWidget {
  @override
  _CoursePageState createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  int selectedCourse = -1; // Track the selected course, -1 means none selected

  @override
  Widget build(BuildContext context) {
    return _buildCoursePage(context);
  }

  Widget _buildCourseTable(BuildContext context) {
    return DataTable(
      headingTextStyle: TextStyle(
          color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
      columns: [
        DataColumn(label: Text('Serial Number')),
        DataColumn(label: Text('Course Code')),
      ],
      rows: [
        DataRow(
          cells: [
            DataCell(Text('1', style: TextStyle(color: Colors.white))),
            DataCell(
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    _navigateTo(context, UCT101Page());
                  },
                  child: Text(
                    'UCT101',
                    style: _getCourseTextStyle(1),
                  ),
                ),
              ),
            ),
          ],
        ),
        DataRow(
          cells: [
            DataCell(Text('2', style: TextStyle(color: Colors.white))),
            DataCell(
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    _navigateTo(context, UCT102Page());
                  },
                  child: Text(
                    'UCT102',
                    style: _getCourseTextStyle(2),
                  ),
                ),
              ),
            ),
          ],
        ),
        // Add more rows as needed
      ],
    );
  }

  TextStyle _getCourseTextStyle(int courseNumber) {
    return TextStyle(
      fontSize: 14,
      color: selectedCourse == courseNumber ? Colors.blue : Colors.white,
      decoration: TextDecoration.underline,
    );
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCourseTable(context),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Navigate to Add Course Page
                  _navigateTo(context, AddCoursePage());
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
}
