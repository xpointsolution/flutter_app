import 'package:flutter/material.dart';
import 'package:flutter_app/models/task.dart';
import 'package:flutter_app/providers/task_change_notifier.dart';
import 'package:flutter_app/widgets/all_tasks.dart';
import 'package:flutter_app/widgets/completed_tasks.dart';
import 'package:flutter_app/widgets/incomplete_tasks.dart';
import 'package:provider/provider.dart';

import 'add_task_screen.dart';


class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {

  TabController controller;
  TaskChangeNotifier taskChangeNotifier;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      taskChangeNotifier = Provider.of<TaskChangeNotifier>(context, listen: false);
    });
    controller = TabController(length: 3, vsync: this);
    super.initState();
  }

  void onFilterButtonPressed() {

    TaskStep selectedVal = taskChangeNotifier.taskStepFilter == null ?  TaskStep.NEW : taskChangeNotifier.taskStepFilter;

    _clearFilter(){
      taskChangeNotifier.clearTaskFilter();
      Navigator.pop(context);
    }
    _confirmFilter(){
      taskChangeNotifier.setTaskFilter(selectedVal);
      Navigator.pop(context);
    }

    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (_) => AlertDialog(
          title: Text('Filter options'),
          content: DropdownButton(
              items: TaskStep.values.map((e) =>
                  DropdownMenuItem(child: Text(e.toString()),value: e,)).toList(),
              value: selectedVal,
              onChanged: (step) => setState(() {
                selectedVal = step;
              }),
          ),
        actions: [
          FlatButton(onPressed: _clearFilter, child: Text('Clear')),
          FlatButton(onPressed: _confirmFilter, child: Text('Confirm')),
        ],
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Tasks'),
        actions: [
          IconButton(icon: Icon(Icons.filter_alt_outlined), onPressed: onFilterButtonPressed)
        ],
        bottom: TabBar(
          controller: controller,
          tabs: <Widget>[
            Tab(text: 'All'),
            Tab(text: 'Incomplete'),
            Tab(text: 'Complete'),
          ],
        ),
      ),
      body: TabBarView(
        controller: controller,
        children: <Widget>[
          AllTasksTab(),
          IncompleteTasksTab(),
          CompletedTasksTab(),
        ],
      ),
    floatingActionButton: FloatingActionButton.extended(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddTaskScreen(),
          ),
        );
      },
      label: Text('Add task'),
      icon: Icon(Icons.add),
      backgroundColor: Colors.lightBlueAccent,
    ),
    );
  }
}