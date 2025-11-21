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
// Define all possible pages
// Main Function Name
// 1. On page load: build the list of valid page indexes
// int _iteratorPos = 0; // external variable to keep track of the position

int getNextPageIndex(int currentIndex, List<String> visibleItems) {
  final allPages = [
    "int_a",
    "int_b",
    "int_c",
    "int_d",
    "int_e",
    "int_f",
    "int_g",
    "mep_a",
    "mep_b",
    "mep_c",
    "mep_d",
    "mep_e",
    "mep_f",
    "mep_g",
  ];

  // Build list of indexes of visible pages
  List<int> trueIndexes = [];
  for (int i = 0; i < allPages.length; i++) {
    if (visibleItems.contains(allPages[i])) {
      trueIndexes.add(i);
    }
  }

  if (trueIndexes.isEmpty) return currentIndex; // fallback

  // Find where the currentIndex is inside trueIndexes
  int pos = trueIndexes.indexOf(currentIndex);

  if (pos == -1) {
    // If currentIndex is not in the visible list, just return the first
    return trueIndexes.first;
  }

  // If not last, return next
  if (pos < trueIndexes.length - 1) {
    return trueIndexes[pos + 1];
  }

  // Already at last → stay there
  return trueIndexes.last;
}
