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
// import '/flutter_flow/nav/nav.dart'; // <-- ADD THIS LINE
import '../pages/image_annotator_page_fixed.dart';
// import 'package:stop_watch_timer/stop_watch_timer.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
// import 'opening_screen_model.dart';
// export 'opening_screen_model.dart';

/// FlutterFlow AI Prompt — Opening Screen
///
/// Prompt:
///
/// Create a modern opening screen for an internal interior-design
/// application.
///
/// Top App Bar Layout:
///
/// Left side: company logo (small, clean).
///
/// Right side: an Online/Offline toggle switch.
///
/// Next to the toggle, a circular profile icon button.
///
/// Main Section:
///
/// Large “Welcome, {UserName}” title.
///
/// Below it, add 4 equal-size grid boxes (2 × 2 layout).
///
/// Each box must be a rounded card with shadow, icon + title.
///
/// The four boxes should have these labels:
///
/// Regional
///
/// Corporate
///
/// F&B
///
/// International Sites
///
/// Bottom Navbar (Sticky):
/// Create a 5-tab bottom navigation bar with icons:
///
/// Home
///
/// Projects
///
/// Recce
///
/// QC
///
/// Final
///
/// Design Style:
///
/// Professional, minimal, internal-tool styling.
///
/// Soft shadows, rounded corners (12–16px), consistent spacing.
///
/// Neutral background with subtle contrast for card items.
///
/// Use responsive layout so it looks good on mobile screens.
// class OpeningScreenWidget extends StatefulWidget {
//   const OpeningScreenWidget({super.key});

//   static String routeName = 'OpeningScreen';
//   static String routePath = '/openingScreen';

//   @override
//   State<OpeningScreenWidget> createState() => _OpeningScreenWidgetState();
// }

// class _OpeningScreenWidgetState extends State<OpeningScreenWidget> {
//   late OpeningScreenModel _model;

//   final scaffoldKey = GlobalKey<ScaffoldState>();

//   @override
//   void initState() {
//     super.initState();
//     _model = createModel(context, () => OpeningScreenModel());

//     // On page load action.
//     SchedulerBinding.instance.addPostFrameCallback((_) async {
//       _model.timerController.timer.setPresetTime(mSec: 3000, add: false);
//       _model.timerController.onResetTimer();

//       _model.timerController.onStartTimer();
//     });

//     WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
//   }

//   @override
//   void dispose() {
//     _model.dispose();

