import '../database.dart';

class ProjectsTable extends SupabaseTable<ProjectsRow> {
  @override
  String get tableName => 'projects';

  @override
  ProjectsRow createRow(Map<String, dynamic> data) => ProjectsRow(data);
}

class ProjectsRow extends SupabaseDataRow {
  ProjectsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => ProjectsTable();

  String get projectid => getField<String>('projectid')!;
  set projectid(String value) => setField<String>('projectid', value);

  String get name => getField<String>('name')!;
  set name(String value) => setField<String>('name', value);

  String get clientname => getField<String>('clientname')!;
  set clientname(String value) => setField<String>('clientname', value);

  String get status => getField<String>('status')!;
  set status(String value) => setField<String>('status', value);

  String? get managerid => getField<String>('managerid');
  set managerid(String? value) => setField<String>('managerid', value);

  DateTime? get createdat => getField<DateTime>('createdat');
  set createdat(DateTime? value) => setField<DateTime>('createdat', value);

  String? get clientPhone => getField<String>('clientPhone');
  set clientPhone(String? value) => setField<String>('clientPhone', value);

  String? get clientContactDetails => getField<String>('clientContactDetails');
  set clientContactDetails(String? value) =>
      setField<String>('clientContactDetails', value);

  String? get addressOfSite => getField<String>('addressOfSite');
  set addressOfSite(String? value) => setField<String>('addressOfSite', value);

  String? get clientLogo => getField<String>('clientLogo');
  set clientLogo(String? value) => setField<String>('clientLogo', value);

  String? get partnerName => getField<String>('partnerName');
  set partnerName(String? value) => setField<String>('partnerName', value);

  String? get partnerPhone => getField<String>('partnerPhone');
  set partnerPhone(String? value) => setField<String>('partnerPhone', value);

  String? get partnerContactDetails =>
      getField<String>('partnerContactDetails');
  set partnerContactDetails(String? value) =>
      setField<String>('partnerContactDetails', value);

  dynamic? get store => getField<dynamic>('store');
  set store(dynamic? value) => setField<dynamic>('store', value);

  dynamic? get storeAnalysis => getField<dynamic>('store_analysis');
  set storeAnalysis(dynamic? value) =>
      setField<dynamic>('store_analysis', value);

  String? get projectCode => getField<String>('projectCode');
  set projectCode(String? value) => setField<String>('projectCode', value);

  dynamic? get annotatedImages => getField<dynamic>('annotated_images');
  set annotatedImages(dynamic? value) =>
      setField<dynamic>('annotated_images', value);

  List<String> get assignedUsers => getListField<String>('assigned_users');
  set assignedUsers(List<String>? value) =>
      setListField<String>('assigned_users', value);

  String? get projectType => getField<String>('project_type');
  set projectType(String? value) => setField<String>('project_type', value);
}
