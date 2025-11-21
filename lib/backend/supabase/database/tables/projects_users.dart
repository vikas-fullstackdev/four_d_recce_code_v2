import '../database.dart';

class ProjectsUsersTable extends SupabaseTable<ProjectsUsersRow> {
  @override
  String get tableName => 'projects_users';

  @override
  ProjectsUsersRow createRow(Map<String, dynamic> data) =>
      ProjectsUsersRow(data);
}

class ProjectsUsersRow extends SupabaseDataRow {
  ProjectsUsersRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => ProjectsUsersTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String? get projectId => getField<String>('projectId');
  set projectId(String? value) => setField<String>('projectId', value);

  String? get role => getField<String>('role');
  set role(String? value) => setField<String>('role', value);

  String? get userEmail => getField<String>('userEmail');
  set userEmail(String? value) => setField<String>('userEmail', value);

  String? get userId => getField<String>('userId');
  set userId(String? value) => setField<String>('userId', value);
}
