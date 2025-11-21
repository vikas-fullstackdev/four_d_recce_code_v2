import 'dart:convert';
import 'dart:typed_data';
import '../schema/structs/index.dart';

import 'package:flutter/foundation.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

class GetUserRolesCall {
  static Future<ApiCallResponse> call({
    String? userId = 'eq.1508e05c-4a48-48b8-a2d3-3850a67bce0e',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetUserRoles',
      apiUrl:
          'https://wcpvtwboxkammhqpcpow.supabase.co/rest/v1/user_roles_view',
      callType: ApiCallType.GET,
      headers: {
        'Apikey':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndjcHZ0d2JveGthbW1ocXBjcG93Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTIyMzI3OTcsImV4cCI6MjA2NzgwODc5N30.h-UutcMUJsC8pPEHXJxUFOqpF5ot5x1-0_Vj_UuSqyU',
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndjcHZ0d2JveGthbW1ocXBjcG93Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTIyMzI3OTcsImV4cCI6MjA2NzgwODc5N30.h-UutcMUJsC8pPEHXJxUFOqpF5ot5x1-0_Vj_UuSqyU',
        'Range': '0-9',
      },
      params: {
        'user_id': userId,
        'select': "*",
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List<String>? userRoles(dynamic response) => (getJsonField(
        response,
        r'''$[:].roles''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class SendEmailCall {
  static Future<ApiCallResponse> call({
    String? toEmail = 'vikas.rathod@solworxs.com',
    String? subject = 'Test Email from FlutterFlow',
    String? body = 'This is a test email.',
  }) async {
    final ffApiRequestBody = '''
{
  "sender": {
    "name": "4D-Recce",
    "email": "4dimension.app@gmail.com"
  },
  "to": [
    {
      "email": "${escapeStringForJson(toEmail)}"
    }
  ],
  "subject": "${escapeStringForJson(subject)}",
  "htmlContent": "${escapeStringForJson(body)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'SendEmail',
      apiUrl: 'https://api.brevo.com/v3/smtp/email',
      callType: ApiCallType.POST,
      headers: {
        'accept': 'application/json',
        'api-key':
            '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',
        'content-type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _toEncodable(dynamic item) {
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}

String? escapeStringForJson(String? input) {
  if (input == null) {
    return null;
  }
  return input
      .replaceAll('\\', '\\\\')
      .replaceAll('"', '\\"')
      .replaceAll('\n', '\\n')
      .replaceAll('\t', '\\t');
}
