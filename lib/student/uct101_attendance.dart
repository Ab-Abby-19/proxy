// lib/student/uct101.dart
import 'dart:math';
import 'package:flutter/material.dart';


class UCT101AttendancePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'UCT101 Attendance',
          style: TextStyle(color: Colors.black), // Align text color with the background
        ),
      ),
      body: Container(
        decoration: BoxDecoration(color: const Color.fromARGB(255, 8, 8, 8)),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: _buildAttendanceTable(context),
          ),
        ),
      ),
    );
  }

  Widget _buildAttendanceTable(BuildContext context) {
    return DataTable(
      columnSpacing: 10.0,
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
              Text('Serial', style: TextStyle(fontSize: 14)),
              Text('Number', style: TextStyle(fontSize: 14)),
            ],
             ),
        ),
        DataColumn(
          label: Text('Date', style: TextStyle(fontSize: 14, color: Colors.white)),
        ),
        DataColumn(
          label: Text('Attendance', style: TextStyle(fontSize: 14, color: Colors.white)),
        ),
      ],
      rows: _generateAttendanceRows(),
    );
  }

  List<DataRow> _generateAttendanceRows() {
    List<DataRow> rows = [];
    final random = Random();

    for (int i = 1; i <= 15; i++) {
      final isPresent = true;
      final randomDate = DateTime.now().add(Duration(days: i)); // Display dates in order

      rows.add(DataRow(
        cells: [
          DataCell(Text(i.toString(), style: TextStyle(color: Colors.white))),
          DataCell(
            Text(
              '${randomDate.day}/${randomDate.month}/${randomDate.year}',
              style: TextStyle(color: Colors.white),
            ),
          ),
          DataCell(
            Text(
              'Present',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ));
    }

    for (int i = 1; i <= 5; i++) {
      final isPresent = false;
      final randomDate = DateTime.now().add(Duration(days: random.nextInt(15) + 1)); // Random date

      rows.add(DataRow(
        cells: [
          DataCell(Text((i + 15).toString(), style: TextStyle(color: Colors.white))),
          DataCell(
            Text(
              '${randomDate.day}/${randomDate.month}/${randomDate.year}',
              style: TextStyle(color: Colors.white),
            ),
          ),
          DataCell(
            Text(
              'Absent',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ));
    }

    return rows;
  }
}
