import '../database.dart';

class HistoryTable extends SupabaseTable<HistoryRow> {
  @override
  String get tableName => 'history';

  @override
  HistoryRow createRow(Map<String, dynamic> data) => HistoryRow(data);
}

class HistoryRow extends SupabaseDataRow {
  HistoryRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => HistoryTable();

  String get historyId => getField<String>('history_id')!;
  set historyId(String value) => setField<String>('history_id', value);

  String? get recceresponseId => getField<String>('recceresponseId');
  set recceresponseId(String? value) =>
      setField<String>('recceresponseId', value);

  dynamic get formjson => getField<dynamic>('formjson')!;
  set formjson(dynamic value) => setField<dynamic>('formjson', value);

  String? get submittedby => getField<String>('submittedby');
  set submittedby(String? value) => setField<String>('submittedby', value);

  DateTime? get submittedat => getField<DateTime>('submittedat');
  set submittedat(DateTime? value) => setField<DateTime>('submittedat', value);

  DateTime? get createdat => getField<DateTime>('createdat');
  set createdat(DateTime? value) => setField<DateTime>('createdat', value);

  String? get location => getField<String>('location');
  set location(String? value) => setField<String>('location', value);

  int? get stageNo => getField<int>('stageNo');
  set stageNo(int? value) => setField<int>('stageNo', value);
}
