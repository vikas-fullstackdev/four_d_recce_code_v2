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
import 'package:hive_flutter/hive_flutter.dart';

Future<String> getRecordsFromHive(String boxName) async {
  try {
    final box = Hive.box(boxName);

    // Convert entire box records to a List<Map>
    final List<Map<String, dynamic>> allRecords = [];

    for (var key in box.keys) {
      final value = box.get(key);

      if (value is Map) {
        allRecords.add({
          "local_id": value["local_id"],
          "remote_id": value["remote_id"],
          "is_synced": value["is_synced"],
          "updated_at": value["updated_at"],
          "data": value["data"],
        });
      }
    }

    // Convert list → JSON String (FlutterFlow supported)
    return jsonEncode(allRecords);
  } catch (e) {
    print("Error fetching records from $boxName: $e");

    // Always return valid JSON string (FlutterFlow requirement)
    return "[]";
  }
}
