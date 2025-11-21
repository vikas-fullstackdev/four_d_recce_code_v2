import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_timer.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/edit_email/edit_email_widget.dart';
import '/pages/edit_password/edit_password_widget.dart';
import 'dart:math';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'account_settings_widget.dart' show AccountSettingsWidget;
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AccountSettingsModel extends FlutterFlowModel<AccountSettingsWidget> {
  ///  Local state fields for this page.

  List<dynamic> proposedSiteLocation = [];
  void addToProposedSiteLocation(dynamic item) =>
      proposedSiteLocation.add(item);
  void removeFromProposedSiteLocation(dynamic item) =>
      proposedSiteLocation.remove(item);
  void removeAtIndexFromProposedSiteLocation(int index) =>
      proposedSiteLocation.removeAt(index);
  void insertAtIndexInProposedSiteLocation(int index, dynamic item) =>
      proposedSiteLocation.insert(index, item);
  void updateProposedSiteLocationAtIndex(
          int index, Function(dynamic) updateFn) =>
      proposedSiteLocation[index] = updateFn(proposedSiteLocation[index]);

  ///  State fields for stateful widgets in this page.

  // State field(s) for Timer widget.
  final timerInitialTimeMs = 3000;
  int timerMilliseconds = 3000;
  String timerValue = StopWatchTimer.getDisplayTime(
    3000,
    hours: false,
    milliSecond: false,
  );
  FlutterFlowTimerController timerController =
      FlutterFlowTimerController(StopWatchTimer(mode: StopWatchMode.countDown));

  // Stores action output result for [Custom Action - isDeviceOnline] action in Timer widget.
  bool? isDeviceOnlineTImer;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    timerController.dispose();
  }
}
