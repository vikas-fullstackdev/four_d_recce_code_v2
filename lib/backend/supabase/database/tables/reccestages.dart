import '../database.dart';

class ReccestagesTable extends SupabaseTable<ReccestagesRow> {
  @override
  String get tableName => 'reccestages';

  @override
  ReccestagesRow createRow(Map<String, dynamic> data) => ReccestagesRow(data);
}

class ReccestagesRow extends SupabaseDataRow {
  ReccestagesRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => ReccestagesTable();

  String get reccestageid => getField<String>('reccestageid')!;
  set reccestageid(String value) => setField<String>('reccestageid', value);

  String? get projectid => getField<String>('projectid');
  set projectid(String? value) => setField<String>('projectid', value);

  int? get stageno => getField<int>('stageno');
  set stageno(int? value) => setField<int>('stageno', value);

  String get title => getField<String>('title')!;
  set title(String value) => setField<String>('title', value);

  DateTime? get planneddate => getField<DateTime>('planneddate');
  set planneddate(DateTime? value) => setField<DateTime>('planneddate', value);

  DateTime? get createdat => getField<DateTime>('createdat');
  set createdat(DateTime? value) => setField<DateTime>('createdat', value);
}
