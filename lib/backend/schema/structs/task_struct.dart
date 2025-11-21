// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TaskStruct extends BaseStruct {
  TaskStruct({
    List<String>? taskName,
    String? taskDescription,
    String? assignedTo,
    String? createdBy,
    String? createdAt,
    String? dueDate,
  })  : _taskName = taskName,
        _taskDescription = taskDescription,
        _assignedTo = assignedTo,
        _createdBy = createdBy,
        _createdAt = createdAt,
        _dueDate = dueDate;

  // "task_name" field.
  List<String>? _taskName;
  List<String> get taskName => _taskName ?? const [];
  set taskName(List<String>? val) => _taskName = val;

  void updateTaskName(Function(List<String>) updateFn) {
    updateFn(_taskName ??= []);
  }

  bool hasTaskName() => _taskName != null;

  // "task_description" field.
  String? _taskDescription;
  String get taskDescription => _taskDescription ?? '';
  set taskDescription(String? val) => _taskDescription = val;

  bool hasTaskDescription() => _taskDescription != null;

  // "assigned_to" field.
  String? _assignedTo;
  String get assignedTo => _assignedTo ?? '';
  set assignedTo(String? val) => _assignedTo = val;

  bool hasAssignedTo() => _assignedTo != null;

  // "created_by" field.
  String? _createdBy;
  String get createdBy => _createdBy ?? '';
  set createdBy(String? val) => _createdBy = val;

  bool hasCreatedBy() => _createdBy != null;

  // "created_at" field.
  String? _createdAt;
  String get createdAt => _createdAt ?? '';
  set createdAt(String? val) => _createdAt = val;

  bool hasCreatedAt() => _createdAt != null;

  // "due_date" field.
  String? _dueDate;
  String get dueDate => _dueDate ?? '';
  set dueDate(String? val) => _dueDate = val;

  bool hasDueDate() => _dueDate != null;

  static TaskStruct fromMap(Map<String, dynamic> data) => TaskStruct(
        taskName: getDataList(data['task_name']),
        taskDescription: data['task_description'] as String?,
        assignedTo: data['assigned_to'] as String?,
        createdBy: data['created_by'] as String?,
        createdAt: data['created_at'] as String?,
        dueDate: data['due_date'] as String?,
      );

  static TaskStruct? maybeFromMap(dynamic data) =>
      data is Map ? TaskStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'task_name': _taskName,
        'task_description': _taskDescription,
        'assigned_to': _assignedTo,
        'created_by': _createdBy,
        'created_at': _createdAt,
        'due_date': _dueDate,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'task_name': serializeParam(
          _taskName,
          ParamType.String,
          isList: true,
        ),
        'task_description': serializeParam(
          _taskDescription,
          ParamType.String,
        ),
        'assigned_to': serializeParam(
          _assignedTo,
          ParamType.String,
        ),
        'created_by': serializeParam(
          _createdBy,
          ParamType.String,
        ),
        'created_at': serializeParam(
          _createdAt,
          ParamType.String,
        ),
        'due_date': serializeParam(
          _dueDate,
          ParamType.String,
        ),
      }.withoutNulls;

  static TaskStruct fromSerializableMap(Map<String, dynamic> data) =>
      TaskStruct(
        taskName: deserializeParam<String>(
          data['task_name'],
          ParamType.String,
          true,
        ),
        taskDescription: deserializeParam(
          data['task_description'],
          ParamType.String,
          false,
        ),
        assignedTo: deserializeParam(
          data['assigned_to'],
          ParamType.String,
          false,
        ),
        createdBy: deserializeParam(
          data['created_by'],
          ParamType.String,
          false,
        ),
        createdAt: deserializeParam(
          data['created_at'],
          ParamType.String,
          false,
        ),
        dueDate: deserializeParam(
          data['due_date'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'TaskStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is TaskStruct &&
        listEquality.equals(taskName, other.taskName) &&
        taskDescription == other.taskDescription &&
        assignedTo == other.assignedTo &&
        createdBy == other.createdBy &&
        createdAt == other.createdAt &&
        dueDate == other.dueDate;
  }

  @override
  int get hashCode => const ListEquality().hash(
      [taskName, taskDescription, assignedTo, createdBy, createdAt, dueDate]);
}

TaskStruct createTaskStruct({
  String? taskDescription,
  String? assignedTo,
  String? createdBy,
  String? createdAt,
  String? dueDate,
}) =>
    TaskStruct(
      taskDescription: taskDescription,
      assignedTo: assignedTo,
      createdBy: createdBy,
      createdAt: createdAt,
      dueDate: dueDate,
    );
