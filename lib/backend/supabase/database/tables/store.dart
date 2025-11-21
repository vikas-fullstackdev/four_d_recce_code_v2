import '../database.dart';

class StoreTable extends SupabaseTable<StoreRow> {
  @override
  String get tableName => 'store';

  @override
  StoreRow createRow(Map<String, dynamic> data) => StoreRow(data);
}

class StoreRow extends SupabaseDataRow {
  StoreRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => StoreTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String? get storeName => getField<String>('store_name');
  set storeName(String? value) => setField<String>('store_name', value);

  dynamic? get location => getField<dynamic>('location');
  set location(dynamic? value) => setField<dynamic>('location', value);

  dynamic? get analysisDetails => getField<dynamic>('analysis_details');
  set analysisDetails(dynamic? value) =>
      setField<dynamic>('analysis_details', value);
}
