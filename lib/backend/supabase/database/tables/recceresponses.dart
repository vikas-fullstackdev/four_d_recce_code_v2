import '../database.dart';

class RecceresponsesTable extends SupabaseTable<RecceresponsesRow> {
  @override
  String get tableName => 'recceresponses';

  @override
  RecceresponsesRow createRow(Map<String, dynamic> data) =>
      RecceresponsesRow(data);
}

class RecceresponsesRow extends SupabaseDataRow {
  RecceresponsesRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => RecceresponsesTable();

  String get recceresponseid => getField<String>('recceresponseid')!;
  set recceresponseid(String value) =>
      setField<String>('recceresponseid', value);

  String? get reccestageid => getField<String>('reccestageid');
  set reccestageid(String? value) => setField<String>('reccestageid', value);

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

  String? get projectid => getField<String>('projectid');
  set projectid(String? value) => setField<String>('projectid', value);

  dynamic? get recceStraightJson => getField<dynamic>('recceStraightJson');
  set recceStraightJson(dynamic? value) =>
      setField<dynamic>('recceStraightJson', value);

  List<String> get assignedUsers => getListField<String>('assigned_users');
  set assignedUsers(List<String>? value) =>
      setListField<String>('assigned_users', value);

  dynamic? get formJsonWithKeyName => getField<dynamic>('formJsonWithKeyName');
  set formJsonWithKeyName(dynamic? value) =>
      setField<dynamic>('formJsonWithKeyName', value);
}
