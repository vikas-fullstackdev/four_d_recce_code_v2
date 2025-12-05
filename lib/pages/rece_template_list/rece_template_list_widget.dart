import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'rece_template_list_model.dart';
export 'rece_template_list_model.dart';

class ReceTemplateListWidget extends StatefulWidget {
  const ReceTemplateListWidget({
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

  static String routeName = 'receTemplateList';
  static String routePath = '/receTemplateList';

  @override
  State<ReceTemplateListWidget> createState() => _ReceTemplateListWidgetState();
}

class _ReceTemplateListWidgetState extends State<ReceTemplateListWidget>
    with TickerProviderStateMixin {
  late ReceTemplateListModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  // Added state for projects dropdown
  List<Map<String, dynamic>> _projects = [];
  String? _selectedProjectId;
  bool _projectsLoading = true;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ReceTemplateListModel());

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

    // load projects for dropdown
    _loadProjects();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  Future<void> _loadProjects() async {
    setState(() => _projectsLoading = true);
    try {
      final client = Supabase.instance.client;
      final res = await client.from('projects').select('projectid,name').order('name');
      if (res is List) {
        _projects = res.map((e) => Map<String, dynamic>.from(e as Map)).toList();
        // default selection: widget.projectId or first project
        _selectedProjectId ??= widget.projectId ?? (_projects.isNotEmpty ? _projects.first['projectid']?.toString() : null);
      }
    } catch (e) {
      // ignore: avoid_print
      print('projects load error: $e');
    } finally {
      setState(() => _projectsLoading = false);
    }
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
                  // Page title
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 12.0),
                    child: Text(
                      valueOrDefault<String>(
                        widget.projectName,
                        'Project Name',
                      ),
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
                        animationsMap['textOnPageLoadAnimation1']!),
                  ),

