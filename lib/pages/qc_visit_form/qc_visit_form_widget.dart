import '/auth/supabase_auth/auth_util.dart';
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import '/pages/qc_form_component/qc_form_component_widget.dart';
import '/index.dart';
import '/pages/profile/profile_widget.dart'; // <<-- added import
import 'dart:math';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'qc_visit_form_model.dart';
export 'qc_visit_form_model.dart';

class QcVisitFormWidget extends StatefulWidget {
  const QcVisitFormWidget({
    super.key,
    required this.projectId,
    required this.recestageId,
  });

  final String? projectId;
  final String? recestageId;

  static String routeName = 'qcVisitForm';
  static String routePath = '/qcVisitForm';

  @override
  State<QcVisitFormWidget> createState() => _QcVisitFormWidgetState();
}

class _QcVisitFormWidgetState extends State<QcVisitFormWidget>
    with TickerProviderStateMixin {
  late QcVisitFormModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  LatLng? currentUserLocationValue;

  // NEW: visit/template & media state
  String? templateTypeValue;
  final TextEditingController siteVisitNumberController = TextEditingController();
  DateTime? siteVisitDate;
  final TextEditingController siteVisitDateController = TextEditingController();

  String? siteSurroundingsVideoUrl;
  String streetAisle = 'Street on both sides';
  String? northFacingPhotoUrl;
  String facadeType = 'Single facade';
  String? completeFacadePhotoUrl;
  String? lhsPhotoUrl;
  String? rhsPhotoUrl;
  String? oppositePhotoUrl;

  String? selectedProjectId;
  String? selectedProjectName;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => QcVisitFormModel());

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

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
    siteVisitNumberController.dispose();
    siteVisitDateController.dispose();
    _model.textController?.dispose();
    _model.textFieldFocusNode?.dispose();
    super.dispose();
  }

  // helper for media upload (copied/adapted)
  Future<String?> _uploadMedia(String storageFolder, {bool allowVideo = false}) async {
    try {
      final selectedMedia = await selectMediaWithSourceBottomSheet(
        context: context,
        storageFolderPath: storageFolder,
        allowPhoto: true,
        allowVideo: allowVideo,
      );
      if (selectedMedia == null) return null;

      final allValid = selectedMedia.every((m) {
        final path = (m.storagePath ?? m.originalFilename);
        return path != null && validateFileFormat(path, context);
      });
      if (!allValid) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Unsupported file format selected')));
        return null;
      }

      final downloadUrls = await uploadSupabaseStorageFiles(bucketName: 'rece', selectedFiles: selectedMedia);
      if (downloadUrls.isNotEmpty) return downloadUrls.first;
      return null;
    } catch (e, st) {
      print('Upload error: $e\n$st');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Upload failed: ${e.toString()}')));
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    final theme = FlutterFlowTheme.of(context);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,

        // NEW: AppBar similar to qc_widget.dart
        appBar: AppBar(
          backgroundColor: theme.secondaryBackground,
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
              const SizedBox(width: 12.0),
              Text(
                'QC Visit Form',
                style: theme.titleMedium!.override(
                  font: GoogleFonts.interTight(
                    fontWeight: FontWeight.w600,
                    fontStyle: theme.titleMedium!.fontStyle,
                  ),
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w600,
                  fontStyle: theme.titleMedium!.fontStyle,
                ),
              ),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  FlutterFlowIconButton(
                    borderRadius: 20.0,
                    buttonSize: 40.0,
                    fillColor: theme.primary,
                    icon: const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 20.0,
                    ),
                    onPressed: () async {
                      context.pushNamed(ProfileWidget.routeName);
                    },
                  ),
                ],
              ),
            ),
          ],
          centerTitle: false,
          elevation: 0.0,
        ),

        backgroundColor: theme.primaryBackground,
        body: SafeArea(
          top: true,
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(14.0, 0.0, 14.0, 0.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back button + title area (keeps existing back button look)
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
                    child: FlutterFlowIconButton(
                      borderColor: const Color(0xFF707476),
                      borderRadius: 30.0,
                      borderWidth: 1.0,
                      buttonSize: 40.0,
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                        size: 24.0,
                      ),
                      onPressed: () async {
                        context.safePop();
                      },
                    ),
                  ),

                  // PROJECT DROPDOWN
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 12.0),
                    child: FutureBuilder<List<ProjectsRow>>(
                      future: ProjectsTable().queryRows(
                        queryFn: (q) => q.order('createdat', ascending: false),
                      ),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const SizedBox(
                            height: 48,
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }

                        final projects = snapshot.data!;

                        // If there are no projects, show a disabled dropdown (avoid downstream asserts).
                        if (projects.isEmpty) {
                          return DropdownButtonFormField<String>(
                            value: null,
                            decoration: const InputDecoration(
                              labelText: 'Select Project',
                              border: OutlineInputBorder(),
                              isDense: true,
                            ),
                            items: const [],
                            onChanged: null,
                          );
                        }

                        // Remove duplicates / null ids to avoid Dropdown assertion:
                        final Map<String, ProjectsRow> uniqueById = {};
                        for (final p in projects) {
                          final id = (p.projectid ?? '').toString();
                          if (id.isEmpty) continue;
                          uniqueById.putIfAbsent(id, () => p);
                        }
                        final uniqueProjects = uniqueById.values.toList();

                        // Use the unique list if available, otherwise the original list.
                        final source = uniqueProjects.isNotEmpty ? uniqueProjects : projects;

                        final items = source
                            .map(
                              (p) => DropdownMenuItem<String>(
                                value: p.projectid,
                                child: Text(p.name ?? 'Unnamed project'),
                              ),
                            )
                            .toList();

                        // Ensure the Dropdown value matches one of the items; otherwise use null.
                        final rawValue = selectedProjectId ?? widget.projectId;
                        final hasMatch = rawValue != null && items.any((it) => it.value == rawValue);

                        return DropdownButtonFormField<String>(
                          value: hasMatch ? rawValue : null,
                          decoration: const InputDecoration(
                            labelText: 'Select Project',
                            border: OutlineInputBorder(),
                            isDense: true,
                          ),
                          items: items,
                          onChanged: (val) {
                            final project = source.firstWhere(
                              (p) => p.projectid == val,
                              orElse: () => source.first,
                            );
                            setState(() {
                              selectedProjectId = val;
                              selectedProjectName = project.name;
                            });
                          },
                        );
                      },
                    ),
                  ),

                  // TEMPLATE & VISIT DETAILS (Section 1)
                  Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                        Text('Template & Visit Documentation', style: theme.titleSmall),
                        const SizedBox(height: 8),
                        DropdownButtonFormField<String>(
                          value: templateTypeValue,
                          decoration: const InputDecoration(labelText: 'Template Type', isDense: true),
                          items: <String>[
                            'Site Reccee',
                            'Site Visit',
                            'Post MEP works site visit',
                            'Bill Certification',
                            'Pre handover site visit',
                            'Post hand over / Project closure visit',
                            'Asset Audit or Final Audit',
                            'Brand over site Prototype/sample meeting'
                          ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                          onChanged: (v) => setState(() => templateTypeValue = v),
                        ),
                        const SizedBox(height: 8),
                        Row(children: [
                          Expanded(
                            child: TextFormField(
                              controller: siteVisitNumberController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(labelText: 'Site Visit Number', isDense: true),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextFormField(
                              controller: siteVisitDateController,
                              readOnly: true,
                              decoration: const InputDecoration(labelText: 'Site Visit Date', isDense: true, suffixIcon: Icon(Icons.calendar_today)),
                              onTap: () async {
                                final picked = await showDatePicker(context: context, initialDate: siteVisitDate ?? DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(2100));
                                if (picked != null) {
                                  setState(() {
                                    siteVisitDate = picked;
                                    siteVisitDateController.text = picked.toIso8601String().split('T').first;
                                  });
                                }
                              },
                            ),
                          ),
                        ]),
                      ]),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // SITE LOCATION & SURROUNDINGS (Media Section)
                  Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                        Text('Site Location & Surroundings (Media / Visual Evidence)', style: theme.titleSmall),
                        const SizedBox(height: 8),

                        Row(children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () async {
                                final url = await _uploadMedia('site_surroundings_videos', allowVideo: true);
                                if (url != null) setState(() => siteSurroundingsVideoUrl = url);
                              },
                              child: const Text('Upload Site Surroundings Video'),
                            ),
                          ),
                          const SizedBox(width: 8),
                          if (siteSurroundingsVideoUrl != null) const Icon(Icons.check_circle, color: Colors.green),
                        ]),

                        const SizedBox(height: 8),
                        Align(alignment: Alignment.centerLeft, child: Text('Street/Aisle Description', style: theme.bodyMedium)),
                        RadioListTile<String>(title: const Text('Street on both sides'), value: 'Street on both sides', groupValue: streetAisle, onChanged: (v) => setState(() => streetAisle = v!)),
                        RadioListTile<String>(title: const Text('Aisle'), value: 'Aisle', groupValue: streetAisle, onChanged: (v) => setState(() => streetAisle = v!)),

                        const SizedBox(height: 8),
                        Row(children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () async {
                                final url = await _uploadMedia('north_facing_photo');
                                if (url != null) setState(() => northFacingPhotoUrl = url);
                              },
                              child: const Text('North Direction & Facing Photo'),
                            ),
                          ),
                          const SizedBox(width: 8),
                          if (northFacingPhotoUrl != null) const Icon(Icons.check_circle, color: Colors.green),
                        ]),

                        const SizedBox(height: 8),
                        Align(alignment: Alignment.centerLeft, child: Text('Facade Type', style: theme.bodyMedium)),
                        RadioListTile<String>(title: const Text('Single facade'), value: 'Single facade', groupValue: facadeType, onChanged: (v) => setState(() => facadeType = v!)),
                        RadioListTile<String>(title: const Text('Corner facade'), value: 'Corner facade', groupValue: facadeType, onChanged: (v) => setState(() => facadeType = v!)),
                        RadioListTile<String>(title: const Text('Opp sides facade'), value: 'Opp sides facade', groupValue: facadeType, onChanged: (v) => setState(() => facadeType = v!)),
                        RadioListTile<String>(title: const Text('Any other'), value: 'Any other', groupValue: facadeType, onChanged: (v) => setState(() => facadeType = v!)),

                        const SizedBox(height: 8),
                        Row(children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () async {
                                final url = await _uploadMedia('complete_facade_photo');
                                if (url != null) setState(() => completeFacadePhotoUrl = url);
                              },
                              child: const Text('Complete Site Facade Photo'),
                            ),
                          ),
                          const SizedBox(width: 8),
                          if (completeFacadePhotoUrl != null) const Icon(Icons.check_circle, color: Colors.green),
                        ]),

                        const SizedBox(height: 8),
                        Row(children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () async {
                                final url = await _uploadMedia('lhs_site_photo');
                                if (url != null) setState(() => lhsPhotoUrl = url);
                              },
                              child: const Text('LHS of Site Photo'),
                            ),
                          ),
                          const SizedBox(width: 8),
                          if (lhsPhotoUrl != null) const Icon(Icons.check_circle, color: Colors.green),
                        ]),

                        const SizedBox(height: 8),
                        Row(children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () async {
                                final url = await _uploadMedia('rhs_site_photo');
                                if (url != null) setState(() => rhsPhotoUrl = url);
                              },
                              child: const Text('RHS of Site Photo'),
                            ),
                          ),
                          const SizedBox(width: 8),
                          if (rhsPhotoUrl != null) const Icon(Icons.check_circle, color: Colors.green),
                        ]),

                        const SizedBox(height: 8),
                        Row(children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () async {
                                final url = await _uploadMedia('opposite_side_site_photo');
                                if (url != null) setState(() => oppositePhotoUrl = url);
                              },
                              child: const Text('Opposite Side of the Site Photo'),
                            ),
                          ),
                          const SizedBox(width: 8),
                          if (oppositePhotoUrl != null) const Icon(Icons.check_circle, color: Colors.green),
                        ]),
                      ]),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // EXISTING: dynamic qc form components (kept as before)
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          FutureBuilder<List<ReccetemplatesRow>>(
                            future: ReccetemplatesTable().querySingleRow(
                              queryFn: (q) => q
                                  .eqOrNull(
                                    'projectid',
                                    widget!.projectId,
                                  )
                                  .eqOrNull(
                                    'version',
                                    '3',
                                  )
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

                              final List<ReccetemplatesRow> listViewReccetemplatesRowList = snapshot.data ?? [];

                              final ReccetemplatesRow? listViewReccetemplatesRow =
                                  listViewReccetemplatesRowList.isNotEmpty ? listViewReccetemplatesRowList.first : null;

                              // Safely extract JSON field and convert to a list.
                              final rawQcJson = getJsonField(
                                listViewReccetemplatesRow?.jsonschema,
                                r'''$.xx''',
                              );

                              final List<dynamic> qcFormList = () {
                                if (rawQcJson == null) return <dynamic>[];
                                if (rawQcJson is List) return List<dynamic>.from(rawQcJson);
                                if (rawQcJson is Iterable) return rawQcJson.toList();
                                // If it's a single object, wrap it so downstream code works.
                                return <dynamic>[rawQcJson];
                              }();

                              if (qcFormList.isEmpty) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                                  child: Text(
                                    'No QC form template found for this project.',
                                    style: FlutterFlowTheme.of(context).bodyMedium,
                                  ),
                                );
                              }

                              return ListView.separated(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                itemCount: qcFormList.length,
                                separatorBuilder: (_, __) => const SizedBox(height: 10.0),
                                itemBuilder: (context, qcFormListIndex) {
                                  final qcFormListItem = qcFormList[qcFormListIndex];
                                  return QcFormComponentWidget(
                                    key: Key('Key06p_${qcFormListIndex}_of_${qcFormList.length}'),
                                    indexNumber: qcFormListIndex,
                                    question: getJsonField(qcFormListItem, r'''$.question''').toString(),
                                    answertType: getJsonField(qcFormListItem, r'''$.answerType''').toString(),
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // SAVE button (existing behavior preserved, but includes visit/media fields in insertion)
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
                    child: FFButtonWidget(
                      onPressed: () async {
                        currentUserLocationValue = await getCurrentUserLocation(
                            defaultLocation: const LatLng(0.0, 0.0));
                        _model.qcroutput =
                            await actions.convertQcResponsesToJson(
                          FFAppState().qcr.map((e) => e.toMap()).toList(),
                        );

                        await RecceresponsesTable().insert({
                          'formjson': <String, dynamic>{
                            'qcr': _model.qcroutput,
                            'visitDocumentation': {
                              'templateType': templateTypeValue,
                              'siteVisitNumber': int.tryParse(siteVisitNumberController.text),
                              'siteVisitDate': siteVisitDate?.toIso8601String(),
                            },
                            'media': {
                              'siteSurroundingsVideoUrl': siteSurroundingsVideoUrl,
                              'streetAisle': streetAisle,
                              'northFacingPhotoUrl': northFacingPhotoUrl,
                              'facadeType': facadeType,
                              'completeFacadePhotoUrl': completeFacadePhotoUrl,
                              'lhsPhotoUrl': lhsPhotoUrl,
                              'rhsPhotoUrl': rhsPhotoUrl,
                              'oppositePhotoUrl': oppositePhotoUrl,
                            },
                          },
                          'submittedby': currentUserUid,
                          'submittedat': supaSerialize<DateTime>(getCurrentTimestamp),
                          'createdat': supaSerialize<DateTime>(getCurrentTimestamp),
                          'reccestageid': widget!.recestageId,
                          'projectid': selectedProjectId ?? widget.projectId,
                          'location': currentUserLocationValue?.toString(),
                          'stageNo': 3,
                        });

                        FFAppState().qcr = [];
                        safeSetState(() {});
                        context.safePop();

                        safeSetState(() {});
                      },
                      text: 'Save',
                      options: FFButtonOptions(
                        width: double.infinity,
                        height: 40.0,
                        padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                        color: theme.secondary,
                        textStyle: theme.titleSmall.override(color: Colors.white),
                        elevation: 0.0,
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
