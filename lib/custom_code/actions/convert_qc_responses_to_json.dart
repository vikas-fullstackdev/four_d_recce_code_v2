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

// Import your custom structs
import 'dart:convert';

// Function signature
Future<List> convertQcResponsesToJson(List inputList) async {
  // Ensure the input list is valid and structured correctly
  final result = inputList.map((item) {
    return {
      "qc_que": item['qc_que'] ?? '',
      "qc_ans": item['qc_ans'] ?? '',
      "qc_img": item['qc_img'] ?? '',
    };
  }).toList();
  print(result);
  return result;
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
