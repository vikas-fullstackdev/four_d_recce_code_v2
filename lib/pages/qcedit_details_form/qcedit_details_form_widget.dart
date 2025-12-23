import '/auth/supabase_auth/auth_util.dart';
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/components/qc_edit_form_component_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'qcedit_details_form_model.dart';
export 'qcedit_details_form_model.dart';

class QceditDetailsFormWidget extends StatefulWidget {
  const QceditDetailsFormWidget({
    super.key,
    this.projectId,
    this.projectName,
    this.proectImage,
    required this.recestageId,
    required this.receresponseId,
  });

  final String? projectId;
  final String? projectName;
  final String? proectImage;
  final String? recestageId;
  final String? receresponseId;

  static String routeName = 'qceditDetailsForm';
  static String routePath = '/qceditDetailsForm';

  @override
  State<QceditDetailsFormWidget> createState() =>
      _QceditDetailsFormWidgetState();
}

class _QceditDetailsFormWidgetState extends State<QceditDetailsFormWidget>
    with TickerProviderStateMixin {
  late QceditDetailsFormModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  LatLng? currentUserLocationValue;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => QceditDetailsFormModel());

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
    context.watch<FFAppState>();

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
        List<ReccetemplatesRow> qceditDetailsFormReccetemplatesRowList =
            snapshot.data!;

        final qceditDetailsFormReccetemplatesRow =
            qceditDetailsFormReccetemplatesRowList.isNotEmpty
                ? qceditDetailsFormReccetemplatesRowList.first
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
                      Row(
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
                                  'Edit QC Details',
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
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontStyle,
                                      ),
                                ).animateOnPageLoad(
                                    animationsMap['textOnPageLoadAnimation2']!),
                              ),
                            ],
                          ),
                        ],
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
                                          return QcEditFormComponentWidget(
                                            key: Key(
                                                'Keyybm_${qcrVariableIndex}_of_${qcrVariable.length}'),
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
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  10.0, 0.0, 10.0, 0.0),
                              child: FFButtonWidget(
                                onPressed: () async {
                                  currentUserLocationValue =
                                      await getCurrentUserLocation(
                                          defaultLocation: LatLng(0.0, 0.0));
                                  _model.qcroutput1 =
                                      await actions.convertQcResponsesToJson(
                                    FFAppState()
                                        .editqc
                                        .map((e) => e.toMap())
                                        .toList(),
                                  );
                                  await RecceresponsesTable().update(
                                    data: {
                                      'formjson': <String, List<dynamic>?>{
                                        'qcr': _model.qcroutput1,
                                      },
                                      'submittedby': currentUserUid,
                                      'submittedat': supaSerialize<DateTime>(
                                          getCurrentTimestamp),
                                      'createdat': supaSerialize<DateTime>(
                                          getCurrentTimestamp),
                                      'reccestageid': widget!.recestageId,
                                      'location':
                                          currentUserLocationValue?.toString(),
                                      'stageno': 3,
                                    },
                                    matchingRows: (rows) => rows.eqOrNull(
                                      'recceresponseid',
                                      widget!.receresponseId,
                                    ),
                                  );
                                  await HistoryTable().insert({
                                    'recceresponseid': widget!.receresponseId,
                                    'formjson': <String, List<dynamic>?>{
                                      'qcr': _model.qcroutput1,
                                    },
                                    'submittedby': currentUserUid,
                                    'submittedat': supaSerialize<DateTime>(
                                        getCurrentTimestamp),
                                    'createdat': supaSerialize<DateTime>(
                                        getCurrentTimestamp),
                  'location':
                    currentUserLocationValue?.toString(),
                  'stageno': 3,
                                  });
                                  FFAppState().editqc = [];
                                  safeSetState(() {});
                                  context.safePop();

                                  safeSetState(() {});
                                },
                                text: 'Save',
                                options: FFButtonOptions(
                                  width: double.infinity,
                                  height: 40.0,
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16.0, 0.0, 16.0, 0.0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  color: FlutterFlowTheme.of(context).secondary,
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
                                        color: Colors.white,
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .fontStyle,
                                      ),
                                  elevation: 0.0,
                                  borderRadius: BorderRadius.circular(32.0),
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
          ),
        );
      },
    );
  }
}
