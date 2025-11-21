import '../database.dart';

class UsersTable extends SupabaseTable<UsersRow> {
  @override
  String get tableName => 'users';

  @override
  UsersRow createRow(Map<String, dynamic> data) => UsersRow(data);
}

class UsersRow extends SupabaseDataRow {
  UsersRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => UsersTable();

  String get userid => getField<String>('userid')!;
  set userid(String value) => setField<String>('userid', value);

  String get name => getField<String>('name')!;
  set name(String value) => setField<String>('name', value);

  String get email => getField<String>('email')!;
  set email(String value) => setField<String>('email', value);

  String get role => getField<String>('role')!;
  set role(String value) => setField<String>('role', value);

  String get password => getField<String>('password')!;
  set password(String value) => setField<String>('password', value);

  DateTime? get createdat => getField<DateTime>('createdat');
  set createdat(DateTime? value) => setField<DateTime>('createdat', value);

  String? get image => getField<String>('image');
  set image(String? value) => setField<String>('image', value);

  String? get mobileNumber => getField<String>('mobileNumber');
  set mobileNumber(String? value) => setField<String>('mobileNumber', value);

  String? get fcmToken => getField<String>('fcm_token');
  set fcmToken(String? value) => setField<String>('fcm_token', value);

  String? get playerId => getField<String>('player_id');
  set playerId(String? value) => setField<String>('player_id', value);
}
