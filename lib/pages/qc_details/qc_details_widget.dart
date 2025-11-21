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
import 'qc_details_model.dart';
export 'qc_details_model.dart';

class QcDetailsWidget extends StatefulWidget {
  const QcDetailsWidget({
    super.key,
    this.projectId,
    this.projectName,
    this.proectImage,
    required this.recestageId,
  });

  final String? projectId;
  final String? projectName;
  final String? proectImage;
  final String? recestageId;

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
                                      final qcrVariable = getJsonField(
                                        listViewRecceresponsesRow?.formjson,
                                        r'''$.qcr''',
                                      ).toList();

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
                                                'Keyurl_${qcrVariableIndex}_of_${qcrVariable.length}'),
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
