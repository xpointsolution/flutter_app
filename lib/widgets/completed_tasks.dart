import 'package:flutter/material.dart';
import 'package:flutter_app/providers/task_change_notifier.dart';
import 'package:flutter_app/widgets/task_list.dart';
import 'package:provider/provider.dart';



class CompletedTasksTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<TaskChangeNotifier>(
        builder: (context, model, child) => TaskList(
          tasks: model.completedTasks,
        ),
      ),
    );
  }
}