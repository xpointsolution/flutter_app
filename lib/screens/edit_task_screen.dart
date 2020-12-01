import 'package:flutter/material.dart';
import 'package:flutter_app/models/task.dart';
import 'package:flutter_app/providers/task_change_notifier.dart';
import 'package:provider/provider.dart';

class EditTaskScreen extends StatefulWidget {

  final Task task;
  const EditTaskScreen({@required this.task});

  @override
  _EditTaskScreenState createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {

  Task _task;
  TaskChangeNotifier taskChangeNotifier;
  TextEditingController taskTitleController;

  @override
  void initState() {
    this._task = widget.task;
    taskTitleController = TextEditingController(text: widget.task.title);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      taskChangeNotifier = Provider.of<TaskChangeNotifier>(context, listen: false);
    });
    super.initState();
  }

  @override
  void dispose() {
    taskTitleController.dispose();
    super.dispose();
  }

  void onEdit() {
    taskChangeNotifier.deleteTask(widget.task);
    taskChangeNotifier.addTask(_task);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Task'),
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
                        items: TaskStep.values.map((e) =>
                            DropdownMenuItem(child: Text(e.toString()),value: e,)).toList(),
                        value: _task.taskStep,
                        onChanged: (step) => setState(() {
                          _task.taskStep = step;
                        })
                    ),
                    height: 50,
                  ),
                  CheckboxListTile(
                    value: _task.completed,
                    onChanged: (checked) => setState(() {
                      _task.completed = checked;
                    }),
                    title: Text('Complete?'),
                  ),
                  RaisedButton(
                    child: Text('Edit'),
                    onPressed: onEdit,
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
