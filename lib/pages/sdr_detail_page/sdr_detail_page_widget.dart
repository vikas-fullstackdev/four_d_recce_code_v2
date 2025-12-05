import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_timer.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/pages/dropdownaccount/dropdownaccount_widget.dart';
import 'dart:math';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import 'dart:convert';
import 'dart:typed_data';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:open_filex/open_filex.dart';
import 'package:http/http.dart' as http;
import '/utils/download_helper.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '/index.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'sdr_detail_page_model.dart';
export 'sdr_detail_page_model.dart';

class SdrDetailPageWidget extends StatefulWidget {
  const SdrDetailPageWidget({
    super.key,
    this.projectId,
    this.projectName,
    this.proectImage,
    this.recestageId,
  });

  final String? projectId;
  final String? projectName;
  final String? proectImage;
  final String? recestageId;

  static String routeName = 'sdrDetailPage';
  static String routePath = '/sdrDetailPage';

  @override
  State<SdrDetailPageWidget> createState() => _SdrDetailPageWidgetState();
}

class _SdrDetailPageWidgetState extends State<SdrDetailPageWidget>
    with TickerProviderStateMixin {
  late SdrDetailPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  // Helper to build safe download filename: projectname_report.pdf
  String _makeProjectReportFilename(String? projectName, [String? fallbackId]) {
    final base = (projectName?.trim().isNotEmpty == true
            ? projectName!.trim()
            : (fallbackId ?? 'project'))
        .replaceAll(RegExp(r'[^A-Za-z0-9]+'), '_');
    return '${base}_report.pdf';
  }

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SdrDetailPageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.timerController.onStartTimer();
      FFAppState().clearProjectIdInSDRPageCacheKey(
          'projectIdInSDRPage${currentUserUid}');
    });

    animationsMap.addAll({
      'textOnPageLoadAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: Offset(0.0, 40.0),
            end: Offset(0.0, 0.0),
          ),
        ],
      ),
      'dividerOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: Offset(0.0, 30.0),
            end: Offset(0.0, 0.0),
          ),
        ],
      ),
      'textOnPageLoadAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: Offset(0.0, 40.0),
            end: Offset(0.0, 0.0),
          ),
        ],
      ),
    });
    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ReccetemplatesRow>>(
      future: FFAppState().projectIdInSDRPage(
        uniqueQueryKey: 'projectIdInSDRPage${currentUserUid}',
        requestFn: () => ReccetemplatesTable().querySingleRow(
          queryFn: (q) => q.eqOrNull(
            'projectid',
            widget!.projectId,
          ),
        ),
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primary,
                  ),
                ),
              ),
            ),
          );
        }
        List<ReccetemplatesRow> sdrDetailPageReccetemplatesRowList =
            snapshot.data!;

        final sdrDetailPageReccetemplatesRow =
            sdrDetailPageReccetemplatesRowList.isNotEmpty
                ? sdrDetailPageReccetemplatesRowList.first
                : null;

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
                    'SDR Screen',
                    style: FlutterFlowTheme.of(context).titleMedium.override(
                          font: GoogleFonts.interTight(
                            fontWeight: FontWeight.w600,
                            fontStyle: FlutterFlowTheme.of(context)
                                .titleMedium
                                .fontStyle,
                          ),
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w600,
                          fontStyle: FlutterFlowTheme.of(context)
                              .titleMedium
                              .fontStyle,
                        ),
                  ),
                ].divide(SizedBox(width: 12.0)),
              ),
              actions: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
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
                              icon: Icon(
                                Icons.online_prediction,
                                color: Color(0xFF00FF00),
                                size: 24.0,
                              ),
                              onPressed: () {
                                print('IconButton pressed ...');
                              },
                            ),
                          if (_model.isDeviceOnlineTImer == false)
                            FlutterFlowIconButton(
                              borderRadius: 8.0,
                              buttonSize: 40.0,
                              icon: Icon(
                                Icons.cloud_off,
                                color: Color(0xFFFF0000),
                                size: 24.0,
                              ),
                              onPressed: () {
                                print('IconButton pressed ...');
                              },
                            ),
                          Align(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: FlutterFlowTimer(
                              key: ValueKey('homeTimer'),
                              initialTime: _model.timerInitialTimeMs,
                              getDisplayTime: (value) =>
                                  StopWatchTimer.getDisplayTime(
                                value,
                                hours: false,
                                milliSecond: false,
                              ),
                              controller: _model.timerController,
                              updateStateInterval: Duration(milliseconds: 1000),
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
                                  .headlineSmall
                                  .override(
                                    font: GoogleFonts.interTight(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .headlineSmall
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .headlineSmall
                                          .fontStyle,
                                    ),
                                    fontSize: 0.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .headlineSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .headlineSmall
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
                        icon: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 20.0,
                        ),
                        onPressed: () async {
                          context.pushNamed(ProfileWidget.routeName);
                        },
                      ),
                    ].divide(SizedBox(width: 8.0)),
                  ),
                ),
              ],
              centerTitle: false,
              elevation: 0.0,
            ),
            body: SafeArea(
              top: true,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    // Padding(
                    //   padding:
                    //       EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                    //   child: Column(
                    //     mainAxisSize: MainAxisSize.max,
                    //     children: [
                    //       if (responsiveVisibility(
                    //         context: context,
                    //         phone: false,
                    //         tablet: false,
                    //         tabletLandscape: false,
                    //         desktop: false,
                    //       ))
                    //         Row(
                    //           mainAxisSize: MainAxisSize.max,
                    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //           crossAxisAlignment: CrossAxisAlignment.center,
                    //           children: [
                    //             Text(
                    //               'SDR',
                    //               style: FlutterFlowTheme.of(context)
                    //                   .bodyMedium
                    //                   .override(
                    //                     font: GoogleFonts.inter(
                    //                       fontWeight: FontWeight.w500,
                    //                       fontStyle:
                    //                           FlutterFlowTheme.of(context)
                    //                               .bodyMedium
                    //                               .fontStyle,
                    //                     ),
                    //                     fontSize: 20.0,
                    //                     letterSpacing: 0.0,
                    //                     fontWeight: FontWeight.w500,
                    //                     fontStyle: FlutterFlowTheme.of(context)
                    //                         .bodyMedium
                    //                         .fontStyle,
                    //                   ),
                    //             ),
                    //             Container(
                    //               decoration: BoxDecoration(),
                    //               child: Align(
                    //                 alignment: AlignmentDirectional(0.0, 0.0),
                    //                 child: Row(
                    //                   mainAxisSize: MainAxisSize.max,
                    //                   mainAxisAlignment:
                    //                       MainAxisAlignment.center,
                    //                   crossAxisAlignment:
                    //                       CrossAxisAlignment.end,
                    //                   children: [
                    //                     if (responsiveVisibility(
                    //                       context: context,
                    //                       phone: false,
                    //                       tablet: false,
                    //                       tabletLandscape: false,
                    //                       desktop: false,
                    //                     ))
                    //                       Builder(
                    //                         builder: (context) => Padding(
                    //                           padding: EdgeInsetsDirectional
                    //                               .fromSTEB(
                    //                                   0.0, 0.0, 0.0, 20.0),
                    //                           child: FlutterFlowIconButton(
                    //                             borderColor:
                    //                                 FlutterFlowTheme.of(context)
                    //                                     .secondary,
                    //                             borderRadius: 30.0,
                    //                             borderWidth: 1.0,
                    //                             buttonSize: 40.0,
                    //                             icon: Icon(
                    //                               Icons.person,
                    //                               color: FlutterFlowTheme.of(
                    //                                       context)
                    //                                   .primaryText,
                    //                               size: 24.0,
                    //                             ),
                    //                             onPressed: () async {
                    //                               await showAlignedDialog(
                    //                                 context: context,
                    //                                 isGlobal: false,
                    //                                 avoidOverflow: false,
                    //                                 targetAnchor:
                    //                                     AlignmentDirectional(
                    //                                             1.0, 1.0)
                    //                                         .resolve(
                    //                                             Directionality.of(
                    //                                                 context)),
                    //                                 followerAnchor:
                    //                                     AlignmentDirectional(
                    //                                             1.0, -1.0)
                    //                                         .resolve(
                    //                                             Directionality.of(
                    //                                                 context)),
                    //                                 builder: (dialogContext) {
                    //                                   return Material(
                    //                                     color:
                    //                                         Colors.transparent,
                    //                                     child: GestureDetector(
                    //                                       onTap: () {
                    //                                         FocusScope.of(
                    //                                                 dialogContext)
                    //                                             .unfocus();
                    //                                         FocusManager
                    //                                             .instance
                    //                                             .primaryFocus
                    //                                             ?.unfocus();
                    //                                       },
                    //                                       child:
                    //                                           DropdownaccountWidget(),
                    //                                     ),
                    //                                   );
                    //                                 },
                    //                               );
                    //                             },
                    //                           ),
                    //                         ),
                    //                       ),
                    //                     ClipRRect(
                    //                       borderRadius:
                    //                           BorderRadius.circular(8.0),
                    //                       child: Image.asset(
                    //                         'assets/images/4dRecceAppLogo.png',
                    //                         width: 45.0,
                    //                         height: 45.0,
                    //                         fit: BoxFit.cover,
                    //                       ),
                    //                     ),
                    //                   ],
                    //                 ),
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       Container(
                    //         width: double.infinity,
                    //         height: 1.0,
                    //         decoration: BoxDecoration(
                    //           color: FlutterFlowTheme.of(context).secondary,
                    //         ),
                    //       ),
                    //     ].divide(SizedBox(height: 5.0)),
                    //   ),
                    // ),
                    FutureBuilder<List<RecceresponsesRow>>(
                      future: RecceresponsesTable().querySingleRow(
                        queryFn: (q) => q
                            .eqOrNull(
                              'reccestageid',
                              widget!.recestageId,
                            )
                            .eqOrNull(
                              'stageno',
                              2,
                            ),
                      ),
                      builder: (context, snapshot) {
                        // Customize what your widget looks like when it's loading.
                        if (!snapshot.hasData) {
                          return Center(
                            child: SizedBox(
                              width: 50.0,
                              height: 50.0,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  FlutterFlowTheme.of(context).primary,
                                ),
                              ),
                            ),
                          );
                        }
                        List<RecceresponsesRow> columnRecceresponsesRowList =
                            snapshot.data!;

                        final columnRecceresponsesRow =
                            columnRecceresponsesRowList.isNotEmpty
                                ? columnRecceresponsesRowList.first
                                : null;

                        return SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Padding(
                              //   padding: EdgeInsetsDirectional.fromSTEB(
                              //       16.0, 12.0, 16.0, 12.0),
                              //   child: SingleChildScrollView(
                              //     child: Column(
                              //       mainAxisSize: MainAxisSize.max,
                              //       crossAxisAlignment:
                              //           CrossAxisAlignment.start,
                              //       children: [
                              //         // Row(
                              //         //   mainAxisSize: MainAxisSize.max,
                              //         //   mainAxisAlignment:
                              //         //       MainAxisAlignment.spaceBetween,
                              //         //   crossAxisAlignment:
                              //         //       CrossAxisAlignment.center,
                              //         //   children: [
                              //         //     // FlutterFlowIconButton(
                              //         //     //   borderRadius: 8.0,
                              //         //     //   buttonSize: 40.0,
                              //         //     //   icon: Icon(
                              //         //     //     Icons.arrow_back,
                              //         //     //     color:
                              //         //     //         FlutterFlowTheme.of(context)
                              //         //     //             .primary,
                              //         //     //     size: 24.0,
                              //         //     //   ),
                              //         //     //   onPressed: () {
                              //         //     //     print('IconButton pressed ...');
                              //         //     //   },
                              //         //     // ),
                              //         //     Text(
                              //         //       valueOrDefault<String>(
                              //         //         widget!.projectName,
                              //         //         'Project Name',
                              //         //       ),
                              //         //       style: FlutterFlowTheme.of(context)
                              //         //           .displaySmall
                              //         //           .override(
                              //         //             font: GoogleFonts.interTight(
                              //         //               fontWeight:
                              //         //                   FlutterFlowTheme.of(
                              //         //                           context)
                              //         //                       .displaySmall
                              //         //                       .fontWeight,
                              //         //               fontStyle:
                              //         //                   FlutterFlowTheme.of(
                              //         //                           context)
                              //         //                       .displaySmall
                              //         //                       .fontStyle,
                              //         //             ),
                              //         //             fontSize: 30.0,
                              //         //             letterSpacing: 0.0,
                              //         //             fontWeight:
                              //         //                 FlutterFlowTheme.of(
                              //         //                         context)
                              //         //                     .displaySmall
                              //         //                     .fontWeight,
                              //         //             fontStyle:
                              //         //                 FlutterFlowTheme.of(
                              //         //                         context)
                              //         //                     .displaySmall
                              //         //                     .fontStyle,
                              //         //           ),
                              //         //     ).animateOnPageLoad(animationsMap[
                              //         //         'textOnPageLoadAnimation1']!),
                              //         //   ],
                              //         // ),
                              //         Divider(
                              //           height: 24.0,
                              //           thickness: 1.0,
                              //           color: Color(0xFFE0E3E7),
                              //         ).animateOnPageLoad(animationsMap[
                              //             'dividerOnPageLoadAnimation']!),
                              //         Padding(
                              //           padding: EdgeInsetsDirectional.fromSTEB(
                              //               12.0, 24.0, 0.0, 0.0),
                              //           child: Text(
                              //             'Recce Details',
                              //             style: FlutterFlowTheme.of(context)
                              //                 .labelLarge
                              //                 .override(
                              //                   font: GoogleFonts.inter(
                              //                     fontWeight: FontWeight.w600,
                              //                     fontStyle:
                              //                         FlutterFlowTheme.of(
                              //                                 context)
                              //                             .labelLarge
                              //                             .fontStyle,
                              //                   ),
                              //                   fontSize: 18.0,
                              //                   letterSpacing: 0.0,
                              //                   fontWeight: FontWeight.w600,
                              //                   fontStyle:
                              //                       FlutterFlowTheme.of(context)
                              //                           .labelLarge
                              //                           .fontStyle,
                              //                 ),
                              //           ).animateOnPageLoad(animationsMap[
                              //               'textOnPageLoadAnimation2']!),
                              //         ),
                              //       ],
                              //     ),
                              //   ),
                              // ),
                              if (responsiveVisibility(
                                context: context,
                                phone: false,
                                tablet: false,
                                tabletLandscape: false,
                                desktop: false,
                              ))
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      24.0, 12.0, 24.0, 12.0),
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      context.pushNamed(QueryWidget.routeName);
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 4.0,
                                            color: Color(0x33000000),
                                            offset: Offset(
                                              0.0,
                                              2.0,
                                            ),
                                          )
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            5.0, 0.0, 5.0, 0.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text(
                                              'Click here to upload designs',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .titleSmall
                                                  .override(
                                                    font:
                                                        GoogleFonts.interTight(
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleSmall
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleSmall
                                                              .fontStyle,
                                                    ),
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .titleSmall
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .titleSmall
                                                            .fontStyle,
                                                  ),
                                            ),
                                          ]
                                              .divide(SizedBox(height: 15.0))
                                              .around(SizedBox(height: 15.0)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              // ClipRRect(
                              //   borderRadius: BorderRadius.circular(8.0),
                              //   child: Image.asset(
                              //     'assets/images/sdr.png',
                              //     width: 100.0,
                              //     height: 100.0,
                              //     fit: BoxFit.cover,
                              //   ),
                              // ),
                              if ((sdrDetailPageReccetemplatesRow?.projectid !=
                                      widget!.projectId) &&
                                  responsiveVisibility(
                                    context: context,
                                    phone: false,
                                    tablet: false,
                                    tabletLandscape: false,
                                    desktop: false,
                                  ))
                                Align(
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        28.0, 12.0, 28.0, 12.0),
                                    child:
                                        FutureBuilder<List<ReccetemplatesRow>>(
                                      future:
                                          ReccetemplatesTable().querySingleRow(
                                        queryFn: (q) => q.eqOrNull(
                                          'projectid',
                                          widget!.projectId,
                                        ),
                                      ),
                                      builder: (context, snapshot) {
                                        // Customize what your widget looks like when it's loading.
                                        if (!snapshot.hasData) {
                                          return Center(
                                            child: SizedBox(
                                              width: 50.0,
                                              height: 50.0,
                                              child: CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                        List<ReccetemplatesRow>
                                            makeDynamicRecceButtonReccetemplatesRowList =
                                            snapshot.data!;

                                        final makeDynamicRecceButtonReccetemplatesRow =
                                            makeDynamicRecceButtonReccetemplatesRowList
                                                    .isNotEmpty
                                                ? makeDynamicRecceButtonReccetemplatesRowList
                                                    .first
                                                : null;

                                        return FFButtonWidget(
                                          onPressed: () async {},
                                          text: 'Make Dynamic Recce Template',
                                          icon: Icon(
                                            Icons.view_day,
                                            size: 15.0,
                                          ),
                                          options: FFButtonOptions(
                                            width: double.infinity,
                                            height: 45.0,
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16.0, 0.0, 16.0, 0.0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: FlutterFlowTheme.of(context)
                                                .secondary,
                                            textStyle: FlutterFlowTheme.of(
                                                    context)
                                                .titleSmall
                                                .override(
                                                  font: GoogleFonts.interTight(
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .titleSmall
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .titleSmall
                                                            .fontStyle,
                                                  ),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleSmall
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleSmall
                                                          .fontStyle,
                                                ),
                                            elevation: 0.0,
                                            borderRadius:
                                                BorderRadius.circular(32.0),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 8.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 2.0, 12.0, 2.0),
                                      child: Text(
                                        'Select the project',
                                        style: FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .override(
                                              font: GoogleFonts.interTight(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .titleMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .titleMedium
                                                        .fontStyle,
                                              ),
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .titleMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .titleMedium
                                                      .fontStyle,
                                            ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 0.0, 12.0, 5.0),
                                      child: FutureBuilder<List<ProjectsRow>>(
                                        future: FFAppState()
                                            .listOfProjectsOnDropDown(
                                          uniqueQueryKey:
                                              'listOfProjectsOnDropDown${currentUserUid}',
                                          requestFn: () =>
                                              ProjectsTable().queryRows(
                                            queryFn: (q) => q,
                                          ),
                                        ),
                                        builder: (context, snapshot) {
                                          // Customize what your widget looks like when it's loading.
                                          if (!snapshot.hasData) {
                                            return Center(
                                              child: SizedBox(
                                                width: 50.0,
                                                height: 50.0,
                                                child:
                                                    CircularProgressIndicator(
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                          Color>(
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                  ),
                                                ),
                                              ),
                                            );
                                          }
                                          List<ProjectsRow>
                                              dropDownProjectsRowList =
                                              snapshot.data!;

                                          return FlutterFlowDropDown<String>(
                                            controller: _model
                                                    .dropDownValueController ??=
                                                FormFieldController<String>(
                                              _model.dropDownValue ??=
                                                  widget.projectId,
                                            ),
                                            options: List<String>.from(
                                                dropDownProjectsRowList
                                                    .map((e) => e.projectid)
                                                    .toList()),
                                            optionLabels:
                                                dropDownProjectsRowList
                                                    .map((e) => e.name)
                                                    .toList(),
                                            onChanged: (val) => safeSetState(
                                                () =>
                                                    _model.dropDownValue = val),
                                            width: double.infinity,
                                            height: 40.0,
                                            searchHintTextStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .override(
                                                      font: GoogleFonts.inter(
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .fontStyle,
                                                      ),
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .fontStyle,
                                                    ),
                                            searchTextStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                      font: GoogleFonts.inter(
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                    ),
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                      font: GoogleFonts.inter(
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                    ),
                                            hintText: 'Select Project',
                                            searchHintText: 'Search...',
                                            icon: Icon(
                                              Icons.keyboard_arrow_down_rounded,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              size: 24.0,
                                            ),
                                            fillColor:
                                                FlutterFlowTheme.of(context)
                                                    .secondaryBackground,
                                            elevation: 2.0,
                                            borderColor:
                                                FlutterFlowTheme.of(context)
                                                    .secondary,
                                            borderWidth: 0.0,
                                            borderRadius: 8.0,
                                            margin:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    12.0, 0.0, 12.0, 0.0),
                                            hidesUnderline: true,
                                            isOverButton: false,
                                            isSearchable: true,
                                            isMultiSelect: false,
                                          );
                                        },
                                      ),
                                    ),
                                  ]
                                      .divide(SizedBox(height: 10.0))
                                      .around(SizedBox(height: 10.0)),
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(0.0, 0.0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      28.0, 12.0, 28.0, 12.0),
                                  child: FFButtonWidget(
                                    onPressed: () async {
                                      context.pushNamed(
                                        ReceTemplateWidget.routeName,
                                        queryParameters: {
                                          'projectID': serializeParam(
                                            _model.dropDownValue,
                                            ParamType.String,
                                          ),
                                          'reccestageid': serializeParam(
                                            widget!.recestageId,
                                            ParamType.String,
                                          ),
                                          'projectName': serializeParam(
                                            widget!.projectName,
                                            ParamType.String,
                                          ),
                                        }.withoutNulls,
                                      );
                                    },
                                    text: 'Launch Recce Form',
                                    icon: Icon(
                                      Icons.border_color,
                                      size: 15.0,
                                    ),
                                    options: FFButtonOptions(
                                      width: double.infinity,
                                      height: 45.0,
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16.0, 0.0, 16.0, 0.0),
                                      iconPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 0.0, 0.0),
                                      color: FlutterFlowTheme.of(context)
                                          .secondary,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .override(
                                            font: GoogleFonts.interTight(
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmall
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmall
                                                      .fontStyle,
                                            ),
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .fontStyle,
                                          ),
                                      elevation: 0.0,
                                      borderRadius: BorderRadius.circular(32.0),
                                    ),
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
                                Align(
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 12.0, 12.0, 12.0),
                                    child: FutureBuilder<List<ProjectsRow>>(
                                      future: ProjectsTable().querySingleRow(
                                        queryFn: (q) => q.eqOrNull(
                                          'projectid',
                                          widget!.projectId,
                                        ),
                                      ),
                                      builder: (context, snapshot) {
                                        // Customize what your widget looks like when it's loading.
                                        if (!snapshot.hasData) {
                                          return Center(
                                            child: SizedBox(
                                              width: 50.0,
                                              height: 50.0,
                                              child: CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                        List<ProjectsRow>
                                            buttonProjectsRowList =
                                            snapshot.data!;

                                        final buttonProjectsRow =
                                            buttonProjectsRowList.isNotEmpty
                                                ? buttonProjectsRowList.first
                                                : null;

                                        return FFButtonWidget(
                                          onPressed: () async {
                                            try {
                                              final fileUrl = await actions.storePdfDatabase(
                                                widget!.projectId!,
                                              );
                                              if (fileUrl == null ||
                                                  fileUrl.isEmpty ||
                                                  (fileUrl is String && fileUrl.startsWith('Error:'))) {
                                                throw Exception('PDF generation failed: $fileUrl');
                                              }

                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    'Report created successfully',
                                                    style: TextStyle(
                                                      color: FlutterFlowTheme.of(context).primaryText,
                                                    ),
                                                  ),
                                                  duration: Duration(milliseconds: 4000),
                                                  backgroundColor: FlutterFlowTheme.of(context).secondary,
                                                ),
                                              );

                                              final filename = _makeProjectReportFilename(widget!.projectName, widget!.projectId);
                                              final urlStr = fileUrl.toString();

                                              Future<Uint8List> _getBytesFromUrl(String u) async {
                                                if (u.startsWith('data:')) {
                                                  final base64Part = u.split(',').last;
                                                  return base64Decode(base64Part);
                                                }
                                                final resp = await http.get(Uri.parse(u));
                                                if (resp.statusCode != 200) {
                                                  throw Exception('Failed to fetch file, status ${resp.statusCode}');
                                                }
                                                return resp.bodyBytes;
                                              }

                                              final bytes = await _getBytesFromUrl(urlStr);

                                              if (kIsWeb) {
                                                await webDownload(bytes, filename);
                                              } else {
                                                final tmpDir = await getTemporaryDirectory();
                                                final safeName = filename.replaceAll(RegExp(r'[\\/:"*?<>|]+'), '_');
                                                final file = File('${tmpDir.path}/$safeName');
                                                await file.writeAsBytes(bytes, flush: true);
                                                await OpenFilex.open(file.path);
                                              }

                                              safeSetState(() {});
                                            } catch (e) {
                                              print('store+fetch+download failed: $e');
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(content: Text('Failed to create/download report: ${e.toString()}')),
                                              );
                                            }
                                          },
                                          text: 'Download Report',
                                          icon: Icon(
                                            Icons.download_rounded,
                                            size: 24.0,
                                          ),
                                          options: FFButtonOptions(
                                            width: double.infinity,
                                            height: 45.0,
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16.0, 0.0, 16.0, 0.0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: FlutterFlowTheme.of(context)
                                                .secondary,
                                            textStyle: FlutterFlowTheme.of(
                                                    context)
                                                .titleSmall
                                                .override(
                                                  font: GoogleFonts.interTight(
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .titleSmall
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .titleSmall
                                                            .fontStyle,
                                                  ),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleSmall
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleSmall
                                                          .fontStyle,
                                                ),
                                            elevation: 0.0,
                                            borderRadius:
                                                BorderRadius.circular(32.0),
                                          ),
                                        );
                                      },
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
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      28.0, 12.0, 28.0, 12.0),
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'button clicked',
                                            style: TextStyle(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                            ),
                                          ),
                                          duration:
                                              Duration(milliseconds: 4000),
                                          backgroundColor:
                                              FlutterFlowTheme.of(context)
                                                  .secondary,
                                        ),
                                      );
                                      _model.flatJson =
                                          await actions.flattenJsonChildrenOnly(
                                        columnRecceresponsesRow!.formjson,
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'successfull code return value',
                                            style: TextStyle(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                            ),
                                          ),
                                          duration:
                                              Duration(milliseconds: 4000),
                                          backgroundColor:
                                              FlutterFlowTheme.of(context)
                                                  .secondary,
                                        ),
                                      );
                                      await RecceresponsesTable().update(
                                        data: {
                                          'recceStraightJson': _model.flatJson,
                                        },
                                        matchingRows: (rows) => rows.eqOrNull(
                                          'recceresponseid',
                                          // Use the variable defined above (columnRecceresponsesRow)
                                          columnRecceresponsesRow
                                              ?.recceresponseid,
                                        ),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Successfully row updated',
                                            style: TextStyle(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                            ),
                                          ),
                                          duration:
                                              Duration(milliseconds: 4000),
                                          backgroundColor:
                                              FlutterFlowTheme.of(context)
                                                  .secondary,
                                        ),
                                      );

                                      context.pushNamed(
                                        ReceDetailsWidget.routeName,
                                        queryParameters: {
                                          'projectId': serializeParam(
                                            widget!.projectId,
                                            ParamType.String,
                                          ),
                                          'projectName': serializeParam(
                                            widget!.projectName,
                                            ParamType.String,
                                          ),
                                          'proectImage': serializeParam(
                                            widget!.proectImage,
                                            ParamType.String,
                                          ),
                                          'recestageId': serializeParam(
                                            widget!.recestageId,
                                            ParamType.String,
                                          ),
                                          'recceflatJson': serializeParam(
                                            columnRecceresponsesRow
                                                ?.recceStraightJson,
                                            ParamType.JSON,
                                          ),
                                          'receresponseid': serializeParam(
                                            columnRecceresponsesRow
                                                ?.recceresponseid,
                                            ParamType.String,
                                          ),
                                        }.withoutNulls,
                                      );

                                      safeSetState(() {});
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .alternate,
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        border: Border.all(
                                          color: FlutterFlowTheme.of(context)
                                              .secondary,
                                          width: 0.5,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            1.0, 0.0, 1.0, 0.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text(
                                              'View Client Recce Details',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .titleSmall
                                                  .override(
                                                    font:
                                                        GoogleFonts.interTight(
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleSmall
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleSmall
                                                              .fontStyle,
                                                    ),
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .titleSmall
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .titleSmall
                                                            .fontStyle,
                                                  ),
                                            ),
                                          ]
                                              .divide(SizedBox(height: 15.0))
                                              .around(SizedBox(height: 15.0)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    28.0, 12.0, 28.0, 12.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    context.pushNamed(
                                      ReceTemplateListWidget.routeName,
                                      queryParameters: {
                                        'projectId': serializeParam(
                                          _model.dropDownValue,
                                          ParamType.String,
                                        ),
                                        'projectName': serializeParam(
                                          widget!.projectName,
                                          ParamType.String,
                                        ),
                                        'proectImage': serializeParam(
                                          widget!.proectImage,
                                          ParamType.String,
                                        ),
                                        'recestageId': serializeParam(
                                          widget!.recestageId,
                                          ParamType.String,
                                        ),
                                      }.withoutNulls,
                                    );

                                    FFAppState().clearReceTemplateList1CacheKey(
                                        'receTemplateList1${currentUserUid}');
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .alternate,
                                      borderRadius: BorderRadius.circular(8.0),
                                      border: Border.all(
                                        color: FlutterFlowTheme.of(context)
                                            .secondary,
                                        width: 0.5,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          1.0, 0.0, 1.0, 0.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text(
                                            'View Client Recce Details',
                                            style: FlutterFlowTheme.of(context)
                                                .titleSmall
                                                .override(
                                                  font: GoogleFonts.interTight(
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .titleSmall
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .titleSmall
                                                            .fontStyle,
                                                  ),
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleSmall
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleSmall
                                                          .fontStyle,
                                                ),
                                          ),
                                        ]
                                            .divide(SizedBox(height: 15.0))
                                            .around(SizedBox(height: 15.0)),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    24.0, 12.0, 24.0, 12.0),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                  ),
                                  child: Visibility(
                                    visible: responsiveVisibility(
                                      context: context,
                                      phone: false,
                                      tablet: false,
                                      tabletLandscape: false,
                                      desktop: false,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10.0, 0.0, 10.0, 0.0),
                                      child: RichText(
                                        textScaler:
                                            MediaQuery.of(context).textScaler,
                                        text: TextSpan(
                                          children: [],
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.inter(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                                letterSpacing: 0.0,
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Align(
                                    alignment: AlignmentDirectional(0.0, 0.0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          28.0, 12.0, 28.0, 12.0),
                                      child: FFButtonWidget(
                                        onPressed: () async {
                                          // Determine selected project id (dropdown selection has priority).
                                          final projId = (_model.dropDownValue?.isNotEmpty == true)
                                              ? _model.dropDownValue!
                                              : (widget?.projectId ?? '');
                                          if (projId.isEmpty) {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(content: Text('Please select a project')),
                                            );
                                            return;
                                          }

                                          try {
                                            // Call custom action that generates PDF and uploads to Supabase storage.
                                            final fileUrl = await actions.storePdfDatabase(projId);

                                            // action returns an error string on failure: handle that
                                            if (fileUrl == null || fileUrl.isEmpty || (fileUrl is String && fileUrl.startsWith('Error:'))) {
                                              throw Exception('PDF generation failed: $fileUrl');
                                            }

                                            // Use standardized filename: projectname_report.pdf
                                            String filename = _makeProjectReportFilename(widget?.projectName, projId);

                                            // If returned value is a data: URL already, handle it directly.
                                            final urlStr = fileUrl.toString();

                                            // Helper to get bytes either from HTTP URL or data: URL
                                            Future<Uint8List> _getBytesFromUrl(String u) async {
                                              if (u.startsWith('data:')) {
                                                final base64Part = u.split(',').last;
                                                return base64Decode(base64Part);
                                              }
                                              final resp = await http.get(Uri.parse(u));
                                              if (resp.statusCode != 200) {
                                                throw Exception('Failed to fetch file, status ${resp.statusCode}');
                                              }
                                              return resp.bodyBytes;
                                            }

                                            if (kIsWeb) {
                                              // For web use the conditional web helper
                                              final bytes = await _getBytesFromUrl(urlStr);
                                              await webDownload(bytes, filename);
                                            } else {
                                              // Mobile/desktop: write bytes to a temporary file and open it
                                              final bytes = await _getBytesFromUrl(urlStr);
                                              final tmpDir = await getTemporaryDirectory();
                                              final safeName = filename.replaceAll(RegExp(r'[\\/:"*?<>|]+'), '_');
                                              final file = File('${tmpDir.path}/$safeName');
                                              await file.writeAsBytes(bytes, flush: true);
                                              // Open the file with the default PDF viewer (or let the user choose)
                                              await OpenFilex.open(file.path);
                                            }

                                            ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(content: Text('Report downloaded')),
                                            );
                                          } catch (e, st) {
                                            print('store+fetch+download failed: $e\n$st');
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(content: Text('Failed to create/download report: ${e.toString()}')),
                                            );
                                          } finally {
                                            safeSetState(() {});
                                          }
                                        },
                                        text: 'Download SDR PDF',
                                        icon: Icon(
                                          Icons.download_sharp,
                                          size: 15.0,
                                        ),
                                        options: FFButtonOptions(
                                          width: double.infinity,
                                          height: 45.0,
                                          padding: EdgeInsetsDirectional.fromSTEB(
                                              16.0, 0.0, 16.0, 0.0),
                                          iconPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 0.0),
                                          color: FlutterFlowTheme.of(context)
                                              .secondary,
                                          textStyle: FlutterFlowTheme.of(context)
                                              .titleSmall
                                              .override(
                                                font: GoogleFonts.interTight(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleSmall
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleSmall
                                                          .fontStyle,
                                                ),
                                                color: FlutterFlowTheme.of(
                                                        context)
                                                    .secondaryBackground,
                                                letterSpacing: 0.0,
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .titleSmall
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .titleSmall
                                                        .fontStyle,
                                              ),
                                          elevation: 0.0,
                                          borderRadius: BorderRadius.circular(32.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                  if ((sdrDetailPageReccetemplatesRow
                                              ?.projectid ==
                                          widget!.projectId) &&
                                      responsiveVisibility(
                                        context: context,
                                        phone: false,
                                        tablet: false,
                                        tabletLandscape: false,
                                        desktop: false,
                                      ))
                                    Align(
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            28.0, 12.0, 28.0, 12.0),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            await actions
                                                .generatePPTFromTemplate(
                                              '10tTHwFJ5b41DRZx5e3Nx8l7DBhTTZzTLJCPg682bR',
                                              '',
                                              'SDR',
                                            );
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  'Report created successfully',
                                                  style: TextStyle(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                  ),
                                                ),
                                                duration: Duration(
                                                    milliseconds: 4000),
                                                backgroundColor:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
                                              ),
                                            );
                                          },
                                          text: 'Download SDR PPT',
                                          icon: Icon(
                                            Icons.download_sharp,
                                            size: 15.0,
                                          ),
                                          options: FFButtonOptions(
                                            width: double.infinity,
                                            height: 45.0,
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16.0, 0.0, 16.0, 0.0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: FlutterFlowTheme.of(context)
                                                .secondary,
                                            textStyle: FlutterFlowTheme.of(
                                                    context)
                                                .titleSmall
                                                .override(
                                                  font: GoogleFonts.interTight(
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .titleSmall
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .titleSmall
                                                            .fontStyle,
                                                  ),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleSmall
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleSmall
                                                          .fontStyle,
                                                ),
                                            elevation: 0.0,
                                            borderRadius: BorderRadius.circular(32.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
