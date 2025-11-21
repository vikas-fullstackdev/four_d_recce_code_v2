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

import 'dart:convert';

Future<dynamic> flattenJsonChildrenOnly(dynamic nestedJsonInput) async {
  try {
    // Ensure input is Map
    final Map<String, dynamic> nestedJson = nestedJsonInput is String
        ? json.decode(nestedJsonInput)
        : Map<String, dynamic>.from(nestedJsonInput);

    final Map<String, dynamic> result = {};

    void recurse(Map<String, dynamic> obj) {
      obj.forEach((key, value) {
        if (value is Map<String, dynamic>) {
          recurse(value); // go deeper
        } else {
          // only keep non-empty values
          if (value != null && value.toString().trim().isNotEmpty) {
            result[key] = value;
          }
        }
      });
    }

    recurse(nestedJson);

    // Return flattened JSON object (not string)
    return result;
  } catch (e) {
    return {"error": "Invalid JSON - ${e.toString()}"};
  }
}
