import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import 'remove_users_in_project_widget.dart' show RemoveUsersInProjectWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class RemoveUsersInProjectModel
    extends FlutterFlowModel<RemoveUsersInProjectWidget> {
  ///  Local state fields for this page.

  String toEmail = '';

  String? body;

  List<String> getUserIds = [];
  void addToGetUserIds(String item) => getUserIds.add(item);
  void removeFromGetUserIds(String item) => getUserIds.remove(item);
  void removeAtIndexFromGetUserIds(int index) => getUserIds.removeAt(index);
  void insertAtIndexInGetUserIds(int index, String item) =>
      getUserIds.insert(index, item);
  void updateGetUserIdsAtIndex(int index, Function(String) updateFn) =>
      getUserIds[index] = updateFn(getUserIds[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - getAssignedUsers] action in IconButton widget.
  List<String>? getAssignedUsers;
  // Stores action output result for [Custom Action - getAssignedUsers] action in Button widget.
  List<String>? getAssignedUsers1;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
