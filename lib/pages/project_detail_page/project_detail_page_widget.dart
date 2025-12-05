import 'dart:convert';

import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/components/project_assigned_users_component_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_timer.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:math';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'project_detail_page_model.dart';
export 'project_detail_page_model.dart';

class ProjectDetailPageWidget extends StatefulWidget {
  const ProjectDetailPageWidget({
    super.key,
    this.projectId,
    this.projectName,
    this.proectImage,
  });

  final String? projectId;
  final String? projectName;
  final String? proectImage;

  static const String routeName = 'projectDetailPage';
  static const String routePath = '/projectDetailPage';

  @override
  State<ProjectDetailPageWidget> createState() =>
      _ProjectDetailPageWidgetState();
}

/* ---------- Small UI helpers ---------- */
Widget _labelValue(BuildContext context, String label, String value) {
  final theme = FlutterFlowTheme.of(context);
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 140,
          child: Text(label,
              style: theme.bodySmall?.override(fontWeight: FontWeight.w600)),
        ),
        Expanded(
          child: Text(value, style: theme.bodyMedium),
        ),
      ],
    ),
  );
}

Widget _jsonInspector(BuildContext context, dynamic jsonData) {
  String pretty;
  try {
    pretty = const JsonEncoder.withIndent('  ').convert(jsonData);
  } catch (_) {
    pretty = jsonData?.toString() ?? '';
  }
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: FlutterFlowTheme.of(context).alternate,
      borderRadius: BorderRadius.circular(8),
    ),
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SelectableText(pretty, style: FlutterFlowTheme.of(context).bodySmall),
    ),
  );
}

/// Render nested details map into section widgets (professional, readable)
List<Widget> _renderDetailsMap(BuildContext context, Map<String, dynamic> map) {
  final theme = FlutterFlowTheme.of(context);
  final widgets = <Widget>[];
  final keys = map.keys.toList();
  keys.sort((a, b) => a.toString().compareTo(b.toString()));
  for (final k in keys) {
    final v = map[k];
    if (v == null) {
      widgets.add(_labelValue(context, k.toString(), 'N/A'));
      continue;
    }

    if (v is Map) {
      widgets.add(Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: ExpansionTile(
          tilePadding: EdgeInsets.zero,
          title: Text(k.toString(), style: theme.bodySmall?.override(fontWeight: FontWeight.w700)),
          children: _renderDetailsMap(context, Map<String, dynamic>.from(v)),
        ),
      ));
      continue;
    }

    if (v is List) {
      widgets.add(Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: ExpansionTile(
          tilePadding: EdgeInsets.zero,
          title: Text(k.toString(), style: theme.bodySmall?.override(fontWeight: FontWeight.w700)),
          children: v.asMap().entries.map<Widget>((e) {
            final idx = e.key;
            final val = e.value;
            if (val is Map) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(children: _renderDetailsMap(context, Map<String, dynamic>.from(val))),
              );
            }
            return ListTile(title: Text('#${idx + 1}'), subtitle: Text(val?.toString() ?? ''));
          }).toList(),
        ),
      ));
      continue;
    }

    widgets.add(_labelValue(context, k.toString(), v.toString()));
  }
  return widgets;
}

