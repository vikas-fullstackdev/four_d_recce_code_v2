// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class MessageStruct extends BaseStruct {
  MessageStruct({
    String? textMsg,
    String? userId,
    String? userName,
    DateTime? postDateTime,
  })  : _textMsg = textMsg,
        _userId = userId,
        _userName = userName,
        _postDateTime = postDateTime;

  // "textMsg" field.
  String? _textMsg;
  String get textMsg => _textMsg ?? '';
  set textMsg(String? val) => _textMsg = val;

  bool hasTextMsg() => _textMsg != null;

  // "userId" field.
  String? _userId;
  String get userId => _userId ?? '';
  set userId(String? val) => _userId = val;

  bool hasUserId() => _userId != null;

  // "userName" field.
  String? _userName;
  String get userName => _userName ?? '';
  set userName(String? val) => _userName = val;

  bool hasUserName() => _userName != null;

  // "postDateTime" field.
  DateTime? _postDateTime;
  DateTime? get postDateTime => _postDateTime;
  set postDateTime(DateTime? val) => _postDateTime = val;

  bool hasPostDateTime() => _postDateTime != null;

  static MessageStruct fromMap(Map<String, dynamic> data) => MessageStruct(
        textMsg: data['textMsg'] as String?,
        userId: data['userId'] as String?,
        userName: data['userName'] as String?,
        postDateTime: data['postDateTime'] as DateTime?,
      );

  static MessageStruct? maybeFromMap(dynamic data) =>
      data is Map ? MessageStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'textMsg': _textMsg,
        'userId': _userId,
        'userName': _userName,
        'postDateTime': _postDateTime,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'textMsg': serializeParam(
          _textMsg,
          ParamType.String,
        ),
        'userId': serializeParam(
          _userId,
          ParamType.String,
        ),
        'userName': serializeParam(
          _userName,
          ParamType.String,
        ),
        'postDateTime': serializeParam(
          _postDateTime,
          ParamType.DateTime,
        ),
      }.withoutNulls;

  static MessageStruct fromSerializableMap(Map<String, dynamic> data) =>
      MessageStruct(
        textMsg: deserializeParam(
          data['textMsg'],
          ParamType.String,
          false,
        ),
        userId: deserializeParam(
          data['userId'],
          ParamType.String,
          false,
        ),
        userName: deserializeParam(
          data['userName'],
          ParamType.String,
          false,
        ),
        postDateTime: deserializeParam(
          data['postDateTime'],
          ParamType.DateTime,
          false,
        ),
      );

  @override
  String toString() => 'MessageStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is MessageStruct &&
        textMsg == other.textMsg &&
        userId == other.userId &&
        userName == other.userName &&
        postDateTime == other.postDateTime;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([textMsg, userId, userName, postDateTime]);
}

MessageStruct createMessageStruct({
  String? textMsg,
  String? userId,
  String? userName,
  DateTime? postDateTime,
}) =>
    MessageStruct(
      textMsg: textMsg,
      userId: userId,
      userName: userName,
      postDateTime: postDateTime,
    );
