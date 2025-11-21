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
import 'package:supabase_flutter/supabase_flutter.dart';

/// Input: projectID Output: List<String> of pages to show
Future<List<String>> fetchAndFilterPages(String projectID) async {
  final supabase = Supabase.instance.client;

  // Step 1: Fetch jsonschema from reccetemplates table
  // final response = await supabase
  //     .from('reccetemplates')
  //     .select('jsonschema')
  //     .eq('projectid', projectID)
  //     .maybeSingle();

  final response = await supabase
      .from('reccetemplates')
      .select('jsonschema')
      .eq('projectid', projectID)
      .order('createdat', ascending: false) // Sort by newest first
      .limit(1) // Only fetch the latest one
      .maybeSingle();

  if (response == null || response['jsonschema'] == null) {
    return [];
  }

  // Step 2: Parse JSON
  Map<String, dynamic> jsonScheme;
  if (response['jsonschema'] is String) {
    jsonScheme = jsonDecode(response['jsonschema']);
  } else {
    jsonScheme = Map<String, dynamic>.from(response['jsonschema']);
  }

  // Step 3: Define all page keys exactly as in your JSON
  List<String> pageKeys = [
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

  // Step 4: Filter pages based on value (1 or true)
  List<String> filteredPages = [];
  for (var key in pageKeys) {
    var val = jsonScheme[key];
    if (val != null && (val == 1 || val == true)) {
      filteredPages.add(key); // Add the page name
    }
  }

  return filteredPages;
}
