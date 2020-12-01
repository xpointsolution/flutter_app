import 'package:flutter/material.dart';

enum TaskStep {NEW, TODO, IN_PROGRESS, TESTING, REVIEW, DONE}

class Task {

  String title;
  TaskStep taskStep;
  bool completed;

  Task({@required this.title, this.completed = false, this.taskStep = TaskStep.NEW});

  void toggleCompleted() {
    completed = !completed;
  }
  
}