import '../database.dart';

class NotificationsTable extends SupabaseTable<NotificationsRow> {
  @override
  String get tableName => 'notifications';

  @override
  NotificationsRow createRow(Map<String, dynamic> data) =>
      NotificationsRow(data);
}

class NotificationsRow extends SupabaseDataRow {
  NotificationsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => NotificationsTable();

  String get notificationid => getField<String>('notificationid')!;
  set notificationid(String value) => setField<String>('notificationid', value);

  String? get recipientid => getField<String>('recipientid');
  set recipientid(String? value) => setField<String>('recipientid', value);

  String get message => getField<String>('message')!;
  set message(String value) => setField<String>('message', value);

  String? get linkurl => getField<String>('linkurl');
  set linkurl(String? value) => setField<String>('linkurl', value);

  bool? get isread => getField<bool>('isread');
  set isread(bool? value) => setField<bool>('isread', value);

  DateTime? get createdat => getField<DateTime>('createdat');
  set createdat(DateTime? value) => setField<DateTime>('createdat', value);
}
