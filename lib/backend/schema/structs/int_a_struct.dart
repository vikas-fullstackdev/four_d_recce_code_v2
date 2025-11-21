// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class IntAStruct extends BaseStruct {
  IntAStruct({
    bool? intA1,
    bool? intA2,
    bool? intA3,
    bool? intA4,
    bool? intA5,
    bool? intA6,
    bool? intA7,
  })  : _intA1 = intA1,
        _intA2 = intA2,
        _intA3 = intA3,
        _intA4 = intA4,
        _intA5 = intA5,
        _intA6 = intA6,
        _intA7 = intA7;

  // "int_a1" field.
  bool? _intA1;
  bool get intA1 => _intA1 ?? false;
  set intA1(bool? val) => _intA1 = val;

  bool hasIntA1() => _intA1 != null;

  // "int_a2" field.
  bool? _intA2;
  bool get intA2 => _intA2 ?? false;
  set intA2(bool? val) => _intA2 = val;

  bool hasIntA2() => _intA2 != null;

  // "int_a3" field.
  bool? _intA3;
  bool get intA3 => _intA3 ?? false;
  set intA3(bool? val) => _intA3 = val;

  bool hasIntA3() => _intA3 != null;

  // "int_a4" field.
  bool? _intA4;
  bool get intA4 => _intA4 ?? false;
  set intA4(bool? val) => _intA4 = val;

  bool hasIntA4() => _intA4 != null;

  // "int_a5" field.
  bool? _intA5;
  bool get intA5 => _intA5 ?? false;
  set intA5(bool? val) => _intA5 = val;

  bool hasIntA5() => _intA5 != null;

  // "int_a6" field.
  bool? _intA6;
  bool get intA6 => _intA6 ?? false;
  set intA6(bool? val) => _intA6 = val;

  bool hasIntA6() => _intA6 != null;

  // "int_a7" field.
  bool? _intA7;
  bool get intA7 => _intA7 ?? false;
  set intA7(bool? val) => _intA7 = val;

  bool hasIntA7() => _intA7 != null;

  static IntAStruct fromMap(Map<String, dynamic> data) => IntAStruct(
        intA1: data['int_a1'] as bool?,
        intA2: data['int_a2'] as bool?,
        intA3: data['int_a3'] as bool?,
        intA4: data['int_a4'] as bool?,
        intA5: data['int_a5'] as bool?,
        intA6: data['int_a6'] as bool?,
        intA7: data['int_a7'] as bool?,
      );

  static IntAStruct? maybeFromMap(dynamic data) =>
      data is Map ? IntAStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'int_a1': _intA1,
        'int_a2': _intA2,
        'int_a3': _intA3,
        'int_a4': _intA4,
        'int_a5': _intA5,
        'int_a6': _intA6,
        'int_a7': _intA7,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'int_a1': serializeParam(
          _intA1,
          ParamType.bool,
        ),
        'int_a2': serializeParam(
          _intA2,
          ParamType.bool,
        ),
        'int_a3': serializeParam(
          _intA3,
          ParamType.bool,
        ),
        'int_a4': serializeParam(
          _intA4,
          ParamType.bool,
        ),
        'int_a5': serializeParam(
          _intA5,
          ParamType.bool,
        ),
        'int_a6': serializeParam(
          _intA6,
          ParamType.bool,
        ),
        'int_a7': serializeParam(
          _intA7,
          ParamType.bool,
        ),
      }.withoutNulls;

  static IntAStruct fromSerializableMap(Map<String, dynamic> data) =>
      IntAStruct(
        intA1: deserializeParam(
          data['int_a1'],
          ParamType.bool,
          false,
        ),
        intA2: deserializeParam(
          data['int_a2'],
          ParamType.bool,
          false,
        ),
        intA3: deserializeParam(
          data['int_a3'],
          ParamType.bool,
          false,
        ),
        intA4: deserializeParam(
          data['int_a4'],
          ParamType.bool,
          false,
        ),
        intA5: deserializeParam(
          data['int_a5'],
          ParamType.bool,
          false,
        ),
        intA6: deserializeParam(
          data['int_a6'],
          ParamType.bool,
          false,
        ),
        intA7: deserializeParam(
          data['int_a7'],
          ParamType.bool,
          false,
        ),
      );

  @override
  String toString() => 'IntAStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is IntAStruct &&
        intA1 == other.intA1 &&
        intA2 == other.intA2 &&
        intA3 == other.intA3 &&
        intA4 == other.intA4 &&
        intA5 == other.intA5 &&
        intA6 == other.intA6 &&
        intA7 == other.intA7;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([intA1, intA2, intA3, intA4, intA5, intA6, intA7]);
}

IntAStruct createIntAStruct({
  bool? intA1,
  bool? intA2,
  bool? intA3,
  bool? intA4,
  bool? intA5,
  bool? intA6,
  bool? intA7,
}) =>
    IntAStruct(
      intA1: intA1,
      intA2: intA2,
      intA3: intA3,
      intA4: intA4,
      intA5: intA5,
      intA6: intA6,
      intA7: intA7,
    );
