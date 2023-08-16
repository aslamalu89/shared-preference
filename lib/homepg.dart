import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> studentNames = [];

  @override
  void initState() {
    super.initState();
    _getStudentNames();
  }

  Future<void> _getStudentNames() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> storedNames = prefs.getStringList('student_names') ?? [];
    setState(() {
      studentNames = storedNames;
    });
  }

  Future<void> _saveStudentNames() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('student_names', studentNames);
  }

  void _addStudentName() {
    setState(() {
      studentNames.add('aslam');
      studentNames.add('alu');
      studentNames.add('akash');
      studentNames.add('michael');
      studentNames.add('jhon');
      _saveStudentNames();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(' Student List')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text('Student Names:'),
            for (var name in studentNames) Text(name),
            ElevatedButton(
              onPressed: _addStudentName,
              child: Text('Add Students'),
            ),
          ],
        ),
      ),
    );
  }
}
