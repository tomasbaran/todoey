import 'package:flutter/material.dart';
import 'package:todoey/models/task_data.dart';
import 'screens/tasks_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider<TaskData>(
    create: (context) => TaskData(),
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    Provider.of<TaskData>(context, listen: false).readJson();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        //canvasColor: Colors.transparent,
        primaryColor: Colors.lightBlueAccent,
        textTheme: TextTheme(
            bodyText1: TextStyle(
              fontSize: 18,
            ),
            headline1: TextStyle(
                fontSize: 34,
                color: Colors.lightBlueAccent,
                fontWeight: FontWeight.w600)),
      ),
      home: TasksScreen(),
    );
  }
}