//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         FocusScope.of(context).unfocus();
//         FocusManager.instance.primaryFocus?.unfocus();
//       },
//       child: Scaffold(
//         key: scaffoldKey,
//         backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
//         appBar: AppBar(
//           backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
//           automaticallyImplyLeading: false,
//           title: Row(
//             mainAxisSize: MainAxisSize.max,
//             children: [
//               Image.asset(
//                 'assets/images/New4Dlogo.png',
//                 width: 42.0,
//                 height: 42.0,
//                 fit: BoxFit.contain,
//               ),
//               Text(
//                 'Home',
//                 style: FlutterFlowTheme.of(context).titleMedium.override(
//                       font: GoogleFonts.interTight(
//                         fontWeight: FontWeight.w600,
//                         fontStyle:
//                             FlutterFlowTheme.of(context).titleMedium.fontStyle,
//                       ),
//                       letterSpacing: 0.0,
//                       fontWeight: FontWeight.w600,
//                       fontStyle:
//                           FlutterFlowTheme.of(context).titleMedium.fontStyle,
//                     ),
//               ),
//             ].divide(SizedBox(width: 12.0)),
//           ),
//           actions: [
//             Padding(
//               padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
//               child: Row(
//                 mainAxisSize: MainAxisSize.max,
//                 children: [
//                   Row(
//                     mainAxisSize: MainAxisSize.max,
//                     children: [
//                       if (_model.isDeviceOnlineTImer == true)
//                         FlutterFlowIconButton(
//                           borderRadius: 8.0,
//                           buttonSize: 40.0,
//                           icon: Icon(
//                             Icons.online_prediction,
//                             color: Color(0xFF00FF00),
//                             size: 24.0,
//                           ),
//                           onPressed: () {
//                             print('IconButton pressed ...');
//                           },
//                         ),
//                       if (_model.isDeviceOnlineTImer == false)
//                         FlutterFlowIconButton(
//                           borderRadius: 8.0,
//                           buttonSize: 40.0,
//                           icon: Icon(
//                             Icons.cloud_off,
//                             color: Color(0xFFFF0000),
//                             size: 24.0,
//                           ),
//                           onPressed: () {
//                             print('IconButton pressed ...');
//                           },
//                         ),
//                       Align(
//                         alignment: AlignmentDirectional(0.0, 0.0),
//                         child: FlutterFlowTimer(
//                           key: ValueKey('homeTimer'),
//                           initialTime: _model.timerInitialTimeMs,
//                           getDisplayTime: (value) =>
//                               StopWatchTimer.getDisplayTime(
//                             value,
//                             hours: false,
//                             milliSecond: false,
//                           ),
//                           controller: _model.timerController,
//                           updateStateInterval: Duration(milliseconds: 1000),
//                           onChanged: (value, displayTime, shouldUpdate) {
//                             _model.timerMilliseconds = value;
//                             _model.timerValue = displayTime;
//                             if (shouldUpdate) safeSetState(() {});
//                           },
//                           onEnded: () async {
//                             _model.timerController.onStartTimer();
//                             _model.isDeviceOnlineTImer =
//                                 await actions.isDeviceOnline();
//                             _model.timerController.timer
//                                 .setPresetTime(mSec: 30000, add: false);
//                             _model.timerController.onResetTimer();

//                             _model.timerController.onStartTimer();

//                             safeSetState(() {});
//                           },
//                           textAlign: TextAlign.start,
//                           style: FlutterFlowTheme.of(context)
//                               .headlineSmall
//                               .override(
//                                 font: GoogleFonts.interTight(
//                                   fontWeight: FlutterFlowTheme.of(context)
//                                       .headlineSmall
//                                       .fontWeight,
//                                   fontStyle: FlutterFlowTheme.of(context)
//                                       .headlineSmall
//                                       .fontStyle,
//                                 ),
//                                 fontSize: 0.0,
//                                 letterSpacing: 0.0,
//                                 fontWeight: FlutterFlowTheme.of(context)
//                                     .headlineSmall
//                                     .fontWeight,
//                                 fontStyle: FlutterFlowTheme.of(context)
//                                     .headlineSmall
//                                     .fontStyle,
//                               ),
//                         ),
//                       ),
//                       if (responsiveVisibility(
//                         context: context,
//                         phone: false,
//                         tablet: false,
//                         tabletLandscape: false,
//                         desktop: false,
//                       ))
//                         FlutterFlowIconButton(
//                           borderRadius: 8.0,
//                           buttonSize: 40.0,
//                           icon: Icon(
//                             Icons.receipt_long,
//                             color: FlutterFlowTheme.of(context).secondary,
//                             size: 24.0,
//                           ),
//                           onPressed: () async {
//                             context.goNamed(ReceTemplateWidget.routeName);
//                           },
//                         ),
//                     ],
//                   ),
//                   FlutterFlowIconButton(
//                     borderRadius: 20.0,
//                     buttonSize: 40.0,
//                     fillColor: FlutterFlowTheme.of(context).primary,
//                     icon: Icon(
//                       Icons.person,
//                       color: Colors.white,
//                       size: 20.0,
//                     ),
//                     onPressed: () async {
//                       context.pushNamed(ProfileWidget.routeName);
//                     },
//                   ),
//                 ].divide(SizedBox(width: 8.0)),
//               ),
//             ),
//           ],
//           centerTitle: false,
//           elevation: 0.0,
//         ),
//         body: SafeArea(
//           top: true,
//           child: Padding(
//             padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
//             child: Column(
//               mainAxisSize: MainAxisSize.max,
//               children: [
//                 Column(
//                   mainAxisSize: MainAxisSize.max,
//                   children: [
//                     FutureBuilder<List<UsersRow>>(
//                       future: FFAppState().userNameOpeningScreen(
//                         uniqueQueryKey:
//                             'userNameOpeningScreen${currentUserUid}',
//                         requestFn: () => UsersTable().querySingleRow(
//                           queryFn: (q) => q.eqOrNull(
//                             'userid',
//                             currentUserUid,
//                           ),
//                         ),
//                       ),
//                       builder: (context, snapshot) {
//                         // Customize what your widget looks like when it's loading.
//                         if (!snapshot.hasData) {
//                           return Center(
//                             child: SizedBox(
//                               width: 50.0,
//                               height: 50.0,
//                               child: CircularProgressIndicator(
//                                 valueColor: AlwaysStoppedAnimation<Color>(
//                                   FlutterFlowTheme.of(context).primary,
//                                 ),
//                               ),
//                             ),
//                           );
//                         }
//                         List<UsersRow> textUsersRowList = snapshot.data!;

