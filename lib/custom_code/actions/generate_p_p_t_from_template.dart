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
import 'package:http/http.dart' as http;

/// Custom Action: Create new Google Slides presentation from template
/// Returns: presentationId of the new presentation
Future<String> generatePPTFromTemplate(
  String templateId,
  String accessToken,
  String newPresentationName,
) async {
  try {
    // 1. Copy the template
    final copyResponse = await http.post(
      Uri.parse('https://www.googleapis.com/drive/v3/files/$templateId/copy'),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'name': newPresentationName,
      }),
    );

    final copyData = jsonDecode(copyResponse.body);

    if (copyData['id'] == null) {
      throw Exception('Failed to copy template, no presentationId returned');
    }

    final presentationId = copyData['id'];

    // 2. (Optional) Add content to slides
    final requests = [
      {
        "replaceAllText": {
          "containsText": {"text": "{{TITLE}}", "matchCase": true},
          "replaceText": "My New Slide Title"
        }
      }
    ];

    final slidesResponse = await http.post(
      Uri.parse(
          'https://slides.googleapis.com/v1/presentations/$presentationId:batchUpdate'),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({"requests": requests}),
    );

    if (slidesResponse.statusCode != 200) {
      throw Exception('Failed to update slides: ${slidesResponse.body}');
    }

    return presentationId;
  } catch (e) {
    throw Exception('Error generating PPT: $e');
  }
}
