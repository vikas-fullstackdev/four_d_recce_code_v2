import '/backend/supabase/supabase.dart';
import '/components/qc_detail_component_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'dart:ui';
import 'dart:convert';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'qc_details_model.dart';
export 'qc_details_model.dart';

class QcDetailsWidget extends StatefulWidget {
  const QcDetailsWidget({
    super.key,
    this.projectId,
    this.projectName,
    this.proectImage,
    required this.recestageId,
    this.historyFormJson,
    this.historyId,
  });

  final String? projectId;
  final String? projectName;
  final String? proectImage;
  final String? recestageId;
  final dynamic? historyFormJson;
  final String? historyId;

  static String routeName = 'qcDetails';
  static String routePath = '/qcDetails';

  @override
  State<QcDetailsWidget> createState() => _QcDetailsWidgetState();
}

class _QcDetailsWidgetState extends State<QcDetailsWidget>
    with TickerProviderStateMixin {
  late QcDetailsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => QcDetailsModel());

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

  Widget _buildFormJsonContent(dynamic rawFormJson) {
    // Safely render media, other top-level fields and the qcr list
    final media = getJsonField(rawFormJson, r'''$.media''');

    // Collect image URLs from media
    final List<String> imageUrls = [];
    if (media != null) {
      void addIfUrl(dynamic v) {
        if (v == null) return;
        if (v is String && v.trim().isNotEmpty) {
          imageUrls.add(v);
        } else if (v is Iterable) {
          for (final e in v) {
            if (e is String && e.trim().isNotEmpty) imageUrls.add(e);
          }
        }
      }

      addIfUrl(getJsonField(media, r'''$.lhsPhotoUrl'''));
      addIfUrl(getJsonField(media, r'''$.rhsPhotoUrl'''));
      addIfUrl(getJsonField(media, r'''$.oppositePhotoUrl'''));
      addIfUrl(getJsonField(media, r'''$.northFacingPhotoUrl'''));
      addIfUrl(getJsonField(media, r'''$.completeFacadePhotoUrl'''));
      addIfUrl(getJsonField(media, r'''$.siteSurroundingsVideoUrl'''));
      addIfUrl(getJsonField(media, r'''$.lhsPhotoUrls'''));
      addIfUrl(getJsonField(media, r'''$.rhsPhotoUrls'''));
      addIfUrl(getJsonField(media, r'''$.oppositePhotoUrls'''));
      addIfUrl(getJsonField(media, r'''$.northFacingPhotoUrls'''));
      addIfUrl(getJsonField(media, r'''$.completeFacadePhotoUrls'''));
      addIfUrl(getJsonField(media, r'''$.finalSolutionAttachmentUrl'''));
      addIfUrl(getJsonField(media, r'''$.finalSolutionAttachmentUrls'''));
    }

    // Prepare qcr list (same safety as before)
    final rawQcr = getJsonField(rawFormJson, r'''$.qcr''');
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

    // Render other top-level keys (excluding qcr and media) in a clean structured way
    final List<Widget> otherFields = [];
    if (rawFormJson is Map) {
      // Use a stable key ordering
      final keys = rawFormJson.keys.where((k) => k != 'qcr' && k != 'media').toList();
      for (final k in keys) {
        otherFields.add(Padding(padding: EdgeInsets.symmetric(vertical: 6.0), child: _buildJsonSectionWidgets(k, rawFormJson[k])));
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (imageUrls.isNotEmpty) ...[
          Text('Photos', style: FlutterFlowTheme.of(context).labelMedium),
          SizedBox(height: 8.0),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: imageUrls.map((u) => SizedBox(width: 120.0, height: 90.0, child: Image.network(u, fit: BoxFit.cover, errorBuilder: (_, __, ___) => Container(color: Colors.grey)))).toList(),
          ),
          SizedBox(height: 12.0),
        ],
        if (otherFields.isNotEmpty) ...[
          ...otherFields,
          SizedBox(height: 12.0),
        ],
        // QCR list
        if (qcrVariable.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('QCR', style: FlutterFlowTheme.of(context).labelMedium),
              SizedBox(height: 8.0),
              ListView.separated(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: qcrVariable.length,
                separatorBuilder: (_, __) => SizedBox(height: 10.0),
                itemBuilder: (context, qcrVariableIndex) {
                  final qcrVariableItem = qcrVariable[qcrVariableIndex];
                  return QcDetailComponentWidget(
                    key: Key('Keyurl_${qcrVariableIndex}_of_${qcrVariable.length}'),
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
              ),
            ],
          ),
        // end of structured content
      ],
    );
  }

  // (removed unused recursive image collector)

  // Build structured widgets for a JSON node with a title
  Widget _buildJsonSectionWidgets(String title, dynamic node) {
    if (node == null) {
      return ListTile(title: Text(title), subtitle: Text('null'));
    }
    // Image URL
    if (node is String && node.trim().startsWith('http')) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: FlutterFlowTheme.of(context).labelMedium),
          SizedBox(height: 8.0),
          Image.network(node, width: double.infinity, fit: BoxFit.cover, errorBuilder: (_, __, ___) => Container(height: 120.0, color: Colors.grey)),
        ],
      );
    }

    // Map: show expandable section with child keys (don't dump raw JSON)
    if (node is Map) {
      final childKeys = node.keys.toList();
      return ExpansionTile(
        title: Row(children: [Text(title, style: TextStyle(fontWeight: FontWeight.w600)), SizedBox(width: 8.0), Text('(${childKeys.length} items)', style: TextStyle(color: Colors.grey, fontSize: 12.0))]),
        children: childKeys.map<Widget>((k) => Padding(padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0), child: _buildJsonSectionWidgets(k, node[k]))).toList(),
      );
    }

    // Iterable: show expandable list with index labels
    if (node is Iterable) {
      final list = node.toList();
      return ExpansionTile(
        title: Row(children: [Text(title, style: TextStyle(fontWeight: FontWeight.w600)), SizedBox(width: 8.0), Text('(${list.length} items)', style: TextStyle(color: Colors.grey, fontSize: 12.0))]),
        children: list.asMap().entries.map<Widget>((e) => Padding(padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0), child: _buildJsonSectionWidgets('Item ${e.key + 1}', e.value))).toList(),
      );
    }

    // Primitive: show key -> value succinctly (no raw JSON)
    return ListTile(
      title: Text(title, style: TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(node.toString()),
    );
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
        List<ReccetemplatesRow> qcDetailsReccetemplatesRowList = snapshot.data!;

        final qcDetailsReccetemplatesRow =
            qcDetailsReccetemplatesRowList.isNotEmpty
                ? qcDetailsReccetemplatesRowList.first
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
                                      'QC Details',
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
                                      ),
                                    ).animateOnPageLoad(animationsMap[
                                        'textOnPageLoadAnimation3']!),
                                  ),
                                ],
                              ),
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
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
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
                              child: FutureBuilder<List<RecceresponsesRow>>(
                                future: RecceresponsesTable().querySingleRow(
                                  queryFn: (q) => q
                                      .eqOrNull(
                                        'reccestageid',
                                        widget!.recestageId,
                                      )
                                      .eqOrNull(
                                        'stageNo',
                                        3,
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
                                  List<RecceresponsesRow>
                                      listViewRecceresponsesRowList =
                                      snapshot.data!;

                                  final listViewRecceresponsesRow =
                                      listViewRecceresponsesRowList.isNotEmpty
                                          ? listViewRecceresponsesRowList.first
                                          : null;

                                  return Builder(
                                    builder: (context) {
                                      // If a specific historyId was provided, load that history row
                                      if (widget.historyId != null && widget.historyId!.trim().isNotEmpty) {
                                        return FutureBuilder<List<HistoryRow>>(
                                          future: HistoryTable().querySingleRow(
                                            queryFn: (q) => q.eqOrNull('history_id', widget.historyId),
                                          ),
                                          builder: (context, histSnap) {
                                            if (!histSnap.hasData) {
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
                                            final histList = histSnap.data!;
                                            final histRow = histList.isNotEmpty ? histList.first : null;
                                            final rawFormJson = widget.historyFormJson ?? histRow?.formjson ?? listViewRecceresponsesRow?.formjson;

                                            return _buildFormJsonContent(rawFormJson);
                                          },
                                        );
                                      }

                                      // Default: use response formjson (or passed historyFormJson) to render qcr
                                      final rawFormJson = widget.historyFormJson ?? listViewRecceresponsesRow?.formjson;

                                      return _buildFormJsonContent(rawFormJson);
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
