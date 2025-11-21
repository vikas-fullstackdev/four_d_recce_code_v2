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
import 'package:hive_flutter/hive_flutter.dart';

Future<bool> openHiveBoxes() async {
  try {
    await Hive.openBox('projects');
    await Hive.openBox('site_recce');
    await Hive.openBox('qc');
    await Hive.openBox('final');

    return true;
  } catch (e) {
    print("Error opening Hive boxes: $e");
    return false;
  }
}
