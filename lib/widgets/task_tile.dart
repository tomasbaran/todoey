import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  final String taskName;
  final bool isChecked;
  final Function toggleCheckmark;
  final Function onLongPress;
  TaskTile(
      {this.taskName, this.isChecked, this.toggleCheckmark, this.onLongPress});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: onLongPress,
      title: Text(
        taskName,
        style: Theme.of(context).textTheme.bodyText1.copyWith(
            decoration: isChecked ? TextDecoration.lineThrough : null),
      ),
      trailing: Checkbox(
        activeColor: Colors.lightBlueAccent,
        value: isChecked,
        onChanged: toggleCheckmark,
      ),
    );
  }
}
