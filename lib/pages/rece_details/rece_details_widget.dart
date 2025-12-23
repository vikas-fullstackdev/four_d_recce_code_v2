import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'dart:ui';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'rece_details_model.dart';
export 'rece_details_model.dart';

class ReceDetailsWidget extends StatefulWidget {
  const ReceDetailsWidget({
    super.key,
    this.projectId,
    this.projectName,
    this.proectImage,
    required this.recestageId,
    required this.recceflatJson,
    required this.receresponseid,
  });

  final String? projectId;
  final String? projectName;
  final String? proectImage;
  final String? recestageId;
  final dynamic recceflatJson;
  final String? receresponseid;

  static String routeName = 'receDetails';
  static String routePath = '/receDetails';

  @override
  State<ReceDetailsWidget> createState() => _ReceDetailsWidgetState();
}

/* small helpers */
Widget _labelValue(BuildContext context, String label, String value) {
  final theme = FlutterFlowTheme.of(context);
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 160,
          child: Text(label, style: theme.bodySmall?.override(fontWeight: FontWeight.w600)),
        ),
        Expanded(child: Text(value, style: theme.bodyMedium)),
      ],
    ),
  );
}

/// Render JSON (Map/List/primitive) recursively into widgets
Widget _renderJsonWidget(BuildContext context, dynamic data) {
  final theme = FlutterFlowTheme.of(context);

  if (data == null) {
    return Text('N/A', style: theme.bodyMedium);
  }

  if (data is String) {
    // try decode if stringified JSON
    try {
      final decoded = jsonDecode(data);
      return _renderJsonWidget(context, decoded);
    } catch (_) {
      // If the string looks like an image URL, render the image instead of the raw URL
      final trimmed = data.trim();
      final isImageUrl = RegExp(r'^(https?:)?//.+\.(png|jpg|jpeg|gif|webp|svg)(\?.*)?\$', caseSensitive: false);
      final isHttpLike = RegExp(r'^(https?:)?//');

      if (isImageUrl.hasMatch(trimmed) || (isHttpLike.hasMatch(trimmed) && (trimmed.contains('storage') || trimmed.contains('supabase') || trimmed.contains('cdn')))) {
        // show network image as a square thumbnail with placeholder
        const imageSize = 160.0;
        final imageUrl = trimmed.startsWith('//') ? 'https:$trimmed' : trimmed;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: SizedBox(
            width: imageSize,
            height: imageSize,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                imageUrl,
                width: imageSize,
                height: imageSize,
                fit: BoxFit.cover, // fill square, crop if needed (no stretch)
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return SizedBox(
                    width: imageSize,
                    height: imageSize,
                    child: Center(child: CircularProgressIndicator(value: progress.expectedTotalBytes != null ? progress.cumulativeBytesLoaded / (progress.expectedTotalBytes ?? 1) : null)),
                  );
                },
                errorBuilder: (context, err, stack) => Container(
                  width: imageSize,
                  height: imageSize,
                  color: Colors.grey.shade200,
                  child: Center(child: Icon(Icons.broken_image, color: Colors.grey, size: 40)),
                ),
              ),
            ),
          ),
        );
      }

      return Text(data, style: theme.bodyMedium);
    }
  }

  if (data is num || data is bool) {
    return Text(data.toString(), style: theme.bodyMedium);
  }

  if (data is List) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: data.asMap().entries.map((e) {
        final idx = e.key;
        final val = e.value;
        return Card(
          elevation: 0,
          margin: const EdgeInsets.symmetric(vertical: 6.0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('#${idx + 1}', style: theme.bodySmall?.override(fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              _renderJsonWidget(context, val),
            ]),
          ),
        );
      }).toList(),
    );
  }

  if (data is Map) {
    final keys = data.keys.toList()..sort((a, b) => a.toString().compareTo(b.toString()));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: keys.map<Widget>((k) {
        final v = data[k];
        if (v == null) return _labelValue(context, k.toString(), 'N/A');
        if (v is Map || v is List) {
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: ExpansionTile(
              tilePadding: EdgeInsets.zero,
              title: Text(k.toString(), style: theme.bodySmall?.override(fontWeight: FontWeight.w700)),
              children: [
                Padding(padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0), child: _renderJsonWidget(context, v)),
              ],
            ),
          );
        }
        return _labelValue(context, k.toString(), v.toString());
      }).toList(),
    );
  }

  // fallback
  return Text(data.toString(), style: theme.bodyMedium);
}