                  // Project dropdown (new)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: _projectsLoading
                        ? SizedBox(
                            height: 48,
                            child: Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  FlutterFlowTheme.of(context).primary,
                                ),
                              ),
                            ),
                          )
                        : DropdownButtonFormField<String>(
                            value: _selectedProjectId,
                            items: _projects
                                .map(
                                  (p) => DropdownMenuItem<String>(
                                    value: p['projectid']?.toString(),
                                    child: Text(p['name']?.toString() ?? 'Unnamed'),
                                  ),
                                )
                                .toList(),
                            decoration: InputDecoration(
                              labelText: 'Select Project',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                            ),
                            onChanged: (val) {
                              setState(() {
                                _selectedProjectId = val;
                              });
                            },
                          ),
                  ),

                  Divider(
                    height: 12.0,
                    thickness: 1.0,
                    color: Color(0xFFE0E3E7),
                  ).animateOnPageLoad(
                      animationsMap['dividerOnPageLoadAnimation']!),

                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(-1.0, -1.0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 10.0, 0.0, 10.0),
                            child: Text(
                              'Recce List',
                              textAlign: TextAlign.start,
                              style: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    font: GoogleFonts.inter(
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
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
                        ),

                        // If no project selected, show prompt
                        if (_selectedProjectId == null)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            child: Text(
                              'Please select a project to view history.',
                              style: FlutterFlowTheme.of(context).bodySmall,
                            ),
                          )
                        else
                          // List of recceresponses filtered by selected project
                          FutureBuilder<List<RecceresponsesRow>>(
                            future: RecceresponsesTable().queryRows(
                              queryFn: (q) => q
                                  .eqOrNull('projectid', _selectedProjectId)
                                  // .eqOrNull('reccestageid', widget.recestageId)
                                  // .eqOrNull('stageNo', 2)
                                  .order('createdat'),
                            ),
                            builder: (context, snapshot) {
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
                              List<RecceresponsesRow> listViewRecceresponsesRowList =
                                  snapshot.data!;

                              if (listViewRecceresponsesRowList.isEmpty) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                                  child: Text(
                                    'No history found for selected project.',
                                    style: FlutterFlowTheme.of(context).bodySmall,
                                  ),
                                );
                              }

                              return ListView.separated(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: listViewRecceresponsesRowList.length,
                                separatorBuilder: (_, __) => SizedBox(height: 10.0),
                                itemBuilder: (context, listViewIndex) {
                                  final listViewRecceresponsesRow =
                                      listViewRecceresponsesRowList[listViewIndex];
                                  return InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      // ScaffoldMessenger.of(context).showSnackBar(
                                        // SnackBar(
                                        //   content: Text(
                                        //     'button clicked',
                                        //     style: TextStyle(
                                        //       color: FlutterFlowTheme.of(context).primaryText,
                                        //     ),
                                        //   ),
                                        //   duration: Duration(milliseconds: 4000),
                                        //   backgroundColor: FlutterFlowTheme.of(context).secondary,
                                        // ),
                                      // );
                                      // _model.flatJson1 = await actions.flattenJsonChildrenOnly(
                                      //   listViewRecceresponsesRow.formjson,
                                      // );
                                      // ScaffoldMessenger.of(context).showSnackBar(
                                      //   SnackBar(
                                      //     content: Text(
                                      //       'successfull code return value',
                                      //       style: TextStyle(
                                      //         color: FlutterFlowTheme.of(context).primaryText,
                                      //       ),
                                      //     ),
                                      //     duration: Duration(milliseconds: 4000),
                                      //     backgroundColor: FlutterFlowTheme.of(context).secondary,
                                      //   ),
                                      // );
                                      // await RecceresponsesTable().update(
                                      //   data: {
                                      //     'recceStraightJson': _model.flatJson1,
                                      //   },
                                        // matchingRows: (rows) => rows.eqOrNull(
                                        //   'recceresponseid',
                                        //   listViewRecceresponsesRow.recceresponseid,
                                        // ),
                                      // );
                                      // ScaffoldMessenger.of(context).showSnackBar(
                                      //   SnackBar(
                                      //     content: Text(
                                      //       'Successfully row updated',
                                      //       style: TextStyle(
                                      //         color: FlutterFlowTheme.of(context).primaryText,
                                      //       ),
                                      //     ),
                                      //     duration: Duration(milliseconds: 4000),
                                      //     backgroundColor: FlutterFlowTheme.of(context).secondary,
                                      //   ),
                                      // );

                                      context.pushNamed(
                                        ReceDetailsWidget.routeName,
                                        queryParameters: {
                                          'projectId': serializeParam(
                                            widget.projectId,
                                            ParamType.String,
                                          ),
                                          'projectName': serializeParam(
                                            widget.projectName,
                                            ParamType.String,
                                          ),
                                          'proectImage': serializeParam(
                                            widget.proectImage,
                                            ParamType.String,
                                          ),
                                          'recestageId': serializeParam(
                                            listViewRecceresponsesRow.reccestageid,
                                            ParamType.String,
                                          ),
                                          // Pass the selected response id and the form JSON so rece_details can show data immediately
                                          'receresponseid': serializeParam(
                                            listViewRecceresponsesRow.recceresponseid,
                                            ParamType.String,
                                          ),
                                          'recceflatJson': serializeParam(
                                            listViewRecceresponsesRow.formjson,
                                            ParamType.JSON,
                                          ),
                                        }.withoutNulls,
                                      );

                                      safeSetState(() {});
                                    },
                                    child: Material(
                                      color: Colors.transparent,
                                      child: ListTile(
                                        title: Text(
                                          listViewRecceresponsesRow.createdat!.toString(),
                                          style: FlutterFlowTheme.of(context).titleLarge.override(
                                            font: GoogleFonts.interTight(
                                              fontWeight: FlutterFlowTheme.of(context).titleLarge.fontWeight,
                                              fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight: FlutterFlowTheme.of(context).titleLarge.fontWeight,
                                            fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
                                          ),
                                        ),
                                        trailing: Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          color: FlutterFlowTheme.of(context).secondaryText,
                                          size: 24.0,
                                        ),
                                        tileColor: FlutterFlowTheme.of(context).secondaryBackground,
                                        dense: false,
                                        contentPadding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
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
  }
}
