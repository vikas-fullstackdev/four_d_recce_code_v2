import 'dart:convert';

import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/components/project_assigned_users_component_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_timer.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:math';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'project_detail_page_widget.dart' show ProjectDetailPageWidget;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProjectDetailPageModel extends FlutterFlowModel<ProjectDetailPageWidget> {
  /// Raw Supabase row for the project
  dynamic rowJson;

  /// Parsed project_details JSON stored as Map after fetch
  Map<String, dynamic> projectDetailsMap = <String, dynamic>{};

  /// UI/UIX state
  bool useCompactLayout = false;

  /// Example DropDown state (kept for compatibility)
  List<String>? dropDownValue;
  FormFieldController<List<String>>? dropDownValueController;

  /// Temporary storage for actions
  String? storePdfDatabaseDownload1;
  String? storePdfDatabaseDownload;

  /// Timer controller used to periodically refresh online status
  final int timerInitialTimeMs = 30000;
  int timerMilliseconds = 30000;
  String timerValue = StopWatchTimer.getDisplayTime(
    30000,
    hours: false,
    milliSecond: false,
  );
  FlutterFlowTimerController timerController =
      FlutterFlowTimerController(StopWatchTimer(mode: StopWatchMode.countDown));

  /// Result from custom action isDeviceOnline
  bool? isDeviceOnlineTImer;

  /// Parse flexible project_details field (Map, JSON string, List, etc.)
  void updateProjectDetails(dynamic raw) {
    projectDetailsMap = <String, dynamic>{};
    if (raw == null) return;

    // If already a Map
    if (raw is Map<String, dynamic>) {
      projectDetailsMap = Map<String, dynamic>.from(raw);
      return;
    }

    // If list (wrap under _list key)
    if (raw is List) {
      projectDetailsMap = <String, dynamic>{'_list': raw};
      return;
    }

    // Try decode JSON string or stringified object
    try {
      final s = raw is String ? raw : raw.toString();
      final decoded = jsonDecode(s);
      if (decoded is Map<String, dynamic>) {
        projectDetailsMap = Map<String, dynamic>.from(decoded);
      } else if (decoded is List) {
        projectDetailsMap = <String, dynamic>{'_list': decoded};
      } else {
        projectDetailsMap = <String, dynamic>{'value': decoded};
      }
    } catch (_) {
      // Fallback: store as single value string
      projectDetailsMap = <String, dynamic>{'value': raw.toString()};
    }
  }

  @override
  void initState(BuildContext context) {
    // nothing extra here
  }

  @override
  void dispose() {
    timerController.dispose();
  }
}
