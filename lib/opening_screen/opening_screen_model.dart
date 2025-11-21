// import '/auth/supabase_auth/auth_util.dart';
// import '/backend/supabase/supabase.dart';
// import '/flutter_flow/flutter_flow_icon_button.dart';
// import '/flutter_flow/flutter_flow_theme.dart';
// import '/flutter_flow/flutter_flow_timer.dart';
// import '/flutter_flow/flutter_flow_util.dart';
// import '/flutter_flow/flutter_flow_widgets.dart';
// import 'dart:ui';
// import '/custom_code/actions/index.dart' as actions;
// import '/index.dart';
// import 'opening_screen_widget.dart' show OpeningScreenWidget;
// import 'package:stop_watch_timer/stop_watch_timer.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';

// class OpeningScreenModel extends FlutterFlowModel<OpeningScreenWidget> {
//   ///  State fields for stateful widgets in this page.

//   // State field(s) for Timer widget.
//   final timerInitialTimeMs = 3000;
//   int timerMilliseconds = 3000;
//   String timerValue = StopWatchTimer.getDisplayTime(
//     3000,
//     hours: false,
//     milliSecond: false,
//   );
//   FlutterFlowTimerController timerController =
//       FlutterFlowTimerController(StopWatchTimer(mode: StopWatchMode.countDown));

//   // Stores action output result for [Custom Action - isDeviceOnline] action in Timer widget.
//   bool? isDeviceOnlineTImer;

//   @override
//   void initState(BuildContext context) {}

//   @override
//   void dispose() {
//     timerController.dispose();
//   }
// }
import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_timer.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import 'opening_screen_widget.dart' show OpeningScreenWidget;
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OpeningScreenModel extends FlutterFlowModel<OpeningScreenWidget> {
  /// State fields for stateful widgets in this page.

  // State field(s) for Timer widget.
  final int timerInitialTimeMs = 3000;
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
