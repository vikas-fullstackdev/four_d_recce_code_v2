import '../database.dart';

class ReccetemplatesTable extends SupabaseTable<ReccetemplatesRow> {
  @override
  String get tableName => 'reccetemplates';

  @override
  ReccetemplatesRow createRow(Map<String, dynamic> data) =>
      ReccetemplatesRow(data);
}

class ReccetemplatesRow extends SupabaseDataRow {
  ReccetemplatesRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => ReccetemplatesTable();

  String get reccetemplateid => getField<String>('reccetemplateid')!;
  set reccetemplateid(String value) =>
      setField<String>('reccetemplateid', value);

  String? get projectid => getField<String>('projectid');
  set projectid(String? value) => setField<String>('projectid', value);

  dynamic get jsonschema => getField<dynamic>('jsonschema')!;
  set jsonschema(dynamic value) => setField<dynamic>('jsonschema', value);

  String get version => getField<String>('version')!;
  set version(String value) => setField<String>('version', value);

  bool? get activeflag => getField<bool>('activeflag');
  set activeflag(bool? value) => setField<bool>('activeflag', value);

  DateTime? get createdat => getField<DateTime>('createdat');
  set createdat(DateTime? value) => setField<DateTime>('createdat', value);
}
