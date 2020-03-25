import 'package:flutter/material.dart';

class TaskCheckbox extends StatelessWidget {
  final bool checkedState;
  final Function toggleState;
  TaskCheckbox({this.checkedState, this.toggleState});

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      activeColor: Colors.lightBlueAccent,
      value: checkedState,
      onChanged: toggleState,
    );
  }
}
