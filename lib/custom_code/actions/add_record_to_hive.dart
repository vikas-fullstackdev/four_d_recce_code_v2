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
// import 'dart:convert';
// import 'package:hive_flutter/hive_flutter.dart';

// Future<int?> addRecordToHive(String boxName, String recordJson) async {
//   try {
//     print("Box exists? ${Hive.isBoxOpen(boxName)}");
//     print("Record incoming: $recordJson");
//     FFAppState().debugMessage = "Incoming: ${recordJson.toString()}";

//     final box = Hive.box(boxName);

//     // Convert JSON string → Map
//     final Map<String, dynamic> record = jsonDecode(recordJson);

//     final wrappedRecord = {
//       "local_id": null,
//       "remote_id": null,
//       "is_synced": false,
//       "updated_at": DateTime.now().toIso8601String(),
//       "data": record,
//     };

//     // Add to Hive and get auto-generated ID
//     final int key = await box.add(wrappedRecord);

//     // Update local_id
//     wrappedRecord["local_id"] = key;
//     await box.put(key, wrappedRecord);

//     return key;
//   } catch (e) {
//     print("Error adding record to $boxName: $e");
//     return null;
//   }
// }
import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';

Future<String> addRecordToHive(String boxName, String recordJson) async {
  try {
    // Debug 1: Raw JSON
    if (recordJson.isEmpty) {
      return "ERROR: recordJson is empty";
    }

    // Debug 2: Try decoding JSON
    Map<String, dynamic> record;
    try {
      record = json.decode(recordJson);
    } catch (e) {
      return "ERROR: JSON decode failed → $e\nINPUT: $recordJson";
    }

    // Debug 3: Open or get box
    Box box;
    try {
      if (Hive.isBoxOpen(boxName)) {
        box = Hive.box(boxName);
      } else {
        box = await Hive.openBox(boxName);
      }
    } catch (e) {
      return "ERROR: Cannot open box ($boxName) → $e";
    }

    // Debug 4: Create record wrapper
    final wrappedRecord = {
      "local_id": null,
      "remote_id": null,
      "is_synced": false,
      "updated_at": DateTime.now().toIso8601String(),
      "data": record,
    };

    // Debug 5: Add to Hive
    int key;
    try {
      key = await box.add(wrappedRecord);
    } catch (e) {
      return "ERROR: box.add failed → $e";
    }

    // Debug 6: Update local_id
    try {
      wrappedRecord["local_id"] = key;
      await box.put(key, wrappedRecord);
    } catch (e) {
      return "ERROR: put local_id failed → $e";
    }

    return "SUCCESS: record saved with key $key";
  } catch (e) {
    return "GENERAL ERROR: $e";
  }
}