/* ---------- Page implementation ---------- */
class _ProjectDetailPageWidgetState extends State<ProjectDetailPageWidget>
    with TickerProviderStateMixin {
  late ProjectDetailPageModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProjectDetailPageModel());

    SchedulerBinding.instance.addPostFrameCallback((_) async {
      try {
        _model.timerController.onStartTimer();
        _model.isDeviceOnlineTImer = await actions.isDeviceOnline();
      } catch (_) {}
      safeSetState(() {});
    });
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  Future<Map<String, dynamic>?> _fetchProjectRow() async {
    if (widget.projectId == null || widget.projectId!.isEmpty) return null;
    try {
      final client = Supabase.instance.client;
      final row = await client
          .from('projects')
          .select()
          .eq('projectid', widget.projectId!)
          .maybeSingle();
      if (row == null) return null;
      if (row is Map<String, dynamic>) return row;
      return Map<String, dynamic>.from(row as Map);
    } catch (e) {
      // ignore: avoid_print
      print('supabase fetch error: $e');
      return null;
    }
  }

  Widget _sectionCard(String title, List<Widget> children) {
    return Card(
      elevation: 0.9,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Text(title,
                style: GoogleFonts.poppins(
                    fontSize: 14, fontWeight: FontWeight.w700, color: FlutterFlowTheme.of(context).primaryText)),
            const Spacer(),
          ]),
          const SizedBox(height: 8),
          ...children,
        ]),
      ),
    );
  }

  // Build team handling section (returns SizedBox.shrink when not present)
  Widget _buildTeamHandlingSection(Map<String, dynamic> details) {
    final theme = FlutterFlowTheme.of(context);
    if (details['teamHandling'] is! Map) return const SizedBox.shrink();
    final t = Map<String, dynamic>.from(details['teamHandling']);
    // Hardcoded keys for display
    return _sectionCard('Team Handling', [
      _labelValue(context, 'Lead Name', t['name']?.toString() ?? 'N/A'),
      _labelValue(context, 'Lead Email', t['email']?.toString() ?? 'N/A'),
      _labelValue(context, 'Lead Phone', t['phone']?.toString() ?? 'N/A'),
      if (t.containsKey('role')) _labelValue(context, 'Role', t['role']?.toString() ?? 'N/A'),
    ]);
  }

  // Build client contact section
  Widget _buildClientContactSection(Map<String, dynamic> details) {
    final theme = FlutterFlowTheme.of(context);
    if (details['clientContact1'] is! Map) return const SizedBox.shrink();
    final c = Map<String, dynamic>.from(details['clientContact1']);
    // Hardcoded keys for display
    return _sectionCard('Client Contact', [
      _labelValue(context, 'Client Name', c['name']?.toString() ?? 'N/A'),
      _labelValue(context, 'Client Email', c['email']?.toString() ?? 'N/A'),
      _labelValue(context, 'Client Phone', c['phone']?.toString() ?? 'N/A'),
      if (c.containsKey('company')) _labelValue(context, 'Company', c['company']?.toString() ?? 'N/A'),
    ]);
  }

  // Small UI: Chip builder for metadata
  Widget _metaChip(String text, BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: theme.secondaryBackground,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: theme.primaryBackground.withOpacity(0.06)),
      ),
      child: Text(text, style: theme.bodySmall),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: theme.primaryBackground,
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
                'Project Detail',
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
                  if (_model.isDeviceOnlineTImer == true)
                    FlutterFlowIconButton(
                      borderRadius: 8.0,
                      buttonSize: 40.0,
                      icon: Icon(
                        Icons.online_prediction,
                        color: Color(0xFF00FF00),
                        size: 24.0,
                      ),
                      onPressed: () {},
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
                      onPressed: () {},
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
        child: FutureBuilder<Map<String, dynamic>?>(
          future: _fetchProjectRow(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: SizedBox(
                  width: 48,
                  height: 48,
                  child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(theme.primary)),
                ),
              );
            }

            final rowMap = snapshot.data ?? <String, dynamic>{};
            _model.rowJson = rowMap;

            // Hardcoded key mapping for display (use fallbacks from rowMap / details)
            final projectNameValue = (rowMap['name'] ?? rowMap['project_name'] ?? widget.projectName ?? 'N/A').toString();
            final projectCodeValue = (rowMap['projectcode'] ?? rowMap['project_code'] ?? 'N/A').toString();
            final clientNameValue = (rowMap['clientname'] ?? rowMap['client_name'] ?? 'N/A').toString();

            // Flexible parsing for project_details
            dynamic rawDetails = rowMap['project_details'] ??
                rowMap['projectDetails'] ??
                rowMap['projectdetails'] ??
                rowMap['details'] ??
                rowMap['project_details_json'];

            _model.updateProjectDetails(rawDetails);
            final details = _model.projectDetailsMap;

            // Hardcoded nested keys with fallbacks
            final cityValue = details['city']?.toString() ?? details['location']?['city']?.toString() ?? 'N/A';
            final addressAreaValue = details['addressArea']?.toString() ?? details['address']?.toString() ?? 'N/A';
            final locationTypeValue = details['locationType']?.toString() ?? 'N/A';
            final projectStateValue = details['projectState']?.toString() ?? 'N/A';
            final brandValue = details['brandName']?.toString() ?? 'N/A';
            final facadeTypeValue = details['facadeType']?.toString() ?? 'N/A';
            final projectSizeValue = details['projectSize']?.toString() ?? 'N/A';

            final clientLogo = (rowMap['clientlogo'] ?? rowMap['client_logo'] ?? rowMap['clientLogo'] ?? '').toString();

            // UI: Professional layout with clear cards, explicit hardcoded labels
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 18.0),
                child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                  // Header card
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Row(children: [
                        // Left avatar / image
                        Container(
                          width: 84,
                          height: 84,
                          decoration: BoxDecoration(
                            color: theme.alternate,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: clientLogo.isNotEmpty
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    clientLogo,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => Center(
                                      child: Icon(Icons.broken_image, color: theme.secondaryText),
                                    ),
                                  ),
                                )
                              : Center(
                                  child: Icon(Icons.image_not_supported_rounded, size: 36, color: theme.secondaryText),
                                ),
                        ),

                        const SizedBox(width: 14),

                        // Title + chips
                        Expanded(
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            AutoSizeText(projectNameValue,
                                maxLines: 2,
                                style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w700)),
                            const SizedBox(height: 8),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(children: [
                                _metaChip('Project Code: $projectCodeValue', context),
                                _metaChip('Client: $clientNameValue', context),
                                _metaChip('City: $cityValue', context),
                                _metaChip('Brand: $brandValue', context),
                              ]),
                            ),
                          ]),
                        ),

                        // Actions
                        Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                          IconButton(
                            icon: const Icon(Icons.edit_outlined),
                            tooltip: 'Edit project',
                            onPressed: () {
                              // keep existing behavior (TODO: implement edit)
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.group_outlined),
                            tooltip: 'Assigned users',
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (_) => ProjectAssignedUsersComponentWidget(projectId: widget.projectId),
                              );
                            },
                          ),
                        ]),
                      ]),
                    ),
                  ),

                  const SizedBox(height: 18),

                  // Overview section (hardcoded labels)
                  _sectionCard('Overview', [
                    _labelValue(context, 'Project Name', projectNameValue),
                    _labelValue(context, 'Project Code', projectCodeValue),
                    _labelValue(context, 'Client', clientNameValue),
                    _labelValue(context, 'State', projectStateValue),
                  ]),

                  const SizedBox(height: 12),

                  // Location section (hardcoded labels)
                  _sectionCard('Location', [
                    _labelValue(context, 'City', cityValue),
                    _labelValue(context, 'Address Area', addressAreaValue),
                    _labelValue(context, 'Location Type', locationTypeValue),
                  ]),

                  const SizedBox(height: 12),

                  // Specifications (hardcoded labels)
                  _sectionCard('Specifications', [
                    _labelValue(context, 'Brand', brandValue),
                    _labelValue(context, 'Facade Type', facadeTypeValue),
                    _labelValue(context, 'Project Size', projectSizeValue),
                  ]),

                  const SizedBox(height: 12),

                  // Detailed specifications - keep dynamic rendering but present in same card style
                  if (details.isNotEmpty)
                    _sectionCard('Detailed specifications', _renderDetailsMap(context, details)),

                  const SizedBox(height: 12),

                  // Team & Client sections (hardcoded keys inside helper functions)
                  _buildTeamHandlingSection(details),
                  const SizedBox(height: 8),
                  _buildClientContactSection(details),

                  const SizedBox(height: 12),

                  // Raw JSON for debugging (kept collapsed)
                  // ExpansionTile(
                  //   title: Text('Raw project JSON', style: theme.bodySmall?.override(fontWeight: FontWeight.w700)),
                  //   children: [
                  //     Padding(padding: const EdgeInsets.all(8.0), child: _jsonInspector(context, _model.rowJson ?? {}))
                  //   ],
                  // ),

                  const SizedBox(height: 28),
                ]),
              ),
            );
          },
        ),
      ),
    );
  }
}