//                         final textUsersRow = textUsersRowList.isNotEmpty
//                             ? textUsersRowList.first
//                             : null;

//                         return Text(
//                           'Welcome, ${textUsersRow?.name}',
//                           style: FlutterFlowTheme.of(context)
//                               .headlineLarge
//                               .override(
//                                 font: GoogleFonts.interTight(
//                                   fontWeight: FontWeight.bold,
//                                   fontStyle: FlutterFlowTheme.of(context)
//                                       .headlineLarge
//                                       .fontStyle,
//                                 ),
//                                 letterSpacing: 0.0,
//                                 fontWeight: FontWeight.bold,
//                                 fontStyle: FlutterFlowTheme.of(context)
//                                     .headlineLarge
//                                     .fontStyle,
//                               ),
//                         );
//                       },
//                     ),
//                     Text(
//                       'Ready to create amazing spaces today?',
//                       style: FlutterFlowTheme.of(context).bodyMedium.override(
//                             font: GoogleFonts.inter(
//                               fontWeight: FlutterFlowTheme.of(context)
//                                   .bodyMedium
//                                   .fontWeight,
//                               fontStyle: FlutterFlowTheme.of(context)
//                                   .bodyMedium
//                                   .fontStyle,
//                             ),
//                             color: FlutterFlowTheme.of(context).secondaryText,
//                             letterSpacing: 0.0,
//                             fontWeight: FlutterFlowTheme.of(context)
//                                 .bodyMedium
//                                 .fontWeight,
//                             fontStyle: FlutterFlowTheme.of(context)
//                                 .bodyMedium
//                                 .fontStyle,
//                           ),
//                     ),
//                   ].divide(SizedBox(height: 8.0)),
//                 ),
//                 GridView(
//                   padding: EdgeInsets.zero,
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     crossAxisSpacing: 16.0,
//                     mainAxisSpacing: 16.0,
//                     childAspectRatio: 0.7,
//                   ),
//                   primary: false,
//                   shrinkWrap: true,
//                   scrollDirection: Axis.vertical,
//                   children: [
//                     InkWell(
//                       splashColor: Colors.transparent,
//                       focusColor: Colors.transparent,
//                       hoverColor: Colors.transparent,
//                       highlightColor: Colors.transparent,
//                       onTap: () async {
//                         context.pushNamed(
//                           HomePageWidget.routeName,
//                           queryParameters: {
//                             'projectType': serializeParam(
//                               'regional',
//                               ParamType.String,
//                             ),
//                           }.withoutNulls,
//                         );
//                       },
//                       child: Container(
//                         width: double.infinity,
//                         decoration: BoxDecoration(
//                           color:
//                               FlutterFlowTheme.of(context).secondaryBackground,
//                           boxShadow: [
//                             BoxShadow(
//                               blurRadius: 8.0,
//                               color: Color(0x1A000000),
//                               offset: Offset(
//                                 0.0,
//                                 2.0,
//                               ),
//                             )
//                           ],
//                           borderRadius: BorderRadius.circular(16.0),
//                         ),
//                         child: Padding(
//                           padding: EdgeInsets.all(20.0),
//                           child: Column(
//                             mainAxisSize: MainAxisSize.max,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Container(
//                                 width: 48.0,
//                                 height: 48.0,
//                                 decoration: BoxDecoration(
//                                   color: Color(0xFFE3F2FD),
//                                   borderRadius: BorderRadius.circular(12.0),
//                                 ),
//                                 child: Align(
//                                   alignment: AlignmentDirectional(0.0, 0.0),
//                                   child: Icon(
//                                     Icons.location_city,
//                                     color: FlutterFlowTheme.of(context).primary,
//                                     size: 24.0,
//                                   ),
//                                 ),
//                               ),
//                               Text(
//                                 'Regional',
//                                 textAlign: TextAlign.center,
//                                 style: FlutterFlowTheme.of(context)
//                                     .titleMedium
//                                     .override(
//                                       font: GoogleFonts.interTight(
//                                         fontWeight: FontWeight.w600,
//                                         fontStyle: FlutterFlowTheme.of(context)
//                                             .titleMedium
//                                             .fontStyle,
//                                       ),
//                                       letterSpacing: 0.0,
//                                       fontWeight: FontWeight.w600,
//                                       fontStyle: FlutterFlowTheme.of(context)
//                                           .titleMedium
//                                           .fontStyle,
//                                     ),
//                               ),
//                             ].divide(SizedBox(height: 12.0)),
//                           },
//                         ),
//                       ),
//                     ),
//                     InkWell(
//                       splashColor: Colors.transparent,
//                       focusColor: Colors.transparent,
//                       hoverColor: Colors.transparent,
//                       highlightColor: Colors.transparent,
//                       onTap: () async {
//                         context.pushNamed(
//                           HomePageWidget.routeName,
//                           queryParameters: {
//                             'projectType': serializeParam(
//                               'corporate',
//                               ParamType.String,
//                             ),
//                           }.withoutNulls,
//                         );
//                       },
//                       child: Container(
//                         width: double.infinity,
//                         decoration: BoxDecoration(
//                           color:
//                               FlutterFlowTheme.of(context).secondaryBackground,
//                           boxShadow: [
//                             BoxShadow(
//                               blurRadius: 8.0,
//                               color: Color(0x1A000000),
//                               offset: Offset(
//                                 0.0,
//                                 2.0,
//                               ),
//                             )
//                           ],
//                           borderRadius: BorderRadius.circular(16.0),
//                         ),
//                         child: Padding(
//                           padding: EdgeInsets.all(20.0),
//                           child: Column(
//                             mainAxisSize: MainAxisSize.max,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Container(
//                                 width: 48.0,
//                                 height: 48.0,
//                                 decoration: BoxDecoration(
//                                   color: Color(0xFFF3E5F5),
//                                   borderRadius: BorderRadius.circular(12.0),
//                                 ),
//                                 child: Align(
//                                   alignment: AlignmentDirectional(0.0, 0.0),
//                                   child: Icon(
//                                     Icons.business,
//                                     color: Colors.purple,
//                                     size: 24.0,
//                                   ),
//                                 ),
//                               ),
//                               Text(
//                                 'Corporate',
//                                 textAlign: TextAlign.center,
//                                 style: FlutterFlowTheme.of(context)
//                                     .titleMedium
//                                     .override(
//                                       font: GoogleFonts.interTight(
//                                         fontWeight: FontWeight.w600,
//                                         fontStyle: FlutterFlowTheme.of(context)
//                                             .titleMedium
//                                             .fontStyle,
//                                       ),
//                                       letterSpacing: 0.0,
//                                       fontWeight: FontWeight.w600,
//                                       fontStyle: FlutterFlowTheme.of(context)
//                                           .titleMedium
//                                           .fontStyle,
//                                     ),
//                               ),
//                             ].divide(SizedBox(height: 12.0)),
//                           },
//                         ),
//                       ),
//                     ),
//                     InkWell(
//                       splashColor: Colors.transparent,
//                       focusColor: Colors.transparent,
//                       hoverColor: Colors.transparent,
//                       highlightColor: Colors.transparent,
//                       onTap: () async {
//                         context.pushNamed(
//                           HomePageWidget.routeName,
//                           queryParameters: {
//                             'projectType': serializeParam(
//                               'fandb',
//                               ParamType.String,
//                             ),
//                           }.withoutNulls,
//                         );
//                       },
//                       child: Container(
//                         width: double.infinity,
//                         decoration: BoxDecoration(
//                           color:
//                               FlutterFlowTheme.of(context).secondaryBackground,
//                           boxShadow: [
//                             BoxShadow(
//                               blurRadius: 8.0,
//                               color: Color(0x1A000000),
//                               offset: Offset(
//                                 0.0,
//                                 2.0,
//                               ),
//                             )
//                           ],
//                           borderRadius: BorderRadius.circular(16.0),
//                         ),
//                         child: Padding(
//                           padding: EdgeInsets.all(20.0),
//                           child: Column(
//                             mainAxisSize: MainAxisSize.max,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Container(
//                                 width: 48.0,
//                                 height: 48.0,
//                                 decoration: BoxDecoration(
//                                   color: Color(0xFFE8F5E8),
//                                   borderRadius: BorderRadius.circular(12.0),
//                                 ),
//                                 child: Align(
//                                   alignment: AlignmentDirectional(0.0, 0.0),
//                                   child: Icon(
//                                     Icons.restaurant,
//                                     color: FlutterFlowTheme.of(context).success,
//                                     size: 24.0,
//                                   ),
//                                 ),
//                               ),
//                               Text(
//                                 'F&B',
//                                 textAlign: TextAlign.center,
//                                 style: FlutterFlowTheme.of(context)
//                                     .titleMedium
//                                     .override(
//                                       font: GoogleFonts.interTight(
//                                         fontWeight: FontWeight.w600,
//                                         fontStyle: FlutterFlowTheme.of(context)
//                                             .titleMedium
//                                             .fontStyle,
//                                       ),
//                                       letterSpacing: 0.0,
//                                       fontWeight: FontWeight.w600,
//                                       fontStyle: FlutterFlowTheme.of(context)
//                                           .titleMedium
//                                           .fontStyle,
//                                     ),
//                               ),
//                             ].divide(SizedBox(height: 12.0)),
//                           },
//                         ),
//                       ),
//                     ),
//                     InkWell(
//                       splashColor: Colors.transparent,
//                       focusColor: Colors.transparent,
//                       hoverColor: Colors.transparent,
//                       highlightColor: Colors.transparent,
//                       onTap: () async {
//                         context.pushNamed(
//                           HomePageWidget.routeName,
//                           queryParameters: {
//                             'projectType': serializeParam(
//                               'international',
//                               ParamType.String,
//                             ),
//                           }.withoutNulls,
//                         );
//                       },
//                       child: Container(
//                         width: double.infinity,
//                         decoration: BoxDecoration(
//                           color:
//                               FlutterFlowTheme.of(context).secondaryBackground,
//                           boxShadow: [
//                             BoxShadow(
//                               blurRadius: 8.0,
//                               color: Color(0x1A000000),
//                               offset: Offset(
//                                 0.0,
//                                 2.0,
//                               ),
//                             )
//                           ],
//                           borderRadius: BorderRadius.circular(16.0),
//                         ),
//                         child: Padding(
//                           padding: EdgeInsets.all(20.0),
//                           child: Column(
//                             mainAxisSize: MainAxisSize.max,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Container(
//                                 width: 48.0,
//                                 height: 48.0,
//                                 decoration: BoxDecoration(
//                                   color: Color(0xFFFEF7E0),
//                                   borderRadius: BorderRadius.circular(12.0),
//                                 ),
//                                 child: Align(
//                                   alignment: AlignmentDirectional(0.0, 0.0),
//                                   child: Icon(
//                                     Icons.public,
//                                     color: Colors.orange,
//                                     size: 24.0,
//                                   ),
//                                 ),
//                               ),
//                               Text(
//                                 'International Sites',
//                                 textAlign: TextAlign.center,
//                                 style: FlutterFlowTheme.of(context)
//                                     .titleMedium
//                                     .override(
//                                       font: GoogleFonts.interTight(
//                                         fontWeight: FontWeight.w600,
//                                         fontStyle: FlutterFlowTheme.of(context)
//                                             .titleMedium
//                                             .fontStyle,
//                                       ),
//                                       letterSpacing: 0.0,
//                                       fontWeight: FontWeight.w600,
//                                       fontStyle: FlutterFlowTheme.of(context)
//                                           .titleMedium
//                                           .fontStyle,
//                                     ),
//                               ),
//                             ].divide(SizedBox(height: 12.0)),
//                           },
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ]
//                   .divide(SizedBox(height: 32.0))
//                   .addToStart(SizedBox(height: 24.0))
//                   .addToEnd(SizedBox(height: 100.0)),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:four_d_recce_code/pages/image_annotator_page.dart';

