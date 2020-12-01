import 'package:flutter/material.dart';
import 'package:flutter_app/models/task.dart';
import 'package:flutter_app/providers/task_change_notifier.dart';
import 'package:flutter_app/screens/edit_task_screen.dart';
import 'package:provider/provider.dart';


class TaskListItem extends StatelessWidget {
  final Task task;

  TaskListItem({@required this.task});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: UniqueKey(),
      onLongPress: () => Navigator.push(context,
        MaterialPageRoute(
          builder: (context) => EditTaskScreen(task: this.task),
        ),
      ),
      child: ListTile(
        leading: Checkbox(
          value: task.completed,
          onChanged: (bool checked) {
            Provider.of<TaskChangeNotifier>(context, listen: false).toggleTask(task);
          },
        ),
        title: Text(task.title),
        subtitle: Text(task.taskStep.toString()),
        trailing: IconButton(
          icon: Icon(
            Icons.delete,
            color: Colors.red,
          ),
          onPressed: () {
            Provider.of<TaskChangeNotifier>(context, listen: false).deleteTask(task);
          },
        ),
      ),
    );
  }
}