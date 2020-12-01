import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_app/models/task.dart';



class TaskChangeNotifier extends ChangeNotifier {

  final List<Task> _tasks = [
    Task(title: 'Finish the app'),
    Task(title: 'Get hired!'),
    Task(title: 'Share with community'),
  ];

  TaskStep _taskStepFilter;
  bool _filterCondition(Task task) => _taskStepFilter!=null ? task.taskStep == _taskStepFilter : true;


  UnmodifiableListView<Task> get allTasks => UnmodifiableListView(_tasks.where((t) => _filterCondition(t)));
  UnmodifiableListView<Task> get incompleteTasks =>
      UnmodifiableListView(_tasks.where((t) => !t.completed && _filterCondition(t)));
  UnmodifiableListView<Task> get completedTasks =>
      UnmodifiableListView(_tasks.where((t) => t.completed && _filterCondition(t)));
  TaskStep get taskStepFilter => _taskStepFilter;

  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  void toggleTask(Task task) {
    final taskIndex = _tasks.indexOf(task);
    _tasks[taskIndex].toggleCompleted();
    notifyListeners();
  }

  void deleteTask(Task task) {
    _tasks.remove(task);
    notifyListeners();
  }

  void setTaskFilter(TaskStep step) {
    this._taskStepFilter = step;
    notifyListeners();
  }

  void clearTaskFilter() {
    this._taskStepFilter = null;
    notifyListeners();
  }

}