import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_timer.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import '/flutter_flow/nav/nav.dart'; // <-- ADD THIS LINE
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'opening_screen_model.dart';
export 'opening_screen_model.dart';

class OpeningScreenWidget extends StatefulWidget {
  const OpeningScreenWidget({super.key});

  static String routeName = 'OpeningScreen';
  static String routePath = '/openingScreen';

  @override
  State<OpeningScreenWidget> createState() => _OpeningScreenWidgetState();
}

class _OpeningScreenWidgetState extends State<OpeningScreenWidget> {
  late OpeningScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OpeningScreenModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.timerController.timer.setPresetTime(mSec: 3000, add: false);
      _model.timerController.onResetTimer();

      _model.timerController.onStartTimer();
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  // Helper to build the four menu cards (keeps code DRY)
  Widget _menuCard({
    required BuildContext context,
    required String title,
    required IconData icon,
    required String projectType,
    Color? iconBg,
    Color? iconColor,
  }) {
    final theme = FlutterFlowTheme.of(context);
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async {
        // Navigate to HomePage via GoRouter so ShellRoute updates active tab.
        context.goNamed(
          HomePageWidget.routeName,
          queryParameters: {
            'projectType': serializeParam(
              projectType,
              ParamType.String,
            ),
          }.withoutNulls,
        );
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: theme.secondaryBackground,
          boxShadow: const [
            BoxShadow(
              blurRadius: 8.0,
              color: Color(0x1A000000),
              offset: Offset(0.0, 2.0),
            )
          ],
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 48.0,
                height: 48.0,
                decoration: BoxDecoration(
                  color: iconBg ?? const Color(0xFFE3F2FD),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Align(
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: Icon(
                    icon,
                    color: iconColor ?? theme.primary,
                    size: 24.0,
                  ),
                ),
              ),
              const SizedBox(height: 12.0),
              Text(
                title,
                textAlign: TextAlign.center,
                style: theme.titleMedium!.override(
                  font: GoogleFonts.interTight(
                    fontWeight: FontWeight.w600,
                    fontStyle: theme.titleMedium!.fontStyle,
                  ),
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w600,
                  fontStyle: theme.titleMedium!.fontStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: theme.primaryBackground,
        bottomNavigationBar: null,
        appBar: AppBar(
          backgroundColor: theme.secondaryBackground,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Image.asset(
                'assets/images/logo.png',
                width: 42.0,
                height: 42.0,
                fit: BoxFit.contain,
              ),
              const SizedBox(width: 12.0),
              Text(
                'Home',
                style: theme.titleMedium!.override(
                  font: GoogleFonts.interTight(
                    fontWeight: FontWeight.w600,
                    fontStyle: theme.titleMedium!.fontStyle,
                  ),
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w600,
                  fontStyle: theme.titleMedium!.fontStyle,
                ),
              ),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      if (_model.isDeviceOnlineTImer == true)
                        FlutterFlowIconButton(
                          borderRadius: 8.0,
                          buttonSize: 40.0,
                          icon: const Icon(
                            Icons.online_prediction,
                            color: Color(0xFF00FF00),
                            size: 24.0,
                          ),
                          onPressed: () {
                            // no-op for now
                          },
                        ),
                      if (_model.isDeviceOnlineTImer == false)
                        FlutterFlowIconButton(
                          borderRadius: 8.0,
                          buttonSize: 40.0,
                          icon: const Icon(
                            Icons.cloud_off,
                            color: Color(0xFFFF0000),
                            size: 24.0,
                          ),
                          onPressed: () {
                            // no-op for now
                          },
                        ),
                      Align(
                        alignment: const AlignmentDirectional(0.0, 0.0),
                        child: FlutterFlowTimer(
                          key: const ValueKey('homeTimer'),
                          initialTime: _model.timerInitialTimeMs,
                          getDisplayTime: (value) => StopWatchTimer.getDisplayTime(
                            value,
                            hours: false,
                            milliSecond: false,
                          ),
                          controller: _model.timerController,
                          updateStateInterval: const Duration(milliseconds: 1000),
                          onChanged: (value, displayTime, shouldUpdate) {
                            _model.timerMilliseconds = value;
                            _model.timerValue = displayTime;
                            if (shouldUpdate) safeSetState(() {});
                          },
                          onEnded: () async {
                            _model.timerController.onStartTimer();
                            _model.isDeviceOnlineTImer = await actions.isDeviceOnline();
                            _model.timerController.timer.setPresetTime(mSec: 30000, add: false);
                            _model.timerController.onResetTimer();
                            _model.timerController.onStartTimer();
                            safeSetState(() {});
                          },
                          textAlign: TextAlign.start,
                          style: theme.headlineSmall!.override(
                            font: GoogleFonts.interTight(
                              fontWeight: theme.headlineSmall!.fontWeight,
                              fontStyle: theme.headlineSmall!.fontStyle,
                            ),
                            fontSize: 0.0,
                            letterSpacing: 0.0,
                            fontWeight: theme.headlineSmall!.fontWeight,
                            fontStyle: theme.headlineSmall!.fontStyle,
                          ),
                        ),
                      ),
                      if (responsiveVisibility(
                        context: context,
                        phone: false,
                        tablet: false,
                        tabletLandscape: false,
                        desktop: false,
                      ))
                        FlutterFlowIconButton(
                          borderRadius: 8.0,
                          buttonSize: 40.0,
                          icon: Icon(
                            Icons.receipt_long,
                            color: theme.secondary,
                            size: 24.0,
                          ),
                          onPressed: () async {
                            context.goNamed(ReceTemplateWidget.routeName);
                          },
                        ),
                    ],
                  ),
                  FlutterFlowIconButton(
                    borderRadius: 20.0,
                    buttonSize: 40.0,
                    fillColor: theme.primary,
                    icon: const Icon(
                      Icons.draw,
                      color: Colors.white,
                      size: 20.0,
                    ),
                     onPressed: () async {
                      context.pushNamed(ProfileWidget.routeName);
                    },
                  ),
                  FlutterFlowIconButton(
                    borderRadius: 20.0,
                    buttonSize: 40.0,
                    fillColor: theme.primary,
                    icon: const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 20.0,
                    ),
                    onPressed: () async {
                      context.pushNamed(ProfileWidget.routeName);
                    },
                  ),
                ].divide(const SizedBox(width: 8.0)),
              ),
            ),
          ],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                // Welcome + subtitle
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    FutureBuilder<List<UsersRow>>(
                      future: FFAppState().userNameOpeningScreen(
                        uniqueQueryKey: 'userNameOpeningScreen${currentUserUid}',
                        requestFn: () => UsersTable().querySingleRow(
                          queryFn: (q) => q.eqOrNull('userid', currentUserUid),
                        ),
                      ),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: SizedBox(
                              width: 50.0,
                              height: 50.0,
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                        List<UsersRow> textUsersRowList = snapshot.data!;
                        final textUsersRow = textUsersRowList.isNotEmpty ? textUsersRowList.first : null;

                        return Text(
                          'Welcome, ${textUsersRow?.name ?? ''}',
                          style: theme.headlineLarge!.override(
                            font: GoogleFonts.interTight(
                              fontWeight: FontWeight.bold,
                              fontStyle: theme.headlineLarge!.fontStyle,
                            ),
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.bold,
                            fontStyle: theme.headlineLarge!.fontStyle,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Ready to create amazing spaces today?',
                      style: theme.bodyMedium!.override(
                        font: GoogleFonts.inter(
                          fontWeight: theme.bodyMedium!.fontWeight,
                          fontStyle: theme.bodyMedium!.fontStyle,
                        ),
                        color: theme.secondaryText,
                        letterSpacing: 0.0,
                        fontWeight: theme.bodyMedium!.fontWeight,
                        fontStyle: theme.bodyMedium!.fontStyle,
                      ),
                    ),
                  ].divide(const SizedBox(height: 8.0)),
                ),

                // IMPORTANT FIX: give GridView a bounded height by wrapping in Expanded
                // Expanded(
                //   child: GridView(
                //     padding: EdgeInsets.zero,
                //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                //       crossAxisCount: 2,
                //       crossAxisSpacing: 16.0,
                //       mainAxisSpacing: 16.0,
                //       childAspectRatio: 0.8,
                //     ),
                //     physics: const BouncingScrollPhysics(),
                //     children: [
                //      _menuCard(
                //        context: context,
                //        title: 'Corporate Brands',
                //        icon: Icons.business,
                //        projectType: 'corporate',
                //        iconBg: const Color(0xFFF3E5F5),
                //        iconColor: Colors.purple,
                //      ),
                //      _menuCard(
                //        context: context,
                //        title: 'International Sites',
                //        icon: Icons.public,
                //        projectType: 'international',
                //        iconBg: const Color(0xFFFEF7E0),
                //        iconColor: Colors.orange,
                //      ),
                //      _menuCard(
                //        context: context,
                //        title: 'F&B Projects',
                //        icon: Icons.restaurant,
                //        projectType: 'fandb',
                //        iconBg: const Color(0xFFE8F5E8),
                //        iconColor: theme.success,
                //      ),
                //     _menuCard(
                //        context: context,
                //        title: 'Regional Brands',
                //        icon: Icons.location_city,
                //        projectType: 'regional',
                //        iconBg: const Color(0xFFE3F2FD),
                //        iconColor: theme.primary,
                //      ),
                //    ],
                //   ),
                // ),
                Expanded(
                  child: GridView(
                    padding: EdgeInsets.zero,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16.0,
                      mainAxisSpacing: 16.0,
                      childAspectRatio: 0.8,
                    ),
                    physics: const BouncingScrollPhysics(),
                    children: [
                     _menuCard(
                       context: context,
                       title: 'Corporate Brands',
                       icon: Icons.business,
                       projectType: 'corporate',
                       iconBg: const Color(0xFFF3E5F5),
                       iconColor: Colors.purple,
                     ),
                     _menuCard(
                       context: context,
                       title: 'Regional Brands',
                       icon: Icons.public,
                       projectType: 'regional',
                       iconBg: const Color(0xFFFEF7E0),
                       iconColor: Colors.orange,
                     ),
                     _menuCard(
                       context: context,
                       title: 'International Project Sites',
                       icon: Icons.restaurant,
                       projectType: 'international',
                       iconBg: const Color(0xFFE8F5E8),
                       iconColor: theme.success,
                     ),
                    _menuCard(
                       context: context,
                       title: 'F&B Projects',
                       icon: Icons.location_city,
                       projectType: 'fandb',
                       iconBg: const Color(0xFFE3F2FD),
                       iconColor: theme.primary,
                     ),
                   ],
                  ),
                ),
              ]
                  .divide(const SizedBox(height: 32.0))
                  .addToStart(const SizedBox(height: 24.0))
                  .addToEnd(const SizedBox(height: 100.0)),
            ),
          ),
        ),
      ),
    );
  }
}
