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

/// Sync all rows from a Hive box to Supabase and delete each row on success.
///
/// Params: - boxName: the Hive box name (String) Returns: JSON string => {
/// "synced": int, "failed": int, "failedKeys": List }
Future<String> syncHiveToSupabase(String boxName) async {
  final result = {"synced": 0, "failed": 0, "failedKeys": <dynamic>[]};

  final box =
      Hive.isBoxOpen(boxName) ? Hive.box(boxName) : await Hive.openBox(boxName);

  if (box.isEmpty) {
    print('ℹ️ No records to sync in box: $boxName');
    return jsonEncode(result);
  }

  final keys = box.keys.toList(growable: false);

  final supabase = SupaFlow.client;
  const tableName = 'recceresponses';

  for (final key in keys) {
    final row = box.get(key);

    if (row is! Map) {
      result["failed"] = (result["failed"] as int) + 1;
      (result["failedKeys"] as List).add(key);
      continue;
    }

    // final now =
    final now = DateTime.now()
        .add(const Duration(hours: 5, minutes: 30))
        .toIso8601String();

    dynamic formData;
    try {
      formData = row['formjson'] is String
          ? jsonDecode(row['formjson'])
          : row['formjson'];
    } catch (_) {
      formData = {}; // fallback to empty JSON object
    }

    final payload = {
      // 'reccestageid': '0bee28f5-b3cd-4d34-aea9-c64a1dfc291d',
      'reccestageid': row['reccestageid'],
      // 'formjson': row['formjson'],
      'formjson': formData,
      'submittedby': row['submittedby'],
      'submittedat': now,
      'createdat': now,
      'location': 'Bengaluru',
      'stageNo': 2,
      'projectid': row['projectid'],
    };

    try {
      final inserted = await supabase.from(tableName).insert(payload).select();

      if (inserted.isNotEmpty) {
        await box.delete(key);
        result["synced"] = (result["synced"] as int) + 1;
      } else {
        result["failed"] = (result["failed"] as int) + 1;
        (result["failedKeys"] as List).add(key);
      }
    } catch (e) {
      result["failed"] = (result["failed"] as int) + 1;
      (result["failedKeys"] as List).add(key);
    }
  }

  print('📊 Sync summary => $result');
  return jsonEncode(result); // ✅ Return JSON string
}
