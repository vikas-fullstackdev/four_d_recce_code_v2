// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
import 'dart:convert';

Future<dynamic> updateTaskNameRemoveDone(
  dynamic inputJson,
  int taskIndex,
  int taskNameIndex,
) async {
  // Deep copy input JSON
  final List<dynamic> tasks = List.from(inputJson['task']);

  // Validate task index
  if (taskIndex >= 0 && taskIndex < tasks.length) {
    final task = Map<String, dynamic>.from(tasks[taskIndex]);

    if (task['task_name'] is List) {
      // If task_name is a list
      final List<dynamic> names = List.from(task['task_name']);
      if (taskNameIndex >= 0 && taskNameIndex < names.length) {
        String currentName = names[taskNameIndex].toString();
        if (currentName.endsWith('#done')) {
          names[taskNameIndex] = currentName.replaceAll('#done', '');
        }
        task['task_name'] = names;
      }
    } else if (task['task_name'] is String) {
      // If task_name is a string
      String currentName = task['task_name'];
      if (currentName.endsWith('#done')) {
        task['task_name'] = currentName.replaceAll('#done', '');
      }
    }

    // Update the task
    tasks[taskIndex] = task;
  }

  // Return updated JSON
  return {"task": tasks};
}
