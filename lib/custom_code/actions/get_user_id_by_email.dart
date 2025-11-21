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

Future<String?> getUserIdByEmail(String? email) async {
  /// MODIFY CODE ONLY BELOW THIS LINE

  if (email == null || email.isEmpty) {
    return null;
  }

  final supabase = SupaFlow.client;

  final response = await supabase
      .from('users')
      .select('userid')
      .eq('email', email)
      .maybeSingle();

  if (response == null) {
    // No user found
    return null;
  }

  return response['userid'] as String?;

  /// MODIFY CODE ONLY ABOVE THIS LINE
}
