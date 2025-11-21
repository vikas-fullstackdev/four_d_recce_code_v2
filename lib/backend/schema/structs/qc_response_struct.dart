// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class QcResponseStruct extends BaseStruct {
  QcResponseStruct({
    String? qcQue,
    String? qcAns,
    List<String>? qcImg,
  })  : _qcQue = qcQue,
        _qcAns = qcAns,
        _qcImg = qcImg;

  // "qc_que" field.
  String? _qcQue;
  String get qcQue => _qcQue ?? '';
  set qcQue(String? val) => _qcQue = val;

  bool hasQcQue() => _qcQue != null;

  // "qc_ans" field.
  String? _qcAns;
  String get qcAns => _qcAns ?? '';
  set qcAns(String? val) => _qcAns = val;

  bool hasQcAns() => _qcAns != null;

  // "qc_img" field.
  List<String>? _qcImg;
  List<String> get qcImg => _qcImg ?? const [];
  set qcImg(List<String>? val) => _qcImg = val;

  void updateQcImg(Function(List<String>) updateFn) {
    updateFn(_qcImg ??= []);
  }

  bool hasQcImg() => _qcImg != null;

  static QcResponseStruct fromMap(Map<String, dynamic> data) =>
      QcResponseStruct(
        qcQue: data['qc_que'] as String?,
        qcAns: data['qc_ans'] as String?,
        qcImg: getDataList(data['qc_img']),
      );

  static QcResponseStruct? maybeFromMap(dynamic data) => data is Map
      ? QcResponseStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'qc_que': _qcQue,
        'qc_ans': _qcAns,
        'qc_img': _qcImg,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'qc_que': serializeParam(
          _qcQue,
          ParamType.String,
        ),
        'qc_ans': serializeParam(
          _qcAns,
          ParamType.String,
        ),
        'qc_img': serializeParam(
          _qcImg,
          ParamType.String,
          isList: true,
        ),
      }.withoutNulls;

  static QcResponseStruct fromSerializableMap(Map<String, dynamic> data) =>
      QcResponseStruct(
        qcQue: deserializeParam(
          data['qc_que'],
          ParamType.String,
          false,
        ),
        qcAns: deserializeParam(
          data['qc_ans'],
          ParamType.String,
          false,
        ),
        qcImg: deserializeParam<String>(
          data['qc_img'],
          ParamType.String,
          true,
        ),
      );

  @override
  String toString() => 'QcResponseStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is QcResponseStruct &&
        qcQue == other.qcQue &&
        qcAns == other.qcAns &&
        listEquality.equals(qcImg, other.qcImg);
  }

  @override
  int get hashCode => const ListEquality().hash([qcQue, qcAns, qcImg]);
}

QcResponseStruct createQcResponseStruct({
  String? qcQue,
  String? qcAns,
}) =>
    QcResponseStruct(
      qcQue: qcQue,
      qcAns: qcAns,
    );
