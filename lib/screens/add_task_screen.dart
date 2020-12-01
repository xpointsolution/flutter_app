import 'package:flutter/material.dart';
import 'package:flutter_app/models/task.dart';
import 'package:flutter_app/providers/task_change_notifier.dart';
import 'package:provider/provider.dart';


class AddTaskScreen extends StatefulWidget {

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {

  final taskTitleController = TextEditingController(text: 'New Task');
  bool completedStatus = false;
  TaskStep taskStep = TaskStep.NEW;

  TaskChangeNotifier taskChangeNotifier;

  @override
  void initState() {
    taskChangeNotifier = Provider.of<TaskChangeNotifier>(context, listen: false);
    super.initState();
  }


  @override
  void dispose() {
    taskTitleController.dispose();
    super.dispose();
  }

  void onAdd() {
    final String textVal = taskTitleController.text;
    final bool completed = completedStatus;
    if (textVal.isNotEmpty) {
      final Task t = Task(
        title: textVal,
        completed: completed,
        taskStep: taskStep,
      );
      taskChangeNotifier.addTask(t);
      Navigator.pop(context);
    }
  }


  List<DropdownMenuItem> _getAllTaskSteps() =>
      TaskStep.values.map((e) =>
          DropdownMenuItem(child: Text(e.toString()),value: e,)).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Task'),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextField(controller: taskTitleController),
                  Container(
                    child: DropdownButton(
                        items: _getAllTaskSteps(),
                        value: taskStep,
                        onChanged: (step) => setState(() {
                          taskStep = step;
                        })
                    ),
                    height: 50,
                  ),
                  CheckboxListTile(
                    value: completedStatus,
                    onChanged: (checked) => setState(() {
                      completedStatus = checked;
                    }),
                    title: Text('Complete?'),
                  ),
                  RaisedButton(
                    child: Text('Add'),
                    onPressed: onAdd,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}