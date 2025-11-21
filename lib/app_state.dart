import 'package:flutter/material.dart';
import 'flutter_flow/request_manager.dart';
import '/backend/schema/structs/index.dart';
import '/backend/api_requests/api_manager.dart';
import 'backend/supabase/supabase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _dynamicAppState = prefs
              .getStringList('ff_dynamicAppState')
              ?.map((x) {
                try {
                  return DynamicDatatypeStruct.fromSerializableMap(
                      jsonDecode(x));
                } catch (e) {
                  print("Can't decode persisted data type. Error: $e.");
                  return null;
                }
              })
              .withoutNulls
              .toList() ??
          _dynamicAppState;
    });
    _safeInit(() {
      _qc1 = prefs
              .getStringList('ff_qc1')
              ?.map((x) {
                try {
                  return Qc1DynamicStruct.fromSerializableMap(jsonDecode(x));
                } catch (e) {
                  print("Can't decode persisted data type. Error: $e.");
                  return null;
                }
              })
              .withoutNulls
              .toList() ??
          _qc1;
    });
    _safeInit(() {
      _qcr = prefs
              .getStringList('ff_qcr')
              ?.map((x) {
                try {
                  return QcResponseStruct.fromSerializableMap(jsonDecode(x));
                } catch (e) {
                  print("Can't decode persisted data type. Error: $e.");
                  return null;
                }
              })
              .withoutNulls
              .toList() ??
          _qcr;
    });
    _safeInit(() {
      _editqc = prefs
              .getStringList('ff_editqc')
              ?.map((x) {
                try {
                  return QcResponseStruct.fromSerializableMap(jsonDecode(x));
                } catch (e) {
                  print("Can't decode persisted data type. Error: $e.");
                  return null;
                }
              })
              .withoutNulls
              .toList() ??
          _editqc;
    });
    _safeInit(() {
      _taskAppState = prefs
              .getStringList('ff_taskAppState')
              ?.map((x) {
                try {
                  return TaskStruct.fromSerializableMap(jsonDecode(x));
                } catch (e) {
                  print("Can't decode persisted data type. Error: $e.");
                  return null;
                }
              })
              .withoutNulls
              .toList() ??
          _taskAppState;
    });
    _safeInit(() {
      _deviceNet = prefs.getBool('ff_deviceNet') ?? _deviceNet;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  List<String> _userRoles = [];
  List<String> get userRoles => _userRoles;
  set userRoles(List<String> value) {
    _userRoles = value;
  }

  void addToUserRoles(String value) {
    userRoles.add(value);
  }

  void removeFromUserRoles(String value) {
    userRoles.remove(value);
  }

  void removeAtIndexFromUserRoles(int index) {
    userRoles.removeAt(index);
  }

  void updateUserRolesAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    userRoles[index] = updateFn(_userRoles[index]);
  }

  void insertAtIndexInUserRoles(int index, String value) {
    userRoles.insert(index, value);
  }

  List<DynamicDatatypeStruct> _dynamicAppState = [];
  List<DynamicDatatypeStruct> get dynamicAppState => _dynamicAppState;
  set dynamicAppState(List<DynamicDatatypeStruct> value) {
    _dynamicAppState = value;
    prefs.setStringList(
        'ff_dynamicAppState', value.map((x) => x.serialize()).toList());
  }

  void addToDynamicAppState(DynamicDatatypeStruct value) {
    dynamicAppState.add(value);
    prefs.setStringList('ff_dynamicAppState',
        _dynamicAppState.map((x) => x.serialize()).toList());
  }

  void removeFromDynamicAppState(DynamicDatatypeStruct value) {
    dynamicAppState.remove(value);
    prefs.setStringList('ff_dynamicAppState',
        _dynamicAppState.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromDynamicAppState(int index) {
    dynamicAppState.removeAt(index);
    prefs.setStringList('ff_dynamicAppState',
        _dynamicAppState.map((x) => x.serialize()).toList());
  }

  void updateDynamicAppStateAtIndex(
    int index,
    DynamicDatatypeStruct Function(DynamicDatatypeStruct) updateFn,
  ) {
    dynamicAppState[index] = updateFn(_dynamicAppState[index]);
    prefs.setStringList('ff_dynamicAppState',
        _dynamicAppState.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInDynamicAppState(int index, DynamicDatatypeStruct value) {
    dynamicAppState.insert(index, value);
    prefs.setStringList('ff_dynamicAppState',
        _dynamicAppState.map((x) => x.serialize()).toList());
  }

  List<Qc1DynamicStruct> _qc1 = [];
  List<Qc1DynamicStruct> get qc1 => _qc1;
  set qc1(List<Qc1DynamicStruct> value) {
    _qc1 = value;
    prefs.setStringList('ff_qc1', value.map((x) => x.serialize()).toList());
  }

  void addToQc1(Qc1DynamicStruct value) {
    qc1.add(value);
    prefs.setStringList('ff_qc1', _qc1.map((x) => x.serialize()).toList());
  }

  void removeFromQc1(Qc1DynamicStruct value) {
    qc1.remove(value);
    prefs.setStringList('ff_qc1', _qc1.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromQc1(int index) {
    qc1.removeAt(index);
    prefs.setStringList('ff_qc1', _qc1.map((x) => x.serialize()).toList());
  }

  void updateQc1AtIndex(
    int index,
    Qc1DynamicStruct Function(Qc1DynamicStruct) updateFn,
  ) {
    qc1[index] = updateFn(_qc1[index]);
    prefs.setStringList('ff_qc1', _qc1.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInQc1(int index, Qc1DynamicStruct value) {
    qc1.insert(index, value);
    prefs.setStringList('ff_qc1', _qc1.map((x) => x.serialize()).toList());
  }

  List<QcResponseStruct> _qcr = [];
  List<QcResponseStruct> get qcr => _qcr;
  set qcr(List<QcResponseStruct> value) {
    _qcr = value;
    prefs.setStringList('ff_qcr', value.map((x) => x.serialize()).toList());
  }

  void addToQcr(QcResponseStruct value) {
    qcr.add(value);
    prefs.setStringList('ff_qcr', _qcr.map((x) => x.serialize()).toList());
  }

  void removeFromQcr(QcResponseStruct value) {
    qcr.remove(value);
    prefs.setStringList('ff_qcr', _qcr.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromQcr(int index) {
    qcr.removeAt(index);
    prefs.setStringList('ff_qcr', _qcr.map((x) => x.serialize()).toList());
  }

  void updateQcrAtIndex(
    int index,
    QcResponseStruct Function(QcResponseStruct) updateFn,
  ) {
    qcr[index] = updateFn(_qcr[index]);
    prefs.setStringList('ff_qcr', _qcr.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInQcr(int index, QcResponseStruct value) {
    qcr.insert(index, value);
    prefs.setStringList('ff_qcr', _qcr.map((x) => x.serialize()).toList());
  }

  List<QcResponseStruct> _editqc = [];
  List<QcResponseStruct> get editqc => _editqc;
  set editqc(List<QcResponseStruct> value) {
    _editqc = value;
    prefs.setStringList('ff_editqc', value.map((x) => x.serialize()).toList());
  }

  void addToEditqc(QcResponseStruct value) {
    editqc.add(value);
    prefs.setStringList(
        'ff_editqc', _editqc.map((x) => x.serialize()).toList());
  }

  void removeFromEditqc(QcResponseStruct value) {
    editqc.remove(value);
    prefs.setStringList(
        'ff_editqc', _editqc.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromEditqc(int index) {
    editqc.removeAt(index);
    prefs.setStringList(
        'ff_editqc', _editqc.map((x) => x.serialize()).toList());
  }

  void updateEditqcAtIndex(
    int index,
    QcResponseStruct Function(QcResponseStruct) updateFn,
  ) {
    editqc[index] = updateFn(_editqc[index]);
    prefs.setStringList(
        'ff_editqc', _editqc.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInEditqc(int index, QcResponseStruct value) {
    editqc.insert(index, value);
    prefs.setStringList(
        'ff_editqc', _editqc.map((x) => x.serialize()).toList());
  }

  List<MessageStruct> _messageAppState = [];
  List<MessageStruct> get messageAppState => _messageAppState;
  set messageAppState(List<MessageStruct> value) {
    _messageAppState = value;
  }

  void addToMessageAppState(MessageStruct value) {
    messageAppState.add(value);
  }

  void removeFromMessageAppState(MessageStruct value) {
    messageAppState.remove(value);
  }

  void removeAtIndexFromMessageAppState(int index) {
    messageAppState.removeAt(index);
  }

  void updateMessageAppStateAtIndex(
    int index,
    MessageStruct Function(MessageStruct) updateFn,
  ) {
    messageAppState[index] = updateFn(_messageAppState[index]);
  }

  void insertAtIndexInMessageAppState(int index, MessageStruct value) {
    messageAppState.insert(index, value);
  }

  List<TaskStruct> _taskAppState = [];
  List<TaskStruct> get taskAppState => _taskAppState;
  set taskAppState(List<TaskStruct> value) {
    _taskAppState = value;
    prefs.setStringList(
        'ff_taskAppState', value.map((x) => x.serialize()).toList());
  }

  void addToTaskAppState(TaskStruct value) {
    taskAppState.add(value);
    prefs.setStringList(
        'ff_taskAppState', _taskAppState.map((x) => x.serialize()).toList());
  }

  void removeFromTaskAppState(TaskStruct value) {
    taskAppState.remove(value);
    prefs.setStringList(
        'ff_taskAppState', _taskAppState.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromTaskAppState(int index) {
    taskAppState.removeAt(index);
    prefs.setStringList(
        'ff_taskAppState', _taskAppState.map((x) => x.serialize()).toList());
  }

  void updateTaskAppStateAtIndex(
    int index,
    TaskStruct Function(TaskStruct) updateFn,
  ) {
    taskAppState[index] = updateFn(_taskAppState[index]);
    prefs.setStringList(
        'ff_taskAppState', _taskAppState.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInTaskAppState(int index, TaskStruct value) {
    taskAppState.insert(index, value);
    prefs.setStringList(
        'ff_taskAppState', _taskAppState.map((x) => x.serialize()).toList());
  }

  bool _deviceNet = false;
  bool get deviceNet => _deviceNet;
  set deviceNet(bool value) {
    _deviceNet = value;
    prefs.setBool('ff_deviceNet', value);
  }

  int _tickCounter = 0;
  int get tickCounter => _tickCounter;
  set tickCounter(int value) {
    _tickCounter = value;
  }

  String _debugMessage = '';
  String get debugMessage => _debugMessage;
  set debugMessage(String value) {
    _debugMessage = value;
  }

  final _projectListManager = FutureRequestManager<List<ProjectsRow>>();
  Future<List<ProjectsRow>> projectList({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<ProjectsRow>> Function() requestFn,
  }) =>
      _projectListManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearProjectListCache() => _projectListManager.clear();
  void clearProjectListCacheKey(String? uniqueKey) =>
      _projectListManager.clearRequest(uniqueKey);

  final _userIdInTheHomePageManager =
      FutureRequestManager<List<UserRolesRow>>();
  Future<List<UserRolesRow>> userIdInTheHomePage({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<UserRolesRow>> Function() requestFn,
  }) =>
      _userIdInTheHomePageManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearUserIdInTheHomePageCache() => _userIdInTheHomePageManager.clear();
  void clearUserIdInTheHomePageCacheKey(String? uniqueKey) =>
      _userIdInTheHomePageManager.clearRequest(uniqueKey);

  final _listContainerUserIdManager =
      FutureRequestManager<List<UserRolesRow>>();
  Future<List<UserRolesRow>> listContainerUserId({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<UserRolesRow>> Function() requestFn,
  }) =>
      _listContainerUserIdManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearListContainerUserIdCache() => _listContainerUserIdManager.clear();
  void clearListContainerUserIdCacheKey(String? uniqueKey) =>
      _listContainerUserIdManager.clearRequest(uniqueKey);

  final _userProfileUserIdManager = FutureRequestManager<List<UsersRow>>();
  Future<List<UsersRow>> userProfileUserId({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<UsersRow>> Function() requestFn,
  }) =>
      _userProfileUserIdManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearUserProfileUserIdCache() => _userProfileUserIdManager.clear();
  void clearUserProfileUserIdCacheKey(String? uniqueKey) =>
      _userProfileUserIdManager.clearRequest(uniqueKey);

  final _userIdUserRoleManagmentManager =
      FutureRequestManager<List<UserRolesRow>>();
  Future<List<UserRolesRow>> userIdUserRoleManagment({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<UserRolesRow>> Function() requestFn,
  }) =>
      _userIdUserRoleManagmentManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearUserIdUserRoleManagmentCache() =>
      _userIdUserRoleManagmentManager.clear();
  void clearUserIdUserRoleManagmentCacheKey(String? uniqueKey) =>
      _userIdUserRoleManagmentManager.clearRequest(uniqueKey);

  final _userIdForProjectSettingsManager =
      FutureRequestManager<List<UserRolesRow>>();
  Future<List<UserRolesRow>> userIdForProjectSettings({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<UserRolesRow>> Function() requestFn,
  }) =>
      _userIdForProjectSettingsManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearUserIdForProjectSettingsCache() =>
      _userIdForProjectSettingsManager.clear();
  void clearUserIdForProjectSettingsCacheKey(String? uniqueKey) =>
      _userIdForProjectSettingsManager.clearRequest(uniqueKey);

  final _projectDetailScreenColumnManager =
      FutureRequestManager<List<ProjectsRow>>();
  Future<List<ProjectsRow>> projectDetailScreenColumn({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<ProjectsRow>> Function() requestFn,
  }) =>
      _projectDetailScreenColumnManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearProjectDetailScreenColumnCache() =>
      _projectDetailScreenColumnManager.clear();
  void clearProjectDetailScreenColumnCacheKey(String? uniqueKey) =>
      _projectDetailScreenColumnManager.clearRequest(uniqueKey);

  final _projectAssignedUserManager = FutureRequestManager<List<UsersRow>>();
  Future<List<UsersRow>> projectAssignedUser({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<UsersRow>> Function() requestFn,
  }) =>
      _projectAssignedUserManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearProjectAssignedUserCache() => _projectAssignedUserManager.clear();
  void clearProjectAssignedUserCacheKey(String? uniqueKey) =>
      _projectAssignedUserManager.clearRequest(uniqueKey);

  final _userSectionAndRecceSectionBttonInProjectDetailManager =
      FutureRequestManager<List<UserRolesRow>>();
  Future<List<UserRolesRow>> userSectionAndRecceSectionBttonInProjectDetail({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<UserRolesRow>> Function() requestFn,
  }) =>
      _userSectionAndRecceSectionBttonInProjectDetailManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearUserSectionAndRecceSectionBttonInProjectDetailCache() =>
      _userSectionAndRecceSectionBttonInProjectDetailManager.clear();
  void clearUserSectionAndRecceSectionBttonInProjectDetailCacheKey(
          String? uniqueKey) =>
      _userSectionAndRecceSectionBttonInProjectDetailManager
          .clearRequest(uniqueKey);

  final _projectIdInTheAddUserContainerManager =
      FutureRequestManager<List<ReccestagesRow>>();
  Future<List<ReccestagesRow>> projectIdInTheAddUserContainer({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<ReccestagesRow>> Function() requestFn,
  }) =>
      _projectIdInTheAddUserContainerManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearProjectIdInTheAddUserContainerCache() =>
      _projectIdInTheAddUserContainerManager.clear();
  void clearProjectIdInTheAddUserContainerCacheKey(String? uniqueKey) =>
      _projectIdInTheAddUserContainerManager.clearRequest(uniqueKey);

  final _projectIdInTheRemoveUserContainerManager =
      FutureRequestManager<List<ReccestagesRow>>();
  Future<List<ReccestagesRow>> projectIdInTheRemoveUserContainer({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<ReccestagesRow>> Function() requestFn,
  }) =>
      _projectIdInTheRemoveUserContainerManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearProjectIdInTheRemoveUserContainerCache() =>
      _projectIdInTheRemoveUserContainerManager.clear();
  void clearProjectIdInTheRemoveUserContainerCacheKey(String? uniqueKey) =>
      _projectIdInTheRemoveUserContainerManager.clearRequest(uniqueKey);

  final _projectIdInTheViewUserContainerManager =
      FutureRequestManager<List<ReccestagesRow>>();
  Future<List<ReccestagesRow>> projectIdInTheViewUserContainer({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<ReccestagesRow>> Function() requestFn,
  }) =>
      _projectIdInTheViewUserContainerManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearProjectIdInTheViewUserContainerCache() =>
      _projectIdInTheViewUserContainerManager.clear();
  void clearProjectIdInTheViewUserContainerCacheKey(String? uniqueKey) =>
      _projectIdInTheViewUserContainerManager.clearRequest(uniqueKey);

  final _usersInDropDownProjectDetailScreenManager =
      FutureRequestManager<List<UsersRow>>();
  Future<List<UsersRow>> usersInDropDownProjectDetailScreen({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<UsersRow>> Function() requestFn,
  }) =>
      _usersInDropDownProjectDetailScreenManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearUsersInDropDownProjectDetailScreenCache() =>
      _usersInDropDownProjectDetailScreenManager.clear();
  void clearUsersInDropDownProjectDetailScreenCacheKey(String? uniqueKey) =>
      _usersInDropDownProjectDetailScreenManager.clearRequest(uniqueKey);

  final _projectIdInTheColumnManager =
      FutureRequestManager<List<ReccetemplatesRow>>();
  Future<List<ReccetemplatesRow>> projectIdInTheColumn({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<ReccetemplatesRow>> Function() requestFn,
  }) =>
      _projectIdInTheColumnManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearProjectIdInTheColumnCache() => _projectIdInTheColumnManager.clear();
  void clearProjectIdInTheColumnCacheKey(String? uniqueKey) =>
      _projectIdInTheColumnManager.clearRequest(uniqueKey);

  final _projectIDetailScreenManager =
      FutureRequestManager<List<ReccetemplatesRow>>();
  Future<List<ReccetemplatesRow>> projectIDetailScreen({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<ReccetemplatesRow>> Function() requestFn,
  }) =>
      _projectIDetailScreenManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearProjectIDetailScreenCache() => _projectIDetailScreenManager.clear();
  void clearProjectIDetailScreenCacheKey(String? uniqueKey) =>
      _projectIDetailScreenManager.clearRequest(uniqueKey);

  final _userIdInTheTaskNewManager = FutureRequestManager<List<UserRolesRow>>();
  Future<List<UserRolesRow>> userIdInTheTaskNew({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<UserRolesRow>> Function() requestFn,
  }) =>
      _userIdInTheTaskNewManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearUserIdInTheTaskNewCache() => _userIdInTheTaskNewManager.clear();
  void clearUserIdInTheTaskNewCacheKey(String? uniqueKey) =>
      _userIdInTheTaskNewManager.clearRequest(uniqueKey);

  final _taskListViewManager = FutureRequestManager<List<ProjectsRow>>();
  Future<List<ProjectsRow>> taskListView({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<ProjectsRow>> Function() requestFn,
  }) =>
      _taskListViewManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearTaskListViewCache() => _taskListViewManager.clear();
  void clearTaskListViewCacheKey(String? uniqueKey) =>
      _taskListViewManager.clearRequest(uniqueKey);

  final _taskListView2Manager = FutureRequestManager<List<ProjectsRow>>();
  Future<List<ProjectsRow>> taskListView2({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<ProjectsRow>> Function() requestFn,
  }) =>
      _taskListView2Manager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearTaskListView2Cache() => _taskListView2Manager.clear();
  void clearTaskListView2CacheKey(String? uniqueKey) =>
      _taskListView2Manager.clearRequest(uniqueKey);

  final _messagesListManager = FutureRequestManager<List<ProjectsRow>>();
  Future<List<ProjectsRow>> messagesList({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<ProjectsRow>> Function() requestFn,
  }) =>
      _messagesListManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearMessagesListCache() => _messagesListManager.clear();
  void clearMessagesListCacheKey(String? uniqueKey) =>
      _messagesListManager.clearRequest(uniqueKey);

  final _userIdInMessagesManager = FutureRequestManager<List<UserRolesRow>>();
  Future<List<UserRolesRow>> userIdInMessages({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<UserRolesRow>> Function() requestFn,
  }) =>
      _userIdInMessagesManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearUserIdInMessagesCache() => _userIdInMessagesManager.clear();
  void clearUserIdInMessagesCacheKey(String? uniqueKey) =>
      _userIdInMessagesManager.clearRequest(uniqueKey);

  final _messageList2Manager = FutureRequestManager<List<ProjectsRow>>();
  Future<List<ProjectsRow>> messageList2({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<ProjectsRow>> Function() requestFn,
  }) =>
      _messageList2Manager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearMessageList2Cache() => _messageList2Manager.clear();
  void clearMessageList2CacheKey(String? uniqueKey) =>
      _messageList2Manager.clearRequest(uniqueKey);

  final _projectIdInSDRPageManager =
      FutureRequestManager<List<ReccetemplatesRow>>();
  Future<List<ReccetemplatesRow>> projectIdInSDRPage({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<ReccetemplatesRow>> Function() requestFn,
  }) =>
      _projectIdInSDRPageManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearProjectIdInSDRPageCache() => _projectIdInSDRPageManager.clear();
  void clearProjectIdInSDRPageCacheKey(String? uniqueKey) =>
      _projectIdInSDRPageManager.clearRequest(uniqueKey);

  final _receTemplateList1Manager =
      FutureRequestManager<List<RecceresponsesRow>>();
  Future<List<RecceresponsesRow>> receTemplateList1({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<RecceresponsesRow>> Function() requestFn,
  }) =>
      _receTemplateList1Manager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearReceTemplateList1Cache() => _receTemplateList1Manager.clear();
  void clearReceTemplateList1CacheKey(String? uniqueKey) =>
      _receTemplateList1Manager.clearRequest(uniqueKey);

  final _userIdInMessagesContainerManager =
      FutureRequestManager<List<UserRolesRow>>();
  Future<List<UserRolesRow>> userIdInMessagesContainer({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<UserRolesRow>> Function() requestFn,
  }) =>
      _userIdInMessagesContainerManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearUserIdInMessagesContainerCache() =>
      _userIdInMessagesContainerManager.clear();
  void clearUserIdInMessagesContainerCacheKey(String? uniqueKey) =>
      _userIdInMessagesContainerManager.clearRequest(uniqueKey);

  final _userIdInTheTaskNew2Manager =
      FutureRequestManager<List<UserRolesRow>>();
  Future<List<UserRolesRow>> userIdInTheTaskNew2({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<UserRolesRow>> Function() requestFn,
  }) =>
      _userIdInTheTaskNew2Manager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearUserIdInTheTaskNew2Cache() => _userIdInTheTaskNew2Manager.clear();
  void clearUserIdInTheTaskNew2CacheKey(String? uniqueKey) =>
      _userIdInTheTaskNew2Manager.clearRequest(uniqueKey);

  final _userIdForUserNameManager = FutureRequestManager<List<UserRolesRow>>();
  Future<List<UserRolesRow>> userIdForUserName({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<UserRolesRow>> Function() requestFn,
  }) =>
      _userIdForUserNameManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearUserIdForUserNameCache() => _userIdForUserNameManager.clear();
  void clearUserIdForUserNameCacheKey(String? uniqueKey) =>
      _userIdForUserNameManager.clearRequest(uniqueKey);

  final _projectIdInTheColumn2Manager =
      FutureRequestManager<List<ReccetemplatesRow>>();
  Future<List<ReccetemplatesRow>> projectIdInTheColumn2({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<ReccetemplatesRow>> Function() requestFn,
  }) =>
      _projectIdInTheColumn2Manager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearProjectIdInTheColumn2Cache() =>
      _projectIdInTheColumn2Manager.clear();
  void clearProjectIdInTheColumn2CacheKey(String? uniqueKey) =>
      _projectIdInTheColumn2Manager.clearRequest(uniqueKey);

  final _recceDetailColumnManager =
      FutureRequestManager<List<RecceresponsesRow>>();
  Future<List<RecceresponsesRow>> recceDetailColumn({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<RecceresponsesRow>> Function() requestFn,
  }) =>
      _recceDetailColumnManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearRecceDetailColumnCache() => _recceDetailColumnManager.clear();
  void clearRecceDetailColumnCacheKey(String? uniqueKey) =>
      _recceDetailColumnManager.clearRequest(uniqueKey);

  final _userNameOpeningScreenManager = FutureRequestManager<List<UsersRow>>();
  Future<List<UsersRow>> userNameOpeningScreen({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<UsersRow>> Function() requestFn,
  }) =>
      _userNameOpeningScreenManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearUserNameOpeningScreenCache() =>
      _userNameOpeningScreenManager.clear();
  void clearUserNameOpeningScreenCacheKey(String? uniqueKey) =>
      _userNameOpeningScreenManager.clearRequest(uniqueKey);

  final _listOfProjectsOnDropDownManager =
      FutureRequestManager<List<ProjectsRow>>();
  Future<List<ProjectsRow>> listOfProjectsOnDropDown({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<ProjectsRow>> Function() requestFn,
  }) =>
      _listOfProjectsOnDropDownManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearListOfProjectsOnDropDownCache() =>
      _listOfProjectsOnDropDownManager.clear();
  void clearListOfProjectsOnDropDownCacheKey(String? uniqueKey) =>
      _listOfProjectsOnDropDownManager.clearRequest(uniqueKey);
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
