import 'package:flutter/material.dart';
import 'task_tile.dart';
import 'package:provider/provider.dart';
import '../models/task_data.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter/cupertino.dart';

class TasksList extends StatefulWidget {
  @override
  _TasksListState createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  void _onRefresh() async {
    Provider.of<TaskData>(context, listen: false).refreshList();
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 500));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(builder: (context, taskData, child) {
      return SmartRefresher(
        enablePullDown: true,
        //enablePullUp: false,
        header: ClassicHeader(
          completeText: '',
          refreshingText: '',
          releaseText: '',
          idleText: '',
          idleIcon: null,
          refreshingIcon: null,
          releaseIcon: Icon(
            CupertinoIcons.down_arrow,
            color: Colors.grey,
          ),
          completeIcon: null,
        ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        //onLoading: _onLoading,
        child: ListView.builder(
          itemBuilder: (context, index) {
            final task = taskData.listOfTasks[index];

            return TaskTile(
              taskName: task.name,
              isChecked: task.isDone,
              toggleCheckmark: (checkboxState) {
                taskData.updateTaskStatus(task);
              },
              onLongPress: () {
                taskData.removeTask(task);
              },
            );
          },
          itemCount: taskData.tasksLength,
        ),
      );
    });
  }
}
