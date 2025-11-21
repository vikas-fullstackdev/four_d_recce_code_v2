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
import 'package:supabase_flutter/supabase_flutter.dart';

/// Output: true if at least one user exists in users table, false otherwise
Future<bool> isDeviceOnline() async {
  final supabase = Supabase.instance.client;

  try {
    // Step 1: Query users table, fetch only 1 record
    final response =
        await supabase.from('users').select().limit(1).maybeSingle();

    // Step 2: If no record → false
    if (response == null) {
      return false;
    }

    // Step 3: If user found → true
    return true;
  } catch (e) {
    // Any error (offline / Supabase unreachable / invalid query)
    return false;
  }
}
