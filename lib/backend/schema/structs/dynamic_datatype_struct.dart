// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class DynamicDatatypeStruct extends BaseStruct {
  DynamicDatatypeStruct({
    String? id,
    String? name,
    String? select,
    int? age,
  })  : _id = id,
        _name = name,
        _select = select,
        _age = age;

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;

  bool hasId() => _id != null;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  // "select" field.
  String? _select;
  String get select => _select ?? '';
  set select(String? val) => _select = val;

  bool hasSelect() => _select != null;

  // "age" field.
  int? _age;
  int get age => _age ?? 0;
  set age(int? val) => _age = val;

  void incrementAge(int amount) => age = age + amount;

  bool hasAge() => _age != null;

  static DynamicDatatypeStruct fromMap(Map<String, dynamic> data) =>
      DynamicDatatypeStruct(
        id: data['id'] as String?,
        name: data['name'] as String?,
        select: data['select'] as String?,
        age: castToType<int>(data['age']),
      );

  static DynamicDatatypeStruct? maybeFromMap(dynamic data) => data is Map
      ? DynamicDatatypeStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'name': _name,
        'select': _select,
        'age': _age,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.String,
        ),
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'select': serializeParam(
          _select,
          ParamType.String,
        ),
        'age': serializeParam(
          _age,
          ParamType.int,
        ),
      }.withoutNulls;

  static DynamicDatatypeStruct fromSerializableMap(Map<String, dynamic> data) =>
      DynamicDatatypeStruct(
        id: deserializeParam(
          data['id'],
          ParamType.String,
          false,
        ),
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        select: deserializeParam(
          data['select'],
          ParamType.String,
          false,
        ),
        age: deserializeParam(
          data['age'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'DynamicDatatypeStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is DynamicDatatypeStruct &&
        id == other.id &&
        name == other.name &&
        select == other.select &&
        age == other.age;
  }

  @override
  int get hashCode => const ListEquality().hash([id, name, select, age]);
}

DynamicDatatypeStruct createDynamicDatatypeStruct({
  String? id,
  String? name,
  String? select,
  int? age,
}) =>
    DynamicDatatypeStruct(
      id: id,
      name: name,
      select: select,
      age: age,
    );
