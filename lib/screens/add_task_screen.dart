import 'package:flutter/material.dart';
import 'package:todoey/screens/tasks_screen.dart';
import 'package:provider/provider.dart';
import '../models/task_data.dart';

class AddTaskScreen extends StatelessWidget {
  static String newTaskName;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      //color: Color(0xFF757575),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          color: Colors.white,
        ),
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Add Task',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline1,
            ),
            TextField(
              onEditingComplete: () {
                Provider.of<TaskData>(context, listen: false)
                    .addTask(newTaskName);
                messageController.clear();
                Navigator.pop(context);
              },
              onChanged: (newValue) {
                newTaskName = newValue;
              },
              controller: messageController,
              autofocus: true,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
              ),
              decoration: InputDecoration(
                hintText: '',
                hintStyle: TextStyle(
                  decorationColor: Colors.green,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).primaryColor, width: 3.0),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    width: 7.0,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            FlatButton(
              onPressed: () {
                if (newTaskName != null) {
                  Provider.of<TaskData>(context, listen: false)
                      .addTask(newTaskName);
                }
                newTaskName = null;
                messageController.clear();
                Navigator.pop(context);
              },
              padding: EdgeInsets.symmetric(
                vertical: 15.0,
              ),
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              child: Text(
                'Add',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
