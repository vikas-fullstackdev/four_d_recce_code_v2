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
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'home_page_model.dart';
export 'home_page_model.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({
    super.key,
    this.projectType,
  });

  final String? projectType;

  static String routeName = 'HomePage';
  static String routePath = '/homePage';

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  late HomePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.timerController.timer.setPresetTime(mSec: 3000, add: false);
      _model.timerController.onResetTimer();

      _model.timerController.onStartTimer();
      _model.listOfProjectsOnHomePageLoad = await ProjectsTable().queryRows(
        queryFn: (q) => q,
      );
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
    context.watch<FFAppState>();

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
                'Project List',
                style: FlutterFlowTheme.of(context).titleMedium.override(
                      font: GoogleFonts.interTight(
                        fontWeight: FontWeight.w600,
                        fontStyle:
                            FlutterFlowTheme.of(context).titleMedium.fontStyle,
                      ),
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w600,
                      fontStyle:
                          FlutterFlowTheme.of(context).titleMedium.fontStyle,
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
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 0.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  // Container(
                  //   width: double.infinity,
                  //   height: 1.0,
                  //   decoration: BoxDecoration(
                  //     color: FlutterFlowTheme.of(context).secondary,
                  //   ),
                  // ),
                  FutureBuilder<List<UserRolesRow>>(
                    future: FFAppState().userIdInTheHomePage(
                      uniqueQueryKey: 'userIdinTheHomePage${currentUserUid}',
                      requestFn: () => UserRolesTable().queryRows(
                        queryFn: (q) => q.eqOrNull(
                          'user_id',
                          currentUserUid,
                        ),
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
                      List<UserRolesRow> containerUserRolesRowList =
                          snapshot.data!;

                      return Container(
                        decoration: BoxDecoration(),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 20.0, 16.0, 0.0),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(0.0),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  width: double.infinity,
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.2,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 3.0,
                                        color: Color(0x411D2429),
                                        offset: Offset(
                                          0.0,
                                          1.0,
                                        ),
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(12.0),
                                    border: Border.all(
                                      color: Color(0xFFBCB5B5),
                                      width: 0.5,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            20.0, 20.0, 20.0, 20.0),
                                        child: Text(
                                          'Let\'s start a new project',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.inter(
                                                  fontWeight: FontWeight.w500,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                                fontSize: 20.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w500,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  10.0, 0.0, 10.0, 10.0),
                                          child: FFButtonWidget(
                                            onPressed: () async {
                                              context.pushNamed(
                                                AddprojectWidget.routeName,
                                                queryParameters: {
                                                  'projectType': serializeParam(
                                                    widget!.projectType,
                                                    ParamType.String,
                                                  ),
                                                }.withoutNulls,
                                              );
                                            },
                                            text: 'Add Project',
                                            icon: Icon(
                                              Icons.add,
                                              size: 15.0,
                                            ),
                                            options: FFButtonOptions(
                                              width: double.infinity,
                                              height: 45.0,
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      16.0, 0.0, 16.0, 0.0),
                                              iconPadding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 0.0, 0.0),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondary,
                                              textStyle: FlutterFlowTheme.of(
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
                      );
                    },
                  ),
                  FutureBuilder<List<UserRolesRow>>(
                    future: FFAppState().listContainerUserId(
                      uniqueQueryKey: 'listContainerUserId${currentUserUid}',
                      requestFn: () => UserRolesTable().queryRows(
                        queryFn: (q) => q.eqOrNull(
                          'user_id',
                          currentUserUid,
                        ),
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
                      List<UserRolesRow> containerUserRolesRowList =
                          snapshot.data!;

                      return Container(
                        decoration: BoxDecoration(),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 16.0, 0.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Padding(
                              //   padding: EdgeInsetsDirectional.fromSTEB(
                              //       0.0, 20.0, 0.0, 0.0),
                              //   child: Row(
                              //     mainAxisSize: MainAxisSize.max,
                              //     mainAxisAlignment: MainAxisAlignment.start,
                              //     children: [
                              //       Flexible(
                              //         child: InkWell(
                              //           splashColor: Colors.transparent,
                              //           focusColor: Colors.transparent,
                              //           hoverColor: Colors.transparent,
                              //           highlightColor: Colors.transparent,
                              //           onTap: () async {
                              //             _model.status = 'new';
                              //             safeSetState(() {});
                              //           },
                              //           child: Text(
                              //             'Pending Projects',
                              //             style: FlutterFlowTheme.of(context)
                              //                 .bodyMedium
                              //                 .override(
                              //                   font: GoogleFonts.inter(
                              //                     fontWeight:
                              //                         FlutterFlowTheme.of(
                              //                                 context)
                              //                             .bodyMedium
                              //                             .fontWeight,
                              //                     fontStyle:
                              //                         FlutterFlowTheme.of(
                              //                                 context)
                              //                             .bodyMedium
                              //                             .fontStyle,
                              //                   ),
                              //                   fontSize: 17.0,
                              //                   letterSpacing: 0.0,
                              //                   fontWeight:
                              //                       FlutterFlowTheme.of(context)
                              //                           .bodyMedium
                              //                           .fontWeight,
                              //                   fontStyle:
                              //                       FlutterFlowTheme.of(context)
                              //                           .bodyMedium
                              //                           .fontStyle,
                              //                 ),
                              //           ),
                              //         ),
                              //       ),
                              //       Text(
                              //         '|',
                              //         style: FlutterFlowTheme.of(context)
                              //             .bodyMedium
                              //             .override(
                              //               font: GoogleFonts.inter(
                              //                 fontWeight:
                              //                     FlutterFlowTheme.of(context)
                              //                         .bodyMedium
                              //                         .fontWeight,
                              //                 fontStyle:
                              //                     FlutterFlowTheme.of(context)
                              //                         .bodyMedium
                              //                         .fontStyle,
                              //               ),
                              //               fontSize: 18.0,
                              //               letterSpacing: 0.0,
                              //               fontWeight:
                              //                   FlutterFlowTheme.of(context)
                              //                       .bodyMedium
                              //                       .fontWeight,
                              //               fontStyle:
                              //                   FlutterFlowTheme.of(context)
                              //                       .bodyMedium
                              //                       .fontStyle,
                              //             ),
                              //       ),
                              //       Flexible(
                              //         child: InkWell(
                              //           splashColor: Colors.transparent,
                              //           focusColor: Colors.transparent,
                              //           hoverColor: Colors.transparent,
                              //           highlightColor: Colors.transparent,
                              //           onTap: () async {
                              //             _model.status = 'completed';
                              //             safeSetState(() {});
                              //           },
                              //           child: Text(
                              //             'Completed Projects',
                              //             style: FlutterFlowTheme.of(context)
                              //                 .bodyMedium
                              //                 .override(
                              //                   font: GoogleFonts.inter(
                              //                     fontWeight:
                              //                         FlutterFlowTheme.of(
                              //                                 context)
                              //                             .bodyMedium
                              //                             .fontWeight,
                              //                     fontStyle:
                              //                         FlutterFlowTheme.of(
                              //                                 context)
                              //                             .bodyMedium
                              //                             .fontStyle,
                              //                   ),
                              //                   fontSize: 17.0,
                              //                   letterSpacing: 0.0,
                              //                   fontWeight:
                              //                       FlutterFlowTheme.of(context)
                              //                           .bodyMedium
                              //                           .fontWeight,
                              //                   fontStyle:
                              //                       FlutterFlowTheme.of(context)
                              //                           .bodyMedium
                              //                           .fontStyle,
                              //                 ),
                              //           ),
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              Align(
                                alignment: AlignmentDirectional(0.0, 0.0),
                                child: FutureBuilder<List<ProjectsRow>>(
                                  future: FFAppState().projectList(
                                    uniqueQueryKey:
                                        'projectList${currentUserUid}',
                                    requestFn: () => ProjectsTable().queryRows(
                                      queryFn: (q) => q
                                          .eqOrNull(
                                            'project_type',
                                            widget!.projectType,
                                          )
                                          .order('createdat'),
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
                                                AlwaysStoppedAnimation<Color>(
                                              FlutterFlowTheme.of(context)
                                                  .primary,
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                    List<ProjectsRow> listViewProjectsRowList =
                                        snapshot.data!;

                                    return ListView.builder(
                                      padding: EdgeInsets.zero,
                                      primary: false,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: listViewProjectsRowList.length,
                                      itemBuilder: (context, listViewIndex) {
                                        final listViewProjectsRow =
                                            listViewProjectsRowList[
                                                listViewIndex];
                                        return Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(
                                              1.0, 12.0, 1.0, 0.0),
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              FFAppState().clearProjectDetailScreenColumnCacheKey(
                                                  'projectDetailScreenColumn${currentUserUid}');
                                              context.pushNamed(
                                                ProjectDetailPageWidget.routeName,
                                                queryParameters: {
                                                  'projectId': serializeParam(
                                                    listViewProjectsRow.projectid,
                                                    ParamType.String,
                                                  ),
                                                  'projectName': serializeParam(
                                                    listViewProjectsRow.name,
                                                    ParamType.String,
                                                  ),
                                                  'proectImage': serializeParam(
                                                    '',
                                                    ParamType.String,
                                                  ),
                                                }.withoutNulls,
                                              );
                                            },
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(12.0),
                                              ),
                                              color: FlutterFlowTheme.of(context).secondaryBackground,
                                              child: ListTile(
                                                contentPadding: EdgeInsets.all(8.0),
                                                leading: ClipRRect(
                                                  borderRadius: BorderRadius.circular(8.0),
                                                  child: Image.network(
                                                    listViewProjectsRow.clientLogo ??
                                                        'https://via.placeholder.com/70x100',
                                                    width: 70.0,
                                                    height: 100.0,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                title: Text(
                                                  '${listViewProjectsRow.name}',
                                                  style: FlutterFlowTheme.of(context).titleLarge,
                                                ),
                                                subtitle: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    if ((listViewProjectsRow.addressOfSite ?? '').isNotEmpty)
                                                      Text(
                                                        '${listViewProjectsRow.addressOfSite}',
                                                        style: FlutterFlowTheme.of(context).bodySmall,
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                    Text(
                                                      valueOrDefault<String>(
                                                        listViewProjectsRow.projectCode,
                                                        'Project code',
                                                      ),
                                                      style: FlutterFlowTheme.of(context).bodySmall,
                                                    ),
                                                  ],
                                                ),
                                                trailing: Icon(
                                                  Icons.chevron_right_rounded,
                                                  color: FlutterFlowTheme.of(context).secondaryText,
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ]
                                .divide(SizedBox(height: 5.0))
                                .addToStart(SizedBox(height: 0.0))
                                .addToEnd(SizedBox(height: 0.0)),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
