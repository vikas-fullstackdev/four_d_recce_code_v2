import '../database.dart';

class TemplateTable extends SupabaseTable<TemplateRow> {
  @override
  String get tableName => 'template';

  @override
  TemplateRow createRow(Map<String, dynamic> data) => TemplateRow(data);
}

class TemplateRow extends SupabaseDataRow {
  TemplateRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => TemplateTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String get templatename => getField<String>('templatename')!;
  set templatename(String value) => setField<String>('templatename', value);

  dynamic? get jsonschema => getField<dynamic>('jsonschema');
  set jsonschema(dynamic? value) => setField<dynamic>('jsonschema', value);
}
