import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'task_componentnew_model.dart';
export 'task_componentnew_model.dart';

class TaskComponentnewWidget extends StatefulWidget {
  const TaskComponentnewWidget({
    super.key,
    required this.taskname,
    required this.assignedto,
    required this.receresponseId,
  });

  final List<String>? taskname;
  final String? assignedto;
  final String? receresponseId;

  @override
  State<TaskComponentnewWidget> createState() => _TaskComponentnewWidgetState();
}

class _TaskComponentnewWidgetState extends State<TaskComponentnewWidget> {
  late TaskComponentnewModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TaskComponentnewModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
        ),
        child: FutureBuilder<List<RecceresponsesRow>>(
          future: RecceresponsesTable().querySingleRow(
            queryFn: (q) => q.eqOrNull(
              'recceresponseid',
              widget!.receresponseId,
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

            return Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Builder(
                  builder: (context) {
                    final taskNameVar = widget!.taskname!.toList();

                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: taskNameVar.length,
                      itemBuilder: (context, taskNameVarIndex) {
                        final taskNameVarItem = taskNameVar[taskNameVarIndex];
                        return Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              taskNameVarItem,
                              style: FlutterFlowTheme.of(context)
                                  .titleMedium
                                  .override(
                                    font: GoogleFonts.interTight(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontStyle,
                                    ),
                                    color:
                                        FlutterFlowTheme.of(context).secondary,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontStyle,
                                  ),
                            ),
                            Theme(
                              data: ThemeData(
                                checkboxTheme: CheckboxThemeData(
                                  visualDensity: VisualDensity.compact,
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                ),
                                unselectedWidgetColor:
                                    FlutterFlowTheme.of(context).alternate,
                              ),
                              child: Checkbox(
                                value: _model
                                    .checkboxValueMap[taskNameVarItem] ??= true,
                                onChanged: (newValue) async {
                                  safeSetState(() =>
                                      _model.checkboxValueMap[taskNameVarItem] =
                                          newValue!);
                                },
                                side: (FlutterFlowTheme.of(context).alternate !=
                                        null)
                                    ? BorderSide(
                                        width: 2,
                                        color: FlutterFlowTheme.of(context)
                                            .alternate!,
                                      )
                                    : null,
                                activeColor:
                                    FlutterFlowTheme.of(context).secondary,
                                checkColor: FlutterFlowTheme.of(context).info,
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
                Text(
                  valueOrDefault<String>(
                    widget!.assignedto,
                    'Name',
                  ),
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.inter(
                          fontWeight: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                        letterSpacing: 0.0,
                        fontWeight:
                            FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
