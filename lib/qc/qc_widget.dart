import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_timer.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'qc_model.dart';
export 'qc_model.dart';

// Add imports for the target pages
import '../pages/qc_visit_form/qc_visit_form_widget.dart';
import '../pages/qc_details_history/qc_details_history_widget.dart';

class QcWidget extends StatefulWidget {
  const QcWidget({super.key});

  static String routeName = 'qc';
  static String routePath = '/qc';

  @override
  State<QcWidget> createState() => _QcWidgetState();
}

class _QcWidgetState extends State<QcWidget> {
  late QcModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => QcModel());

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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        bottomNavigationBar: null,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
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
              Text(
                'QC Check list',
                style: FlutterFlowTheme.of(context).titleMedium!.override(
                      font: GoogleFonts.interTight(
                        fontWeight: FontWeight.w600,
                        fontStyle:
                            FlutterFlowTheme.of(context).titleMedium!.fontStyle,
                      ),
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w600,
                      fontStyle:
                          FlutterFlowTheme.of(context).titleMedium!.fontStyle,
                    ),
              ),
            ].divide(const SizedBox(width: 12.0)),
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
                            // no-op
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
                            // no-op
                          },
                        ),
                      Align(
                        alignment: const AlignmentDirectional(0.0, 0.0),
                        child: FlutterFlowTimer(
                          key: const ValueKey('homeTimer'),
                          initialTime: _model.timerInitialTimeMs,
                          getDisplayTime: (value) =>
                              StopWatchTimer.getDisplayTime(
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
                            _model.isDeviceOnlineTImer =
                                await actions.isDeviceOnline();
                            _model.timerController.timer
                                .setPresetTime(mSec: 30000, add: false);
                            _model.timerController.onResetTimer();

                            _model.timerController.onStartTimer();

                            safeSetState(() {});
                          },
                          textAlign: TextAlign.start,
                          style: FlutterFlowTheme.of(context)
                              .headlineSmall!
                              .override(
                                font: GoogleFonts.interTight(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .headlineSmall!
                                      .fontWeight,
                                  fontStyle:
                                      FlutterFlowTheme.of(context)
                                          .headlineSmall!
                                          .fontStyle,
                                ),
                                fontSize: 0.0,
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .headlineSmall!
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .headlineSmall!
                                    .fontStyle,
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
                            color: FlutterFlowTheme.of(context).secondary,
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
                    fillColor: FlutterFlowTheme.of(context).primary,
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
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Intro / Title
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'QC Actions',
                    style: FlutterFlowTheme.of(context).headlineSmall,
                  ),
                ),
                const SizedBox(height: 16),

                // Two-section cards
                Expanded(
                  child: ListView(
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          leading: Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).primary.withOpacity(0.08),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(Icons.play_circle_fill, color: Colors.blue, size: 28),
                          ),
                          title: Text('Launch QC', style: FlutterFlowTheme.of(context).titleMedium),
                          subtitle: const Text('Start a new QC visit and submit responses.'),
                          trailing: ElevatedButton(
                            onPressed: () {
                              // Navigate to QC Visit Form.
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => QcVisitFormWidget(
                                    projectId: '', // provide project id if available
                                    recestageId: '', // provide recestage id if available
                                  ),
                                ),
                              );
                            },
                            child: const Text('Open'),
                            style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          leading: Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).secondary.withOpacity(0.08),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(Icons.history, color: Colors.teal, size: 28),
                          ),
                          title: Text('View QC', style: FlutterFlowTheme.of(context).titleMedium),
                          subtitle: const Text('See QC history and details.'),
                          trailing: ElevatedButton(
                            onPressed: () {
                              // Navigate to QC Details / History.
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => QcDetailsHistoryWidget(
                                    projectId: '',
                                    projectName: '',
                                    proectImage: '',
                                    recestageId: '',
                                    creatDate: DateTime.now(),
                                    responseId: '',
                                    historyId: '',
                                  ),
                                ),
                              );
                            },
                            child: const Text('Open'),
                            style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
