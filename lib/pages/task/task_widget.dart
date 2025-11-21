import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/components/task_component_admin_widget.dart';
import '/components/task_component_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'task_model.dart';
export 'task_model.dart';

class TaskWidget extends StatefulWidget {
  const TaskWidget({
    super.key,
    this.projectID,
  });

  final String? projectID;

  static String routeName = 'task';
  static String routePath = '/task';

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> with TickerProviderStateMixin {
  late TaskModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TaskModel());

    animationsMap.addAll({
      'textOnPageLoadAnimation': AnimationInfo(
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
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(14.0, 10.0, 0.0, 20.0),
                  child: FlutterFlowIconButton(
                    borderColor: Color(0xFF707476),
                    borderRadius: 30.0,
                    borderWidth: 1.0,
                    buttonSize: 40.0,
                    icon: Icon(
                      Icons.arrow_back,
                      color: FlutterFlowTheme.of(context).primaryText,
                      size: 24.0,
                    ),
                    onPressed: () async {
                      context.safePop();
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(14.0, 0.0, 0.0, 20.0),
                  child: Text(
                    'Task',
                    style: FlutterFlowTheme.of(context).displaySmall.override(
                          font: GoogleFonts.interTight(
                            fontWeight: FlutterFlowTheme.of(context)
                                .displaySmall
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .displaySmall
                                .fontStyle,
                          ),
                          fontSize: 30.0,
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context)
                              .displaySmall
                              .fontWeight,
                          fontStyle: FlutterFlowTheme.of(context)
                              .displaySmall
                              .fontStyle,
                        ),
                  ).animateOnPageLoad(
                      animationsMap['textOnPageLoadAnimation']!),
                ),
                FutureBuilder<List<UserRolesRow>>(
                  future: UserRolesTable().queryRows(
                    queryFn: (q) => q.eqOrNull(
                      'user_id',
                      currentUserUid,
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
                      child: Visibility(
                        visible: functions
                                .getHighestPriorityRole(
                                    containerUserRolesRowList
                                        .map((e) => e.roleId)
                                        .withoutNulls
                                        .toList())
                                .toString() !=
                            '1',
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              14.0, 0.0, 14.0, 0.0),
                          child: FutureBuilder<List<RecceresponsesRow>>(
                            future: RecceresponsesTable().queryRows(
                              queryFn: (q) => q
                                  .eqOrNull(
                                    'stageNo',
                                    11,
                                  )
                                  .eqOrNull(
                                    'projectid',
                                    widget!.projectID,
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
                              List<RecceresponsesRow>
                                  listViewRecceresponsesRowList =
                                  snapshot.data!;

                              return ListView.separated(
                                padding: EdgeInsets.symmetric(vertical: 10.0),
                                primary: false,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: listViewRecceresponsesRowList.length,
                                separatorBuilder: (_, __) =>
                                    SizedBox(height: 10.0),
                                itemBuilder: (context, listViewIndex) {
                                  final listViewRecceresponsesRow =
                                      listViewRecceresponsesRowList[
                                          listViewIndex];
                                  return Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      borderRadius: BorderRadius.circular(8.0),
                                      border: Border.all(
                                        color: FlutterFlowTheme.of(context)
                                            .secondary,
                                        width: 0.5,
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        FutureBuilder<List<ReccestagesRow>>(
                                          future:
                                              ReccestagesTable().querySingleRow(
                                            queryFn: (q) => q.eqOrNull(
                                              'reccestageid',
                                              listViewRecceresponsesRow
                                                  .reccestageid,
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
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .primary,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }
                                            List<ReccestagesRow>
                                                rowReccestagesRowList =
                                                snapshot.data!;

                                            final rowReccestagesRow =
                                                rowReccestagesRowList.isNotEmpty
                                                    ? rowReccestagesRowList
                                                        .first
                                                    : null;

                                            return Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(12.0, 10.0,
                                                          12.0, 10.0),
                                                  child: FutureBuilder<
                                                      List<ProjectsRow>>(
                                                    future: ProjectsTable()
                                                        .querySingleRow(
                                                      queryFn: (q) =>
                                                          q.eqOrNull(
                                                        'projectid',
                                                        rowReccestagesRow
                                                            ?.projectid,
                                                      ),
                                                    ),
                                                    builder:
                                                        (context, snapshot) {
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
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .primary,
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      }
                                                      List<ProjectsRow>
                                                          rowProjectsRowList =
                                                          snapshot.data!;

                                                      final rowProjectsRow =
                                                          rowProjectsRowList
                                                                  .isNotEmpty
                                                              ? rowProjectsRowList
                                                                  .first
                                                              : null;

                                                      return Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.0),
                                                            child:
                                                                Image.network(
                                                              rowProjectsRow!
                                                                  .clientLogo!,
                                                              width: 50.0,
                                                              height: 50.0,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        10.0,
                                                                        0.0,
                                                                        10.0,
                                                                        0.0),
                                                            child: Text(
                                                              valueOrDefault<
                                                                  String>(
                                                                rowProjectsRow
                                                                    ?.name,
                                                                'Project Name',
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .headlineSmall
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .interTight(
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .headlineSmall
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .headlineSmall
                                                                          .fontStyle,
                                                                    ),
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .headlineSmall
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .headlineSmall
                                                                        .fontStyle,
                                                                  ),
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                        Container(
                                          child: Builder(
                                            builder: (context) {
                                              final taskVariable = getJsonField(
                                                listViewRecceresponsesRow
                                                    .formjson,
                                                r'''$.task''',
                                              ).toList();

                                              return ListView.builder(
                                                padding: EdgeInsets.zero,
                                                primary: false,
                                                shrinkWrap: true,
                                                scrollDirection: Axis.vertical,
                                                itemCount: taskVariable.length,
                                                itemBuilder: (context,
                                                    taskVariableIndex) {
                                                  final taskVariableItem =
                                                      taskVariable[
                                                          taskVariableIndex];
                                                  return TaskComponentWidget(
                                                    key: Key(
                                                        'Keyxaw_${taskVariableIndex}_of_${taskVariable.length}'),
                                                    assignedto: getJsonField(
                                                      taskVariableItem,
                                                      r'''$.assigned_to''',
                                                    ).toString(),
                                                    taskname: (getJsonField(
                                                      taskVariableItem,
                                                      r'''$.task_name''',
                                                      true,
                                                    ) as List?)!
                                                        .map<String>(
                                                            (e) => e.toString())
                                                        .toList()
                                                        .cast<String>(),
                                                    receresponseId:
                                                        listViewRecceresponsesRow
                                                            .recceresponseid,
                                                    formJson:
                                                        listViewRecceresponsesRow
                                                            .formjson,
                                                    taskIndex:
                                                        taskVariableIndex,
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
                FutureBuilder<List<UserRolesRow>>(
                  future: UserRolesTable().queryRows(
                    queryFn: (q) => q.eqOrNull(
                      'user_id',
                      currentUserUid,
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
                      child: Visibility(
                        visible: functions
                                .getHighestPriorityRole(
                                    containerUserRolesRowList
                                        .map((e) => e.roleId)
                                        .withoutNulls
                                        .toList())
                                .toString() ==
                            '1',
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              14.0, 0.0, 14.0, 0.0),
                          child: FutureBuilder<List<RecceresponsesRow>>(
                            future: RecceresponsesTable().queryRows(
                              queryFn: (q) => q
                                  .eqOrNull(
                                    'stageNo',
                                    11,
                                  )
                                  .eqOrNull(
                                    'projectid',
                                    widget!.projectID,
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
                              List<RecceresponsesRow>
                                  listViewRecceresponsesRowList =
                                  snapshot.data!;

                              return ListView.separated(
                                padding: EdgeInsets.symmetric(vertical: 10.0),
                                primary: false,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: listViewRecceresponsesRowList.length,
                                separatorBuilder: (_, __) =>
                                    SizedBox(height: 10.0),
                                itemBuilder: (context, listViewIndex) {
                                  final listViewRecceresponsesRow =
                                      listViewRecceresponsesRowList[
                                          listViewIndex];
                                  return Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      borderRadius: BorderRadius.circular(8.0),
                                      border: Border.all(
                                        color: FlutterFlowTheme.of(context)
                                            .secondary,
                                        width: 0.5,
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        FutureBuilder<List<ReccestagesRow>>(
                                          future:
                                              ReccestagesTable().querySingleRow(
                                            queryFn: (q) => q.eqOrNull(
                                              'reccestageid',
                                              listViewRecceresponsesRow
                                                  .reccestageid,
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
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .primary,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }
                                            List<ReccestagesRow>
                                                rowReccestagesRowList =
                                                snapshot.data!;

                                            final rowReccestagesRow =
                                                rowReccestagesRowList.isNotEmpty
                                                    ? rowReccestagesRowList
                                                        .first
                                                    : null;

                                            return Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(12.0, 10.0,
                                                          12.0, 10.0),
                                                  child: FutureBuilder<
                                                      List<ProjectsRow>>(
                                                    future: ProjectsTable()
                                                        .querySingleRow(
                                                      queryFn: (q) =>
                                                          q.eqOrNull(
                                                        'projectid',
                                                        rowReccestagesRow
                                                            ?.projectid,
                                                      ),
                                                    ),
                                                    builder:
                                                        (context, snapshot) {
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
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .primary,
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      }
                                                      List<ProjectsRow>
                                                          rowProjectsRowList =
                                                          snapshot.data!;

                                                      final rowProjectsRow =
                                                          rowProjectsRowList
                                                                  .isNotEmpty
                                                              ? rowProjectsRowList
                                                                  .first
                                                              : null;

                                                      return Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.0),
                                                            child:
                                                                Image.network(
                                                              rowProjectsRow!
                                                                  .clientLogo!,
                                                              width: 50.0,
                                                              height: 50.0,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        10.0,
                                                                        0.0,
                                                                        10.0,
                                                                        0.0),
                                                            child: Text(
                                                              valueOrDefault<
                                                                  String>(
                                                                rowProjectsRow
                                                                    ?.name,
                                                                'Project Name',
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .headlineSmall
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .interTight(
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .headlineSmall
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .headlineSmall
                                                                          .fontStyle,
                                                                    ),
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .headlineSmall
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .headlineSmall
                                                                        .fontStyle,
                                                                  ),
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                        Container(
                                          child: Builder(
                                            builder: (context) {
                                              final taskVariable = getJsonField(
                                                listViewRecceresponsesRow
                                                    .formjson,
                                                r'''$.task''',
                                              ).toList();

                                              return ListView.builder(
                                                padding: EdgeInsets.zero,
                                                primary: false,
                                                shrinkWrap: true,
                                                scrollDirection: Axis.vertical,
                                                itemCount: taskVariable.length,
                                                itemBuilder: (context,
                                                    taskVariableIndex) {
                                                  final taskVariableItem =
                                                      taskVariable[
                                                          taskVariableIndex];
                                                  return Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      if (responsiveVisibility(
                                                        context: context,
                                                        phone: false,
                                                        tablet: false,
                                                        tabletLandscape: false,
                                                        desktop: false,
                                                      ))
                                                        TaskComponentWidget(
                                                          key: Key(
                                                              'Key9z0_${taskVariableIndex}_of_${taskVariable.length}'),
                                                          assignedto:
                                                              getJsonField(
                                                            taskVariableItem,
                                                            r'''$.assigned_to''',
                                                          ).toString(),
                                                          taskname:
                                                              (getJsonField(
                                                            taskVariableItem,
                                                            r'''$.task_name''',
                                                            true,
                                                          ) as List?)!
                                                                  .map<String>(
                                                                      (e) => e
                                                                          .toString())
                                                                  .toList()
                                                                  .cast<
                                                                      String>(),
                                                          receresponseId:
                                                              listViewRecceresponsesRow
                                                                  .recceresponseid,
                                                          formJson:
                                                              listViewRecceresponsesRow
                                                                  .formjson,
                                                          taskIndex:
                                                              taskVariableIndex,
                                                        ),
                                                      TaskComponentAdminWidget(
                                                        key: Key(
                                                            'Keyfzk_${taskVariableIndex}_of_${taskVariable.length}'),
                                                        assignedto:
                                                            getJsonField(
                                                          taskVariableItem,
                                                          r'''$.assigned_to''',
                                                        ).toString(),
                                                        receresponseId:
                                                            listViewRecceresponsesRow
                                                                .recceresponseid,
                                                        taskIndex:
                                                            taskVariableIndex,
                                                        taskname: (getJsonField(
                                                          taskVariableItem,
                                                          r'''$.task_name''',
                                                          true,
                                                        ) as List?)!
                                                            .map<String>((e) =>
                                                                e.toString())
                                                            .toList()
                                                            .cast<String>(),
                                                        formJson:
                                                            listViewRecceresponsesRow
                                                                .formjson,
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          ),
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
    );
  }
}
