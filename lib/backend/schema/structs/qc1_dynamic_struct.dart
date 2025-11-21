// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class Qc1DynamicStruct extends BaseStruct {
  Qc1DynamicStruct({
    String? question,
    String? answerType,
    String? id,
  })  : _question = question,
        _answerType = answerType,
        _id = id;

  // "question" field.
  String? _question;
  String get question => _question ?? '';
  set question(String? val) => _question = val;

  bool hasQuestion() => _question != null;

  // "answerType" field.
  String? _answerType;
  String get answerType => _answerType ?? '';
  set answerType(String? val) => _answerType = val;

  bool hasAnswerType() => _answerType != null;

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;

  bool hasId() => _id != null;

  static Qc1DynamicStruct fromMap(Map<String, dynamic> data) =>
      Qc1DynamicStruct(
        question: data['question'] as String?,
        answerType: data['answerType'] as String?,
        id: data['id'] as String?,
      );

  static Qc1DynamicStruct? maybeFromMap(dynamic data) => data is Map
      ? Qc1DynamicStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'question': _question,
        'answerType': _answerType,
        'id': _id,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'question': serializeParam(
          _question,
          ParamType.String,
        ),
        'answerType': serializeParam(
          _answerType,
          ParamType.String,
        ),
        'id': serializeParam(
          _id,
          ParamType.String,
        ),
      }.withoutNulls;

  static Qc1DynamicStruct fromSerializableMap(Map<String, dynamic> data) =>
      Qc1DynamicStruct(
        question: deserializeParam(
          data['question'],
          ParamType.String,
          false,
        ),
        answerType: deserializeParam(
          data['answerType'],
          ParamType.String,
          false,
        ),
        id: deserializeParam(
          data['id'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'Qc1DynamicStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is Qc1DynamicStruct &&
        question == other.question &&
        answerType == other.answerType &&
        id == other.id;
  }

  @override
  int get hashCode => const ListEquality().hash([question, answerType, id]);
}

Qc1DynamicStruct createQc1DynamicStruct({
  String? question,
  String? answerType,
  String? id,
}) =>
    Qc1DynamicStruct(
      question: question,
      answerType: answerType,
      id: id,
    );
