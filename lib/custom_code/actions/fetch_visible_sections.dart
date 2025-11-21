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

Future<List<String>> fetchVisibleSections(String projectID) async {
  final supabase = Supabase.instance.client;

  // Fetch the row from reccetemplate table by projectID
  final response = await supabase
      .from('reccetemplate')
      .select('jsonscheme')
      .eq('projectid', projectID)
      .maybeSingle(); // use maybeSingle instead of execute

  if (response == null) {
    throw Exception('No record found for projectID: $projectID');
  }

  // Get the jsonscheme field
  final Map<String, dynamic> jsonScheme = jsonDecode(response['jsonscheme']);

  // Extract keys with value true
  final visibleKeys = <String>[];
  jsonScheme.forEach((key, value) {
    if (value == true) {
      visibleKeys.add(key);
    }
  });

  return visibleKeys;
}
