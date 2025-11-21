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

/// Fetches assigned_users for a given projectId.
///
/// Returns a List<String>, or an empty list if not found / error.
Future<List<String>> getAssignedUsers(String projectId) async {
  final supabase = Supabase.instance.client;

  try {
    final response = await supabase
        .from('projects')
        .select('assigned_users')
        .eq('projectid', projectId) // ✅ use projectid instead of id
        .maybeSingle();

    if (response == null || response['assigned_users'] == null) {
      return [];
    }

    // Cast dynamic list to List<String>
    return List<String>.from(response['assigned_users']);
  } catch (e, stack) {
    print("❌ Error fetching assigned_users for project $projectId: $e");
    return [];
  }
}
