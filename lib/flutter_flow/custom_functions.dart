import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/auth/supabase_auth/auth_util.dart';

dynamic newCustomFunctionForJson(dynamic flatJson) {
  print('Flat JSON received: $flatJson');

  Map<String, dynamic> defaultJson = {
    "mep": false,
    "inte": false,
    "int_a": false,
    "int_b": false,
    "int_c": false,
    "int_d": false,
    "int_e": false,
    "int_f": false,
    "int_g": false,
    "mep_a": false,
    "mep_b": false,
    "mep_c": false,
    "mep_d": false,
    "mep_e": false,
    "mep_f": false,
    "mep_g": false,
    "int_a1": false,
    "int_a2": false,
    "int_a3": false,
    "int_a4": false,
    "int_a5": false,
    "int_a6": false,
    "int_a7": false,
    "int_b1": false,
    "int_b2": false,
    "int_b3": false,
    "int_b4": false,
    "int_b5": false,
    "int_c1": false,
    "int_c2": false,
    "int_c3": false,
    "int_c4": false,
    "int_d1": false,
    "int_d2": false,
    "int_d3": false,
    "int_e1": false,
    "int_e2": false,
    "int_e3": false,
    "int_e4": false,
    "int_e5": false,
    "int_e6": false,
    "int_e7": false,
    "int_e8": false,
    "int_e9": false,
    "int_e10": false,
    "int_e11": false,
    "int_e12": false,
    "int_e13": false,
    "int_e14": false,
    "int_f1": false,
    "int_f2": false,
    "int_f3": false,
    "int_f4": false,
    "int_f5": false,
    "int_g1": false,
    "int_g2": false,
    "int_g3": false,
    "int_g4": false,
    "int_g5": false,
    "mep_a1": false,
    "mep_a2": false,
    "mep_b_1": false,
    "mep_b_2": false,
    "mep_b_3": false,
    "mep_b_4": false,
    "mep_b_5": false,
    "mep_b_6": false,
    "mep_b_7": false,
    "mep_c_1": false,
    "mep_c_2": false,
    "mep_c_3": false,
    "mep_c_4": false,
    "mep_c_5": false,
    "mep_d_a": false,
    "mep_d_b": false,
    "mep_d_c": false,
    "mep_e_a": false,
    "mep_e_b": false,
    "mep_e_c": false,
    "mep_e_d": false,
    "mep_e_e": false,
    "mep_e_f": false,
    "mep_e_g": false,
    "mep_e_h": false,
    "mep_e_i": false,
    "mep_e_j": false,
    "mep_e_k": false,
    "mep_e_l": false,
    "mep_e_m": false,
    "mep_e_n": false,
    "mep_e_o": false,
    "mep_e_p": false,
    "mep_e_q": false,
    "mep_e_r": false,
    "mep_f_1": false,
    "mep_f_2": false,
    "mep_f_3": false,
    "mep_f_4": false,
    "mep_f_5": false,
    "mep_f_6": false,
    "mep_f_7": false,
    "mep_f_8": false,
    "mep_f_9": false,
    "mep_f_10": false,
    "mep_f_11": false,
    "mep_f_12": false,
    "mep_f_13": false,
    "mep_f_14": false,
    "mep_f_15": false,
    "mep_f_16": false,
    "mep_g_a": false,
    "mep_g_b": false,
    "mep_g_c": false,
    "mep_b_1_a": false,
    "mep_b_1_b": false,
    "mep_b_1_c": false,
    "mep_b_1_d": false,
    "mep_b_1_e": false,
    "mep_b_1_f": false,
    "mep_b_1_g": false,
    "mep_b_2_a": false,
    "mep_b_2_b": false,
    "mep_b_2_c": false,
    "mep_b_2_d": false,
    "mep_b_2_e": false,
    "mep_b_2_f": false,
    "mep_b_5_a": false,
    "mep_b_5_b": false,
    "mep_b_7_a": false,
    "mep_b_7_b": false,
    "mep_c_1_a": false,
    "mep_c_1_b": false,
    "mep_c_1_c": false,
    "mep_c_1_d": false,
    "mep_c_1_e": false,
    "mep_c_1_f": false,
    "mep_c_1_g": false,
    "mep_c_1_h": false,
    "mep_c_1_i": false,
    "mep_c_2_a": false,
    "mep_c_2_b": false,
    "mep_c_2_c": false,
    "mep_c_2_d": false,
    "mep_c_2_e": false,
    "mep_c_2_f": false,
    "mep_c_2_g": false,
    "mep_c_3_a": false,
    "mep_c_3_b": false,
    "mep_c_3_c": false,
    "mep_c_3_d": false,
    "mep_c_3_e": false,
    "mep_c_3_f": false,
    "mep_c_3_g": false,
    "mep_c_3_h": false,
    "mep_c_3_i": false,
    "mep_c_3_j": false,
    "mep_c_3_k": false,
    "mep_c_3_l": false,
    "mep_c_4_a": false,
    "mep_c_4_b": false,
    "mep_c_4_c": false,
    "mep_c_4_d": false,
    "mep_c_4_e": false,
    "mep_c_4_f": false,
    "mep_c_5_a": false,
    "mep_c_5_b": false,
    "mep_c_5_c": false,
    "mep_c_5_d": false,
    "mep_c_5_e": false,
    "mep_c_5_f": false,
    "mep_c_5_g": false,
    "mep_c_5_h": false,
    "mep_c_5_i": false,
    "mep_c_5_j": false,
    "mep_c_5_k": false,
    "mep_f_1_a": false,
    "mep_f_1_b": false,
    "mep_f_1_c": false,
    "mep_f_1_d": false,
    "mep_f_1_e": false,
    "mep_f_1_f": false,
    "mep_f_1_g": false,
    "mep_f_2_a": false,
    "mep_f_2_b": false,
    "mep_f_2_c": false,
    "mep_f_4_a": false,
    "mep_f_4_b": false,
    "mep_f_4_c": false,
    "mep_f_5_a": false,
    "mep_f_5_b": false
  };

  // Recursive function to apply values from flatJson
  dynamic updateValues(dynamic node, List<String> path) {
    if (node is Map<String, dynamic>) {
      return node.map((key, value) {
        return MapEntry(key, updateValues(value, [...path, key]));
      });
    } else {
      final key = path.join("_");
      return flatJson.containsKey(key) ? flatJson[key] : false;
    }
  }

  return updateValues(defaultJson, []);
}

