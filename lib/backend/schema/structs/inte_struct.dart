// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class InteStruct extends BaseStruct {
  InteStruct({
    List<IntAStruct>? intA,
  }) : _intA = intA;

  // "int_a" field.
  List<IntAStruct>? _intA;
  List<IntAStruct> get intA => _intA ?? const [];
  set intA(List<IntAStruct>? val) => _intA = val;

  void updateIntA(Function(List<IntAStruct>) updateFn) {
    updateFn(_intA ??= []);
  }

  bool hasIntA() => _intA != null;

  static InteStruct fromMap(Map<String, dynamic> data) => InteStruct(
        intA: getStructList(
          data['int_a'],
          IntAStruct.fromMap,
        ),
      );

  static InteStruct? maybeFromMap(dynamic data) =>
      data is Map ? InteStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'int_a': _intA?.map((e) => e.toMap()).toList(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'int_a': serializeParam(
          _intA,
          ParamType.DataStruct,
          isList: true,
        ),
      }.withoutNulls;

  static InteStruct fromSerializableMap(Map<String, dynamic> data) =>
      InteStruct(
        intA: deserializeStructParam<IntAStruct>(
          data['int_a'],
          ParamType.DataStruct,
          true,
          structBuilder: IntAStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'InteStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is InteStruct && listEquality.equals(intA, other.intA);
  }

  @override
  int get hashCode => const ListEquality().hash([intA]);
}

InteStruct createInteStruct() => InteStruct();
