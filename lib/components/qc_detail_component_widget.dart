import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'qc_detail_component_model.dart';
export 'qc_detail_component_model.dart';

class QcDetailComponentWidget extends StatefulWidget {
  const QcDetailComponentWidget({
    super.key,
    this.img,
    required this.que,
    required this.ans,
  });

  final List<dynamic>? img;
  final String? que;
  final String? ans;

  @override
  State<QcDetailComponentWidget> createState() =>
      _QcDetailComponentWidgetState();
}

class _QcDetailComponentWidgetState extends State<QcDetailComponentWidget> {
  late QcDetailComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => QcDetailComponentModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: FlutterFlowTheme.of(context).secondary,
          width: 0.5,
        ),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              valueOrDefault<String>(
                widget!.que,
                'Question',
              ),
              textAlign: TextAlign.start,
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    font: GoogleFonts.inter(
                      fontWeight: FontWeight.w500,
                      fontStyle:
                          FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                    ),
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w500,
                    fontStyle:
                        FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  ),
            ),
            if (widget!.ans != null && widget!.ans != '')
              Text(
                valueOrDefault<String>(
                  widget!.ans,
                  'Answer',
                ),
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      font: GoogleFonts.inter(
                        fontWeight:
                            FlutterFlowTheme.of(context).bodyMedium.fontWeight,
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
            if ((widget!.img?.firstOrNull != null) &&
                responsiveVisibility(
                  context: context,
                  phone: false,
                  tablet: false,
                  tabletLandscape: false,
                  desktop: false,
                ))
              Builder(
                builder: (context) {
                  final qcImgVariable = widget!.img?.toList() ?? [];

                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: List.generate(qcImgVariable.length,
                              (qcImgVariableIndex) {
                        final qcImgVariableItem =
                            qcImgVariable[qcImgVariableIndex];
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            qcImgVariableItem.toString(),
                            width: 200.0,
                            height: 200.0,
                            fit: BoxFit.cover,
                          ),
                        );
                      })
                          .divide(SizedBox(width: 10.0))
                          .around(SizedBox(width: 10.0)),
                    ),
                  );
                },
              ),
            if (widget!.ans == null || widget!.ans == '')
              Builder(
                builder: (context) {
                  final imgListVar =
                      widget!.img?.map((e) => e).toList()?.toList() ?? [];

                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    children:
                        List.generate(imgListVar.length, (imgListVarIndex) {
                      final imgListVarItem = imgListVar[imgListVarIndex];
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          imgListVarItem.toString(),
                          width: double.infinity,
                          height: 200.0,
                          fit: BoxFit.cover,
                        ),
                      );
                    })
                            .divide(SizedBox(height: 8.0))
                            .around(SizedBox(height: 8.0)),
                  );
                },
              ),
          ].divide(SizedBox(height: 10.0)).around(SizedBox(height: 10.0)),
        ),
      ),
    );
  }
}