String? getTaskName(String text) {
  if (text.isEmpty) {
    return '';
  }

  // Check if '#' exists in the string
  if (text.contains('#')) {
    final parts = text.split('#');
    return parts.isNotEmpty ? parts[0] : text;
  }

  // If '#' not found, return the original text
  return text;
}

bool? isTaskDone(String? text) {
  if (text!.isEmpty) {
    return false;
  }
  return text.trim().endsWith('#done');
}

String? getProjectCode() {
  final now = DateTime.now();

  // Format date as YYMMDD
  final yy = now.year.toString().substring(2, 4);
  final mm = now.month.toString().padLeft(2, '0');
  final dd = now.day.toString().padLeft(2, '0');
  final datePart = '$yy$mm$dd';

  // Generate 5 random digits
  final random = math.Random().nextInt(10000).toString().padLeft(4, '0');

  // Combine
  return datePart + random;
}

int? getHighestPriorityRole(List<int>? roleIds) {
  if (roleIds == null || roleIds.isEmpty) return null;

  // Define priority order
  const priorityOrder = [1, 2, 3, 4, 5, 6, 7];

  // Find the first roleId that matches priority
  for (final role in priorityOrder) {
    if (roleIds.contains(role)) {
      return role;
    }
  }

  // If no match found
  return null;
}
