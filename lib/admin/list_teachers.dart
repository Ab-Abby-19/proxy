// lib/admin/list_teachers.dart
import 'package:flutter/material.dart';

class ListTeachersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of Teachers',
            style: TextStyle(color: const Color.fromARGB(255, 17, 16, 16))),
      ),
      body: Container(
        decoration: BoxDecoration(color: const Color.fromARGB(255, 8, 8, 8)),
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SizedBox(
              height: 400, // Adjust the height as needed
              child: DataTable(
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
                        Text('Number', style: TextStyle(fontSize: 14)),
                      ],
                    ),
                  ),
                  DataColumn(
                    label: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('List of', style: TextStyle(fontSize: 14)),
                        Text('Teachers', style: TextStyle(fontSize: 14)),
                      ],
                    ),
                  ),
                  DataColumn(
                    label: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Date', style: TextStyle(fontSize: 14)),
                        Text('Created', style: TextStyle(fontSize: 14)),
                      ],
                    ),
                  ),
                ],
                rows: [
                  DataRow(
                    cells: [
                      DataCell(
                          Text('1', style: TextStyle(color: Colors.white))),
                      DataCell(
                          Text('abc', style: TextStyle(color: Colors.white))),
                      DataCell(
                          Text('12', style: TextStyle(color: Colors.white))),
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(
                          Text('2', style: TextStyle(color: Colors.white))),
                      DataCell(
                          Text('def', style: TextStyle(color: Colors.white))),
                      DataCell(
                          Text('13', style: TextStyle(color: Colors.white))),
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(
                          Text('3', style: TextStyle(color: Colors.white))),
                      DataCell(
                          Text('ghi', style: TextStyle(color: Colors.white))),
                      DataCell(
                          Text('13', style: TextStyle(color: Colors.white))),
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(
                          Text('4', style: TextStyle(color: Colors.white))),
                      DataCell(
                          Text('jkl', style: TextStyle(color: Colors.white))),
                      DataCell(
                          Text('13', style: TextStyle(color: Colors.white))),
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(
                          Text('5', style: TextStyle(color: Colors.white))),
                      DataCell(
                          Text('mno', style: TextStyle(color: Colors.white))),
                      DataCell(
                          Text('14', style: TextStyle(color: Colors.white))),
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(
                          Text('6', style: TextStyle(color: Colors.white))),
                      DataCell(
                          Text('pqr', style: TextStyle(color: Colors.white))),
                      DataCell(
                          Text('14', style: TextStyle(color: Colors.white))),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