class _ReceDetailsWidgetState extends State<ReceDetailsWidget>
    with TickerProviderStateMixin {
  late ReceDetailsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ReceDetailsModel());

    animationsMap.addAll({
      'textOnPageLoadAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(curve: Curves.easeInOut, delay: 0.0.ms, duration: 600.0.ms, begin: 0.0, end: 1.0),
          MoveEffect(curve: Curves.easeInOut, delay: 0.0.ms, duration: 600.0.ms, begin: Offset(0.0, 40.0), end: Offset(0.0, 0.0)),
        ],
      ),
      'dividerOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(curve: Curves.easeInOut, delay: 0.0.ms, duration: 600.0.ms, begin: 0.0, end: 1.0),
          MoveEffect(curve: Curves.easeInOut, delay: 0.0.ms, duration: 600.0.ms, begin: Offset(0.0, 30.0), end: Offset(0.0, 0.0)),
        ],
      ),
      'textOnPageLoadAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(curve: Curves.easeInOut, delay: 0.0.ms, duration: 600.0.ms, begin: 0.0, end: 1.0),
          MoveEffect(curve: Curves.easeInOut, delay: 0.0.ms, duration: 600.0.ms, begin: Offset(0.0, 40.0), end: Offset(0.0, 0.0)),
        ],
      ),
      'textOnPageLoadAnimation3': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(curve: Curves.easeInOut, delay: 0.0.ms, duration: 600.0.ms, begin: 0.0, end: 1.0),
          MoveEffect(curve: Curves.easeInOut, delay: 0.0.ms, duration: 600.0.ms, begin: Offset(0.0, 40.0), end: Offset(0.0, 0.0)),
        ],
      ),
    });
    setupAnimations(
      animationsMap.values.where((anim) => anim.trigger == AnimationTrigger.onActionTrigger || !anim.applyInitialState),
      this,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  dynamic _normalizeJson(dynamic raw) {
    if (raw == null) return null;
    if (raw is Map || raw is List) return raw;
    if (raw is String) {
      try {
        return jsonDecode(raw);
      } catch (_) {
        return raw;
      }
    }
    return raw;
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
            icon: Icon(Icons.arrow_back_rounded, color: FlutterFlowTheme.of(context).secondaryText, size: 30.0),
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
            padding: const EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 12.0),
            child: FutureBuilder<List<RecceresponsesRow>>(
              future: FFAppState().recceDetailColumn(
                uniqueQueryKey: 'recceDetailColumn${'recceDetailColumn${currentUserUid}'}',
                requestFn: () => RecceresponsesTable().querySingleRow(
                  queryFn: (q) => q
                      .eqOrNull('reccestageid', widget.recestageId)
                      .eqOrNull('stageNo', 2)
                      .eqOrNull('recceresponseid', widget.receresponseid),
                ),
              ),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: SizedBox(width: 50.0, height: 50.0, child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(FlutterFlowTheme.of(context).primary))),
                  );
                }
                final rows = snapshot.data!;
                final row = rows.isNotEmpty ? rows.first : null;

                // prefer passed recceflatJson, fallback to fetched row.formjson
                final rawData = widget.recceflatJson ?? row?.formjson;
                final data = _normalizeJson(rawData);

                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Heading: project name + createdAt if present
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 12.0),
                        child: Text(
                          // projectname field not present on RecceresponsesRow, prefer passed projectName and fallback to projectid if available
                          widget.projectName ?? row?.projectid ?? 'Project Name',
                          style: FlutterFlowTheme.of(context).displaySmall.override(font: GoogleFonts.interTight(), fontSize: 30.0, fontWeight: FontWeight.w600),
                        ).animateOnPageLoad(animationsMap['textOnPageLoadAnimation1']!),
                      ),
                      if (row?.createdat != null)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: Text('Response time: ${row!.createdat}', style: FlutterFlowTheme.of(context).bodySmall),
                        ),
                      Divider(height: 20.0, thickness: 1.0, color: const Color(0xFFE0E3E7)).animateOnPageLoad(animationsMap['dividerOnPageLoadAnimation']!),

                      const SizedBox(height: 8),

                      // Render JSON data
                      if (data == null)
                        Padding(padding: const EdgeInsets.symmetric(vertical: 20.0), child: Text('No form data available', style: FlutterFlowTheme.of(context).bodySmall))
                      else
                        _renderJsonWidget(context, data),

                      const SizedBox(height: 28),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}