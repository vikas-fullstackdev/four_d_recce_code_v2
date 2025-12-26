import '/backend/supabase/supabase.dart';
import '/components/qc_detail_component_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'dart:ui';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'qc_details_history_model.dart';
export 'qc_details_history_model.dart';

class QcDetailsHistoryWidget extends StatefulWidget {
  const QcDetailsHistoryWidget({
    super.key,
    this.projectId,
    this.projectName,
    this.proectImage,
    required this.recestageId,
    required this.creatDate,
    required this.responseId,
    required this.historyId,
  });

  final String? projectId;
  final String? projectName;
  final String? proectImage;
  final String? recestageId;
  final DateTime? creatDate;
  final String? responseId;
  final String? historyId;

  static String routeName = 'qcDetailsHistory';
  static String routePath = '/qcDetailsHistory';

  @override
  State<QcDetailsHistoryWidget> createState() => _QcDetailsHistoryWidgetState();
}

class _QcDetailsHistoryWidgetState extends State<QcDetailsHistoryWidget>
    with TickerProviderStateMixin {
  late QcDetailsHistoryModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => QcDetailsHistoryModel());

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
      'textOnPageLoadAnimation3': AnimationInfo(
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

  String? _selectedProjectId;
  String? _selectedProjectName;

  Future<List<HistoryRow>> _fetchHistoryForProject(String? projectId) async {
    if (projectId == null) return [];
    if (projectId is String && projectId.trim().isEmpty) return [];

    // Try direct history lookup by projectid (if the column exists)
    try {
      final direct = await HistoryTable().queryRows(
        queryFn: (q) => q.eqOrNull('projectid', projectId).order('createdat', ascending: false),
      );
      if (direct.isNotEmpty) return direct;
    } catch (e) {
      // ignore and fallback
    }

    // Fallback: find responses for this project, then history for those responses
    final responses = await RecceresponsesTable().queryRows(
      queryFn: (q) => q.eqOrNull('projectid', projectId),
    );
    final responseIds = responses.map((r) => r.recceresponseid).whereType<String>().toList();
    if (responseIds.isEmpty) return [];
    final history = await HistoryTable().queryRows(
      queryFn: (q) => q.inFilterOrNull('recceresponseid', responseIds).order('createdat', ascending: false),
    );
    return history;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ReccetemplatesRow>>(
      future: ReccetemplatesTable().querySingleRow(
        queryFn: (q) => q.eqOrNull(
          'projectid',
          widget!.projectId,
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
        List<ReccetemplatesRow> qcDetailsHistoryReccetemplatesRowList =
            snapshot.data!;

        final qcDetailsHistoryReccetemplatesRow =
            qcDetailsHistoryReccetemplatesRowList.isNotEmpty
                ? qcDetailsHistoryReccetemplatesRowList.first
                : null;

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            appBar: AppBar(
              backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
              automaticallyImplyLeading: false,
              leading: FlutterFlowIconButton(
                borderColor: Colors.transparent,
                borderRadius: 30.0,
                borderWidth: 1.0,
                buttonSize: 60.0,
                icon: Icon(
                  Icons.arrow_back_rounded,
                  color: FlutterFlowTheme.of(context).secondaryText,
                  size: 30.0,
                ),
                onPressed: () async {
                  context.pop();
                },
              ),
              actions: [],
              centerTitle: true,
              elevation: 0.0,
            ),
            body: SafeArea(
              top: true,
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 12.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 20.0),
                        child: Text(
                          valueOrDefault<String>(
                            widget!.projectName,
                            'Project Name',
                          ),
                          style: FlutterFlowTheme.of(context)
                              .displaySmall
                              .override(
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
                            animationsMap['textOnPageLoadAnimation1']!),
                      ),
                      Divider(
                        height: 24.0,
                        thickness: 1.0,
                        color: Color(0xFFE0E3E7),
                      ).animateOnPageLoad(
                          animationsMap['dividerOnPageLoadAnimation']!),
                      // Projects dropdown + filtered history list
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 12.0),
                        child: FutureBuilder<List<ProjectsRow>>(
                          future: ProjectsTable().queryRows(queryFn: (q) => q.order('name')),
                          builder: (context, snapProjects) {
                            if (!snapProjects.hasData) {
                              return SizedBox(
                                height: 48.0,
                                child: Center(
                                  child: SizedBox(
                                    width: 24.0,
                                    height: 24.0,
                                    child: CircularProgressIndicator(
                                      color: FlutterFlowTheme.of(context).primary,
                                    ),
                                  ),
                                ),
                              );
                            }
                            final projects = snapProjects.data!;
                            // filter out null/duplicate project ids and compute a safe selected value
                            final uniqueProjects = <ProjectsRow>[];
                            final seenIds = <String>{};
                            for (final p in projects) {
                              final id = p.projectid;
                              if (id == null) continue;
                              if (seenIds.add(id)) uniqueProjects.add(p);
                            }
                            final currentValue = _selectedProjectId ?? widget.projectId;
                            final safeValue = uniqueProjects.any((p) => p.projectid == currentValue) ? currentValue : null;

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DropdownButtonFormField<String>(
                                  value: safeValue,
                                  decoration: InputDecoration(
                                    labelText: 'Select project',
                                    border: OutlineInputBorder(),
                                  ),
                                  items: uniqueProjects
                                      .map((p) => DropdownMenuItem(
                                            value: p.projectid,
                                            child: Text(p.name ?? p.projectid ?? 'Unnamed'),
                                          ))
                                      .toList(),
                                  onChanged: (val) {
                                    setState(() {
                                      _selectedProjectId = val;
                                      final matched = uniqueProjects.where((p) => p.projectid == val).toList();
                                      _selectedProjectName = matched.isNotEmpty ? matched.first.name : null;
                                    });
                                  },
                                ),
                                SizedBox(height: 12.0),
                                FutureBuilder<List<HistoryRow>>(
                                  future: _fetchHistoryForProject(
                                    (_selectedProjectId != null && _selectedProjectId!.trim().isNotEmpty)
                                        ? _selectedProjectId
                                        : (widget.projectId != null && widget.projectId!.trim().isNotEmpty ? widget.projectId : null),
                                  ),
                                  builder: (context, snapHistory) {
                                    if (!snapHistory.hasData) {
                                      return Center(
                                        child: SizedBox(
                                          width: 36.0,
                                          height: 36.0,
                                          child: CircularProgressIndicator(
                                            color: FlutterFlowTheme.of(context).primary,
                                          ),
                                        ),
                                      );
                                    }
                                    final historyList = snapHistory.data!;
                                    if (historyList.isEmpty) {
                                      return Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 8.0),
                                        child: Text('No history found for selected project.'),
                                      );
                                    }
                                    return ListView.separated(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: historyList.length,
                                      separatorBuilder: (_, __) => Divider(),
                                      itemBuilder: (context, idx) {
                                        final h = historyList[idx];
                                        final dt = h.createdat ?? h.submittedat;
                                        final label = dt != null ? (dt is DateTime ? dt.toLocal().toString() : dt.toString()) : 'Unknown';
                                        return ListTile(
                                          title: Text(label),
                                          subtitle: Text(h.submittedby ?? ''),
                                          trailing: Icon(Icons.arrow_forward_ios, size: 16.0),
                                          onTap: () async {
                                            await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => QcDetailsWidget(
                                                  projectId: _selectedProjectId ?? widget.projectId,
                                                  projectName: _selectedProjectName ?? widget.projectName,
                                                  proectImage: widget.proectImage,
                                                  recestageId: widget.recestageId,
                                                  historyId: h.historyId,
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    );
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      FutureBuilder<List<RecceresponsesRow>>(
                        future: RecceresponsesTable().querySingleRow(
                          queryFn: (q) => q
                              .eqOrNull(
                                'reccestageid',
                                widget!.recestageId,
                              )
                              .eqOrNull(
                                'stageNo',
                                3,
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
                          List<RecceresponsesRow> rowRecceresponsesRowList =
                              snapshot.data!;

                          final rowRecceresponsesRow =
                              rowRecceresponsesRowList.isNotEmpty
                                  ? rowRecceresponsesRowList.first
                                  : null;

                          return Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        2.0, 24.0, 0.0, 0.0),
                                    child: Text(
                                      valueOrDefault<String>(
                                        widget!.creatDate?.toString(),
                                        'QC Details',
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight: FontWeight.w600,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .fontStyle,
                                            ),
                                            fontSize: 18.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .fontStyle,
                                          ),
                                    ).animateOnPageLoad(animationsMap[
                                        'textOnPageLoadAnimation2']!),
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
                                          2.0, 24.0, 0.0, 0.0),
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          context.pushNamed(
                                            QchistoryWidget.routeName,
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
                                              'responseId': serializeParam(
                                                rowRecceresponsesRow
                                                    ?.recceresponseid,
                                                ParamType.String,
                                              ),
                                            }.withoutNulls,
                                          );
                                        },
                                        child: Text(
                                          '[History]',
                                          style: FlutterFlowTheme.of(context)
                                              .labelMedium
                                              .override(
                                                font: GoogleFonts.inter(
                                                  fontWeight: FontWeight.w600,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelMedium
                                                          .fontStyle,
                                                ),
                                                fontSize: 18.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w600,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .fontStyle,
                                              ),
                                        ),
                                      ).animateOnPageLoad(animationsMap[
                                          'textOnPageLoadAnimation3']!),
                                    ),
                                ],
                              ),
                              if (responsiveVisibility(
                                context: context,
                                phone: false,
                                tablet: false,
                                tabletLandscape: false,
                                desktop: false,
                              ))
                                InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    context.pushNamed(
                                      QceditDetailsFormWidget.routeName,
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
                                        'receresponseId': serializeParam(
                                          rowRecceresponsesRow?.recceresponseid,
                                          ParamType.String,
                                        ),
                                      }.withoutNulls,
                                    );
                                  },
                                  child: FaIcon(
                                    FontAwesomeIcons.solidEdit,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    size: 24.0,
                                  ),
                                ),
                            ],
                          );
                        },
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  2.0, 0.0, 2.0, 0.0),
                              child: FutureBuilder<List<HistoryRow>>(
                                future: HistoryTable().querySingleRow(
                                  queryFn: (q) => q
                                      .eqOrNull(
                                        'recceresponseId',
                                        widget!.responseId,
                                      )
                                      .eqOrNull(
                                        'history_id',
                                        widget!.historyId,
                                      )
                                      .order('createdat'),
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
                                  List<HistoryRow> listViewHistoryRowList =
                                      snapshot.data!;

                                  final listViewHistoryRow =
                                      listViewHistoryRowList.isNotEmpty
                                          ? listViewHistoryRowList.first
                                          : null;

                                  return Builder(
                                    builder: (context) {
                                      final rawQcr = getJsonField(
                                        listViewHistoryRow?.formjson,
                                        r'''$.qcr''',
                                      );
                                      List qcrVariable;
                                      if (rawQcr == null) {
                                        qcrVariable = <dynamic>[];
                                      } else if (rawQcr is List) {
                                        qcrVariable = rawQcr;
                                      } else if (rawQcr is Iterable) {
                                        qcrVariable = rawQcr.toList();
                                      } else {
                                        qcrVariable = [rawQcr];
                                      }

                                      return ListView.separated(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10.0),
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemCount: qcrVariable.length,
                                        separatorBuilder: (_, __) =>
                                            SizedBox(height: 10.0),
                                        itemBuilder:
                                            (context, qcrVariableIndex) {
                                          final qcrVariableItem =
                                              qcrVariable[qcrVariableIndex];
                                          return QcDetailComponentWidget(
                                            key: Key(
                                                'Key5wa_${qcrVariableIndex}_of_${qcrVariable.length}'),
                                            img: getJsonField(
                                              qcrVariableItem,
                                              r'''$.qc_img''',
                                              true,
                                            ),
                                            que: getJsonField(
                                              qcrVariableItem,
                                              r'''$.qc_que''',
                                            ).toString(),
                                            ans: getJsonField(
                                              qcrVariableItem,
                                              r'''$.qc_ans''',
                                            ).toString(),
                                          );
                                        },
                                      );
                                    },
                                  );
                                },
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
          ),
        );
      },
    );
  }
}
