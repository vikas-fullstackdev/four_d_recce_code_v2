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
  final TextEditingController siteVisitNumberController =
      TextEditingController();
  DateTime? siteVisitDate;
  final TextEditingController siteVisitDateController = TextEditingController();

  String? siteSurroundingsVideoUrl;
  String streetAisle = 'Street on both sides';
  String? northFacingPhotoUrl;
  List<String> northFacingPhotoUrls = [];
  String facadeType = 'Single facade';
  String? completeFacadePhotoUrl;
  List<String> completeFacadePhotoUrls = [];
  String? lhsPhotoUrl;
  List<String> lhsPhotoUrls = [];
  String? rhsPhotoUrl;
  List<String> rhsPhotoUrls = [];
  String? oppositePhotoUrl;
  List<String> oppositePhotoUrls = [];

  // SITE VISIT CHECKLIST state (A & B sections)
  // Section A
  List<String> a1Drawings = [];
  String? a2Is3DAvailable;
  Map<String, String> a3VendorDetails = {};
  Map<String, String> a4VendorReps = {};
  final TextEditingController a5_4dController = TextEditingController();
  final TextEditingController a5_mepController = TextEditingController();
  String? a6MarkingDone;
  final TextEditingController a6ReasonController = TextEditingController();
  List<Map<String, dynamic>> a7Deviations = [];
  List<String> a7MarkingPhotos = [];
  final TextEditingController a7PointsToResolveController =
      TextEditingController();
  final TextEditingController a7FinalSolutionController =
      TextEditingController();
  String? a7FinalSolutionAttachmentUrl;
  List<String> a7FinalSolutionAttachmentUrls = [];
  DateTime? a7FinalSolutionDate;

  // Section B (simplified inputs to capture notes/photos per subsection)
  // Section B detailed state
  // B1 Electrical
  Map<String, String?> b1ConduitStatus = {
    'Electrical': null,
    'CCTV': null,
    'Audio': null,
    'DATA': null,
  };
  Map<String, TextEditingController> b1ReasonControllers = {};
  Map<String, String?> b1Photos = {
    'Electrical': null,
    'CCTV': null,
    'Audio': null,
    'DATA': null,
  };
  Map<String, List<String>> b1PhotosMulti = {
    'Electrical': [],
    'CCTV': [],
    'Audio': [],
    'DATA': [],
  };

  // B2 Fire Safety
  final List<String> b2Items = [
    'SmokeDetectors',
    'FireAlarm',
    'WetRiser',
    'HoseReel',
    'Sprinkler',
    'PressureTesting',
  ];
  // Human readable labels for B2 items
  final Map<String, String> b2Labels = {
    'SmokeDetectors': 'Smoke Detectors Conduit & Wiring',
    'FireAlarm': 'Fire Alarm Conduit & Wiring',
    'WetRiser': 'Wet Riser Points',
    'HoseReel': 'Hose Reel / Hydrant (if any)',
    'Sprinkler': 'Sprinkler Points',
    'PressureTesting':
        'Pressure testing of sprinkler points (24hrs as per NBC)',
  };
  Map<String, String?> b2Reasons = {};
  Map<String, String?> b2Photos = {};
  Map<String, List<String>> b2PhotosMulti = {};
  List<String> b2Certificates = [];

  // B3 HVAC
  Map<String, String?> b3Checks = {
    'DuctableRouting': null,
    'CollarPlenum': null,
    'ReturnAir': null,
    'FreshAir': null,
    'Exhaust': null,
    'ChillerConnection': null,
    'ChillerPressureTest': null,
  };
  Map<String, TextEditingController> b3ReasonControllers = {};
  Map<String, String?> b3Photos = {};
  Map<String, List<String>> b3PhotosMulti = {};
  // Hi-wall / Cassette specific
  Map<String, String?> b3AcChecks = {
    'RefrigerantLine': null,
    'DrainLine': null,
    'DrainSlope': null,
    'CableTray': null,
  };
  final Map<String, String> b3Labels = {
    'DuctableRouting': 'If ductable AC: check routing & size as per drawings',
    'CollarPlenum': 'Check collar / plenum position as per drawing',
    'ReturnAir': 'Has return air provision been taken care as per drawings',
    'FreshAir':
        'Has fresh air intake provision been taken care as per drawings',
    'Exhaust': 'Has exhaust provision been taken care as per drawings',
    'ChillerConnection':
        'If mall/airport: chiller line connection done as per drawings',
    'ChillerPressureTest':
        'Has pressure test for chiller line been done after connecting to FCU/AHU',
  };
  final Map<String, String> b3AcLabels = {
    'RefrigerantLine': 'Refrigerant copper line has been done',
    'DrainLine': 'Drain line has been done',
    'DrainSlope': 'Drain line slope taken care & water testing done',
    'CableTray': 'Cable tray / conduits for the AC has been done',
  };
  Map<String, TextEditingController> b3AcReasonControllers = {};

  // B4 Plumbing & Sanitary
  final List<String> b4RoutingTypes = ['Inlet', 'Drain', 'Sanitary'];
  Map<String, String?> b4RoutingStatus = {};
  Map<String, TextEditingController> b4ReasonControllers = {};
  Map<String, String?> b4Photos = {};
  Map<String, List<String>> b4PhotosMulti = {};
  // B4 additional checks
  Map<String, String?> b4AdditionalChecks = {
    'HotColdSeparated': null,
    'PressureTested': null,
    'SanitarySoilSeparated': null,
    'InspectionChambersOK': null,
  };
  Map<String, TextEditingController> b4AdditionalReasonControllers = {};
  Map<String, String?> b4AdditionalPhotos = {};
  Map<String, List<String>> b4AdditionalPhotosMulti = {};

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

    // initialize dynamic controllers and maps for B-section
    for (final k in b1ConduitStatus.keys) {
      b1ReasonControllers[k] = TextEditingController();
    }

    for (final k in b2Items) {
      b2Reasons[k] = null;
      b2Photos[k] = null;
      b2PhotosMulti[k] = [];
    }

    for (final k in b3Checks.keys) {
      b3ReasonControllers[k] = TextEditingController();
      b3Photos[k] = null;
      b3PhotosMulti[k] = [];
    }
    for (final k in b3AcChecks.keys) {
      b3AcReasonControllers[k] = TextEditingController();
    }

    for (final k in b4RoutingTypes) {
      b4RoutingStatus[k] = null;
      b4ReasonControllers[k] = TextEditingController();
      b4Photos[k] = null;
      b4PhotosMulti[k] = [];
    }
    // extra plumbing quick-check keys
    b4RoutingStatus['MaterialOK'] = null;
    b4ReasonControllers['MaterialOK'] = TextEditingController();
    b4RoutingStatus['ValveAccess'] = null;
    // init B4 additional checks
    for (final k in b4AdditionalChecks.keys) {
      b4AdditionalChecks[k] = null;
      b4AdditionalReasonControllers[k] = TextEditingController();
      b4AdditionalPhotos[k] = null;
      b4AdditionalPhotosMulti[k] = [];
    }

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();
    siteVisitNumberController.dispose();
    siteVisitDateController.dispose();
    _model.textController?.dispose();
    _model.textFieldFocusNode?.dispose();
    // Dispose checklist controllers
    a5_4dController.dispose();
    a5_mepController.dispose();
    a6ReasonController.dispose();
    a7PointsToResolveController.dispose();
    a7FinalSolutionController.dispose();
    // dispose B1 controllers
    for (final c in b1ReasonControllers.values) {
      c.dispose();
    }
    // dispose B3 controllers
    for (final c in b3ReasonControllers.values) {
      c.dispose();
    }
    for (final c in b3AcReasonControllers.values) {
      c.dispose();
    }
    // dispose B4 controllers
    for (final c in b4ReasonControllers.values) {
      c.dispose();
    }
    // dispose B4 additional controllers
    for (final c in b4AdditionalReasonControllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  // helper for media upload (copied/adapted)
  Future<List<String>?> _uploadMedia(String storageFolder,
      {bool allowVideo = false, bool multiImage = false}) async {
    try {
      // store media under bucket 'project_uploads' in folder 'recce/<storageFolder>'
      final selectedMedia = await selectMediaWithSourceBottomSheet(
        context: context,
        storageFolderPath: 'recce/$storageFolder',
        allowPhoto: true,
        allowVideo: allowVideo,
        multiImage: multiImage,
      );
      if (selectedMedia == null) return null;

      final allValid = selectedMedia.every((m) {
        final path = (m.storagePath ?? m.originalFilename);
        return path != null && validateFileFormat(path, context);
      });
      if (!allValid) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Unsupported file format selected')));
        return null;
      }

      final downloadUrls = await uploadSupabaseStorageFiles(
          bucketName: 'project_uploads', selectedFiles: selectedMedia);
      if (downloadUrls.isNotEmpty) return downloadUrls;
      return null;
    } catch (e, st) {
      print('Upload error: $e\n$st');
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Upload failed: ${e.toString()}')));
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
              padding:
                  const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
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
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        0.0, 10.0, 0.0, 10.0),
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
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        10.0, 0.0, 10.0, 12.0),
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
                        final source = uniqueProjects.isNotEmpty
                            ? uniqueProjects
                            : projects;

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
                        final hasMatch = rawValue != null &&
                            items.any((it) => it.value == rawValue);

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
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    elevation: 1,
                    // child: Padding(
                    //   padding: const EdgeInsets.all(12.0),
                    //   child: Column(
                    //       crossAxisAlignment: CrossAxisAlignment.stretch,
                    //       children: [
                    //         Text('Template & Visit Documentation',
                    //             style: theme.titleSmall),
                    //         const SizedBox(height: 8),
                    //         DropdownButtonFormField<String>(
                    //           value: templateTypeValue,
                    //           decoration: const InputDecoration(
                    //               labelText: 'Template Type', isDense: true),
                    //           items: <String>[
                    //             'Site Reccee',
                    //             'Site Visit',
                    //             'Post MEP works site visit',
                    //             'Bill Certification',
                    //             'Pre handover site visit',
                    //             'Post hand over / Project closure visit',
                    //             'Asset Audit or Final Audit',
                    //             'Brand over site Prototype/sample meeting'
                    //           ]
                    //               .map((e) => DropdownMenuItem(
                    //                   value: e, child: Text(e)))
                    //               .toList(),
                    //           onChanged: (v) =>
                    //               setState(() => templateTypeValue = v),
                    //         ),
                    //         const SizedBox(height: 8),
                    //         Row(children: [
                    //           Expanded(
                    //             child: TextFormField(
                    //               controller: siteVisitNumberController,
                    //               keyboardType: TextInputType.number,
                    //               decoration: const InputDecoration(
                    //                   labelText: 'Site Visit Number',
                    //                   isDense: true),
                    //             ),
                    //           ),
                    //           const SizedBox(width: 8),
                    //           Expanded(
                    //             child: TextFormField(
                    //               controller: siteVisitDateController,
                    //               readOnly: true,
                    //               decoration: const InputDecoration(
                    //                   labelText: 'Site Visit Date',
                    //                   isDense: true,
                    //                   suffixIcon: Icon(Icons.calendar_today)),
                    //               onTap: () async {
                    //                 final picked = await showDatePicker(
                    //                     context: context,
                    //                     initialDate:
                    //                         siteVisitDate ?? DateTime.now(),
                    //                     firstDate: DateTime(2000),
                    //                     lastDate: DateTime(2100));
                    //                 if (picked != null) {
                    //                   setState(() {
                    //                     siteVisitDate = picked;
                    //                     siteVisitDateController.text = picked
                    //                         .toIso8601String()
                    //                         .split('T')
                    //                         .first;
                    //                   });
                    //                 }
                    //               },
                    //             ),
                    //           ),
                    //         ]),
                    //       ]),
                    // ),
                  ),

                  // SITE VISIT CHECKLIST (Sections A & B)
                  const SizedBox(height: 12),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    elevation: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text('SITE VISIT CHECKLIST',
                                style: theme.titleSmall),
                            const SizedBox(height: 8),

                            // Section A: Site visit for briefing / kick off
                            ExpansionTile(
                              title: const Text(
                                  'A. SITE VISIT FOR BRIEFING / KICK OFF'),
                              children: [
                                // A1 Drawings available (checkboxes)
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        'A1. What Drawings are available at site?',
                                        style: theme.bodyMedium)),
                                Wrap(
                                  spacing: 8.0,
                                  children: [
                                    for (final opt in [
                                      '1st Set Dwgs',
                                      'MEP Set',
                                      '2nd Set',
                                      'Full GFC Set'
                                    ])
                                      FilterChip(
                                        label: Text(opt),
                                        selected: a1Drawings.contains(opt),
                                        onSelected: (s) => setState(() => s
                                            ? a1Drawings.add(opt)
                                            : a1Drawings.remove(opt)),
                                      ),
                                  ],
                                ),
                                const SizedBox(height: 8),

                                // A2 3D available
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        'A2. Is 3D available for this project?',
                                        style: theme.bodyMedium)),
                                RadioListTile<String>(
                                    title: const Text('Yes'),
                                    value: 'Yes',
                                    groupValue: a2Is3DAvailable,
                                    onChanged: (v) =>
                                        setState(() => a2Is3DAvailable = v)),
                                RadioListTile<String>(
                                    title: const Text('No'),
                                    value: 'No',
                                    groupValue: a2Is3DAvailable,
                                    onChanged: (v) =>
                                        setState(() => a2Is3DAvailable = v)),
                                RadioListTile<String>(
                                    title: const Text('NA'),
                                    value: 'NA',
                                    groupValue: a2Is3DAvailable,
                                    onChanged: (v) =>
                                        setState(() => a2Is3DAvailable = v)),
                                const SizedBox(height: 8),

                                // A3 Vendors (simple inputs to capture details per vendor type)
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        'A3. Appointed Vendor Details (enter Company / Person / Email / Phone)',
                                        style: theme.bodyMedium)),
                                const SizedBox(height: 6),
                                for (final vendor in [
                                  'GC',
                                  'Electrical',
                                  'HVAC',
                                  'Fire Safety',
                                  'Plumbing & Sanitary',
                                  'Façade',
                                  'Signage',
                                  'Furniture & Fixtures',
                                  'Lighting Supplier',
                                  'Any Other'
                                ])
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0),
                                    child: TextFormField(
                                      initialValue: a3VendorDetails[vendor],
                                      decoration: InputDecoration(
                                          labelText: vendor,
                                          isDense: true,
                                          border: const OutlineInputBorder()),
                                      onChanged: (v) => setState(
                                          () => a3VendorDetails[vendor] = v),
                                    ),
                                  ),

                                const SizedBox(height: 8),
                                // A4 Vendor Representative
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        'A4. Name of the Vendor Representative (Person / Email / Phone)',
                                        style: theme.bodyMedium)),
                                const SizedBox(height: 6),
                                for (final vendor in [
                                  'GC',
                                  'Electrical',
                                  'HVAC',
                                  'Fire Safety',
                                  'Plumbing & Sanitary',
                                  'Façade',
                                  'Signage',
                                  'Furniture & Fixtures',
                                  'Lighting Supplier',
                                  'Any Other'
                                ])
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0),
                                    child: TextFormField(
                                      initialValue: a4VendorReps[vendor],
                                      decoration: InputDecoration(
                                          labelText: vendor,
                                          isDense: true,
                                          border: const OutlineInputBorder()),
                                      onChanged: (v) => setState(
                                          () => a4VendorReps[vendor] = v),
                                    ),
                                  ),

                                const SizedBox(height: 8),
                                // A5 Briefing done by?
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        'A5. MEP Vendor Briefing done by?',
                                        style: theme.bodyMedium)),
                                const SizedBox(height: 6),
                                TextFormField(
                                    controller: a5_4dController,
                                    decoration: const InputDecoration(
                                        labelText:
                                            '4D - Person Name / Email / Phone',
                                        isDense: true)),
                                const SizedBox(height: 6),
                                TextFormField(
                                    controller: a5_mepController,
                                    decoration: const InputDecoration(
                                        labelText:
                                            'MEP Consultant - Person Name / Email / Phone',
                                        isDense: true)),

                                const SizedBox(height: 8),
                                // A6 Marking done
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        'A6. Have you got done marking of main reference line as per marking drawing?',
                                        style: theme.bodyMedium)),
                                RadioListTile<String>(
                                    title: const Text('Yes'),
                                    value: 'Yes',
                                    groupValue: a6MarkingDone,
                                    onChanged: (v) =>
                                        setState(() => a6MarkingDone = v)),
                                RadioListTile<String>(
                                    title: const Text('No'),
                                    value: 'No',
                                    groupValue: a6MarkingDone,
                                    onChanged: (v) =>
                                        setState(() => a6MarkingDone = v)),
                                if (a6MarkingDone == 'No')
                                  Padding(
                                      padding: const EdgeInsets.only(top: 6.0),
                                      child: TextFormField(
                                          controller: a6ReasonController,
                                          decoration: const InputDecoration(
                                              labelText:
                                                  'If No - Enter the reason',
                                              isDense: true))),

                                const SizedBox(height: 8),
                                // A7 Deviations (simple dynamic list)
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        'A7. Deviations from Plan (add multiple)',
                                        style: theme.bodyMedium)),
                                const SizedBox(height: 6),
                                Column(
                                  children: [
                                    for (var i = 0;
                                        i < a7Deviations.length;
                                        i++)
                                      Card(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(children: [
                                            TextFormField(
                                                initialValue: a7Deviations[i]
                                                    ['problem'] as String?,
                                                decoration:
                                                    const InputDecoration(
                                                        labelText: 'Problem',
                                                        isDense: true),
                                                onChanged: (v) => setState(() =>
                                                    a7Deviations[i]['problem'] =
                                                        v)),
                                            const SizedBox(height: 6),
                                            TextFormField(
                                                initialValue: a7Deviations[i]
                                                    ['solution'] as String?,
                                                decoration:
                                                    const InputDecoration(
                                                        labelText: 'Solution',
                                                        isDense: true),
                                                onChanged: (v) => setState(() =>
                                                    a7Deviations[i]
                                                        ['solution'] = v)),
                                            const SizedBox(height: 6),
                                            Row(children: [
                                              ElevatedButton(
                                                onPressed: () async {
                                                  // pick photos for this deviation (allow multiple)
                                                  final urls =
                                                      await _uploadMedia(
                                                          'deviations',
                                                          multiImage: true);
                                                  if (urls != null &&
                                                      urls.isNotEmpty)
                                                    setState(() {
                                                      a7Deviations[i]['photo'] =
                                                          urls.first;
                                                      a7Deviations[i]
                                                          ['photoUrls'] = urls;
                                                    });
                                                },
                                                child: const Text(
                                                    'Attach Photo / Video'),
                                              ),
                                              const SizedBox(width: 8),
                                              if (a7Deviations[i]['photo'] !=
                                                  null)
                                                const Icon(Icons.check_circle,
                                                    color: Colors.green),
                                              const Spacer(),
                                              IconButton(
                                                  icon:
                                                      const Icon(Icons.delete),
                                                  onPressed: () => setState(
                                                      () => a7Deviations
                                                          .removeAt(i))),
                                            ])
                                          ]),
                                        ),
                                      ),
                                    const SizedBox(height: 6),
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: ElevatedButton(
                                            onPressed: () => setState(() =>
                                                a7Deviations.add({
                                                  'problem': '',
                                                  'solution': '',
                                                  'photo': null
                                                })),
                                            child:
                                                const Text('Add Deviation'))),
                                  ],
                                ),

                                const SizedBox(height: 8),
                                // Marking photos (multiple)
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        'Take Photo / video of marking done (you can add multiple)',
                                        style: theme.bodyMedium)),
                                const SizedBox(height: 6),
                                Row(children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        try {
                                          final selectedMedia =
                                              await selectMediaWithSourceBottomSheet(
                                                  context: context,
                                                  allowPhoto: true,
                                                  allowVideo: true,
                                                  multiImage: true,
                                                  storageFolderPath:
                                                      'recce/marking_photos');
                                          if (selectedMedia != null &&
                                              selectedMedia.isNotEmpty) {
                                            final urls =
                                                await uploadSupabaseStorageFiles(
                                                    bucketName:
                                                        'project_uploads',
                                                    selectedFiles:
                                                        selectedMedia);
                                            if (urls.isNotEmpty)
                                              setState(() =>
                                                  a7MarkingPhotos.addAll(urls));
                                          }
                                        } catch (e) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                                      'Upload failed: $e')));
                                        }
                                      },
                                      child: const Text(
                                          'Add Marking Photos / Videos'),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  if (a7MarkingPhotos.isNotEmpty)
                                    Text('${a7MarkingPhotos.length} files'),
                                ]),

                                const SizedBox(height: 8),
                                TextFormField(
                                    controller: a7PointsToResolveController,
                                    decoration: const InputDecoration(
                                        labelText:
                                            'Points to be resolved at office',
                                        isDense: true,
                                        border: OutlineInputBorder())),
                                const SizedBox(height: 6),
                                TextFormField(
                                    controller: a7FinalSolutionController,
                                    decoration: const InputDecoration(
                                        labelText:
                                            'Please enter the solution finalised',
                                        isDense: true)),
                                const SizedBox(height: 6),
                                Row(children: [
                                  ElevatedButton(
                                      onPressed: () async {
                                        final urls = await _uploadMedia(
                                            'final_solution_attachments',
                                            multiImage: true);
                                        if (urls != null && urls.isNotEmpty)
                                          setState(() {
                                            a7FinalSolutionAttachmentUrl =
                                                urls.first;
                                            a7FinalSolutionAttachmentUrls =
                                                urls;
                                          });
                                      },
                                      child:
                                          const Text('Attach Photo/Video/PDF')),
                                  const SizedBox(width: 8),
                                  ElevatedButton(
                                      onPressed: () async {
                                        final picked = await showDatePicker(
                                            context: context,
                                            initialDate: a7FinalSolutionDate ??
                                                DateTime.now(),
                                            firstDate: DateTime(2000),
                                            lastDate: DateTime(2100));
                                        if (picked != null)
                                          setState(() =>
                                              a7FinalSolutionDate = picked);
                                      },
                                      child: const Text('Select Date')),
                                  const SizedBox(width: 8),
                                  if (a7FinalSolutionAttachmentUrl != null)
                                    const Icon(Icons.check_circle,
                                        color: Colors.green),
                                ]),
                              ],
                            ),

                            const SizedBox(height: 12),
                            // Section B: Post MEP Works Site Visit (detailed checklist)
                            ExpansionTile(
                              title: const Text('B. POST MEP WORKS SITE VISIT'),
                              children: [
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text('B1. ELECTRICAL',
                                        style: theme.bodyMedium)),
                                const SizedBox(height: 6),
                                for (final key in b1ConduitStatus.keys)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 6.0),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Text(
                                              'Are all conduits & wiring done as per drawings? ($key)',
                                              style: theme.bodySmall),
                                          RadioListTile<String>(
                                              title: const Text('Yes'),
                                              value: 'Yes',
                                              groupValue: b1ConduitStatus[key],
                                              onChanged: (v) => setState(() =>
                                                  b1ConduitStatus[key] = v)),
                                          RadioListTile<String>(
                                              title: const Text('No'),
                                              value: 'No',
                                              groupValue: b1ConduitStatus[key],
                                              onChanged: (v) => setState(() =>
                                                  b1ConduitStatus[key] = v)),
                                          // reason only when No
                                          if (b1ConduitStatus[key] == 'No')
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 6.0),
                                              child: TextFormField(
                                                  controller:
                                                      b1ReasonControllers[key],
                                                  decoration: const InputDecoration(
                                                      labelText:
                                                          'If No - Enter the reason',
                                                      isDense: true)),
                                            ),
                                          const SizedBox(height: 6),
                                          // always show upload button
                                          Row(children: [
                                            ElevatedButton(
                                                onPressed: () async {
                                                  final urls = await _uploadMedia(
                                                      'b1_${key.toLowerCase()}',
                                                      multiImage: true);
                                                  if (urls != null &&
                                                      urls.isNotEmpty) {
                                                    setState(() {
                                                      b1Photos[key] =
                                                          urls.first;
                                                      b1PhotosMulti[key] = urls;
                                                    });
                                                  }
                                                },
                                                child:
                                                    Text('Attach $key Photo')),
                                            const SizedBox(width: 8),
                                            if (b1Photos[key] != null)
                                              const Icon(Icons.check_circle,
                                                  color: Colors.green),
                                          ])
                                        ]),
                                  ),

                                const SizedBox(height: 12),
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text('B2. FIRE SAFETY',
                                        style: theme.bodyMedium)),
                                const SizedBox(height: 6),
                                for (final item in b2Items)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 6.0),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          if (item != 'PressureTesting') ...[
                                            Text(b2Labels[item] ?? item),
                                            const SizedBox(height: 6),
                                            TextFormField(
                                              maxLines: 2,
                                              decoration: const InputDecoration(
                                                  labelText:
                                                      'Enter reason / observations & attach photo',
                                                  border: OutlineInputBorder()),
                                              onChanged: (v) => setState(
                                                  () => b2Reasons[item] = v),
                                            ),
                                            const SizedBox(height: 6),
                                            Row(children: [
                                              ElevatedButton(
                                                  onPressed: () async {
                                                    final urls = await _uploadMedia(
                                                        'b2_${item.toLowerCase()}',
                                                        multiImage: true);
                                                    if (urls != null &&
                                                        urls.isNotEmpty)
                                                      setState(() {
                                                        b2Photos[item] =
                                                            urls.first;
                                                        b2PhotosMulti[item] =
                                                            urls;
                                                      });
                                                  },
                                                  child: const Text(
                                                      'Attach Photo / Video')),
                                              const SizedBox(width: 8),
                                              if (b2Photos[item] != null)
                                                const Icon(Icons.check_circle,
                                                    color: Colors.green),
                                            ])
                                          ] else ...[
                                            // Pressure testing question
                                            Text(
                                                'Has pressure testing of all sprinkler points been done for 24hrs as per NBC standards?',
                                                style: theme.bodySmall),
                                            RadioListTile<String>(
                                                title: const Text('Yes'),
                                                value: 'Yes',
                                                groupValue: b2Reasons[item],
                                                onChanged: (v) => setState(
                                                    () => b2Reasons[item] = v)),
                                            RadioListTile<String>(
                                                title: const Text('No'),
                                                value: 'No',
                                                groupValue: b2Reasons[item],
                                                onChanged: (v) => setState(
                                                    () => b2Reasons[item] = v)),
                                            if (b2Reasons[item] == 'No')
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 6.0),
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .stretch,
                                                    children: [
                                                      TextFormField(
                                                          decoration:
                                                              const InputDecoration(
                                                                  labelText:
                                                                      'Enter reason & attach photo',
                                                                  isDense:
                                                                      true)),
                                                      const SizedBox(height: 6),
                                                      ElevatedButton(
                                                          onPressed: () async {
                                                            final urls =
                                                                await _uploadMedia(
                                                                    'b2_pressure_testing',
                                                                    multiImage:
                                                                        true);
                                                            if (urls != null &&
                                                                urls.isNotEmpty) {
                                                              setState(() {
                                                                b2Photos[item] =
                                                                    urls.first;
                                                                b2PhotosMulti[
                                                                        item] =
                                                                    urls;
                                                              });
                                                            }
                                                          },
                                                          child: const Text(
                                                              'Attach Photo / Video')),
                                                    ]),
                                              )
                                          ]
                                        ]),
                                  ),

                                const SizedBox(height: 8),
                                Row(children: [
                                  ElevatedButton(
                                      onPressed: () async {
                                        try {
                                          final selectedMedia =
                                              await selectMediaWithSourceBottomSheet(
                                                  context: context,
                                                  allowPhoto: true,
                                                  allowVideo: true,
                                                  multiImage: true,
                                                  storageFolderPath:
                                                      'recce/b2_certificates');
                                          if (selectedMedia != null &&
                                              selectedMedia.isNotEmpty) {
                                            final urls =
                                                await uploadSupabaseStorageFiles(
                                                    bucketName:
                                                        'project_uploads',
                                                    selectedFiles:
                                                        selectedMedia);
                                            if (urls.isNotEmpty)
                                              setState(() =>
                                                  b2Certificates.addAll(urls));
                                          }
                                        } catch (e) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                                      'Upload failed: $e')));
                                        }
                                      },
                                      child: const Text(
                                          'Upload Certificates from Vendors')),
                                  const SizedBox(width: 8),
                                  if (b2Certificates.isNotEmpty)
                                    Text('${b2Certificates.length} files')
                                ]),

                                const SizedBox(height: 12),
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text('B3. HVAC LOW SIDE WORKS',
                                        style: theme.bodyMedium)),
                                const SizedBox(height: 6),
                                for (final k in b3Checks.keys)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 6.0),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Text(b3Labels[k] ?? k),
                                          RadioListTile<String>(
                                              title: const Text('Yes'),
                                              value: 'Yes',
                                              groupValue: b3Checks[k],
                                              onChanged: (v) => setState(
                                                  () => b3Checks[k] = v)),
                                          RadioListTile<String>(
                                              title: const Text('No'),
                                              value: 'No',
                                              groupValue: b3Checks[k],
                                              onChanged: (v) => setState(
                                                  () => b3Checks[k] = v)),
                                          if (b3Checks[k] == 'No')
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 6.0),
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .stretch,
                                                  children: [
                                                    TextFormField(
                                                        controller:
                                                            b3ReasonControllers[
                                                                k],
                                                        decoration:
                                                            const InputDecoration(
                                                                labelText:
                                                                    'If No - Enter the reason',
                                                                isDense: true)),
                                                    const SizedBox(height: 6),
                          ElevatedButton(
                            onPressed: () async {
                              final urls =
                                await _uploadMedia(
                                  'b3_${k.toLowerCase()}',
                                  multiImage:
                                    true);
                              if (urls != null &&
                                urls.isNotEmpty)
                              setState(() {
                                b3Photos[k] =
                                  urls.first;
                                b3PhotosMulti[k] =
                                  urls;
                              });
                            },
                            child: const Text(
                              'Attach Photo / Video')),
                          const SizedBox(width: 8),
                          if (b3Photos[k] != null)
                            const Icon(Icons.check_circle,
                              color: Colors.green),
                                                            
                                                  ]),
                                            ),
                                        ]),
                                  ),

                                const SizedBox(height: 8),
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        'If AC system is Hi-wall / Cassette / Floor split (check below)',
                                        style: theme.bodySmall)),
                                const SizedBox(height: 6),
                                for (final k in b3AcChecks.keys)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 6.0),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Text(b3AcLabels[k] ?? k),
                                          RadioListTile<String>(
                                              title: const Text('Yes'),
                                              value: 'Yes',
                                              groupValue: b3AcChecks[k],
                                              onChanged: (v) => setState(
                                                  () => b3AcChecks[k] = v)),
                                          RadioListTile<String>(
                                              title: const Text('No'),
                                              value: 'No',
                                              groupValue: b3AcChecks[k],
                                              onChanged: (v) => setState(
                                                  () => b3AcChecks[k] = v)),
                                          if (b3AcChecks[k] == 'No')
                                            Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 6.0),
                                                child: Column(children: [
                                                  TextFormField(
                                                      controller:
                                                          b3AcReasonControllers[
                                                              k],
                                                      decoration:
                                                          const InputDecoration(
                                                              labelText:
                                                                  'If No - Enter the reason',
                                                              isDense: true)),
                                                  const SizedBox(height: 6),
                                                  ElevatedButton(
                                                      onPressed: () async {
                                                        final urls =
                                                            await _uploadMedia(
                                                                'b3_ac_${k.toLowerCase()}',
                                                                multiImage:
                                                                    true);
                                                        if (urls != null &&
                                                            urls.isNotEmpty)
                                                          setState(() {
                                                            b3Photos[k] =
                                                                urls.first;
                                                            b3PhotosMulti[k] =
                                                                urls;
                                                          });
                                                      },
                                                      child: const Text(
                                                          'Attach Photo / Video')),
                                              const SizedBox(width: 8),
                                              if (b3Photos[k] != null)
                                                const Icon(Icons.check_circle,
                                                    color: Colors.green),
                                                ])),
                                        ]),
                                  ),

                                const SizedBox(height: 12),
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text('B4. PLUMBING & SANITARY WORKS',
                                        style: theme.bodyMedium)),
                                const SizedBox(height: 6),
                                for (final rt in b4RoutingTypes)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 6.0),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Text(
                                              'Is the pipeline routing & proper slope done as per drawing? ($rt)'),
                                          RadioListTile<String>(
                                              title: const Text('Yes'),
                                              value: 'Yes',
                                              groupValue: b4RoutingStatus[rt],
                                              onChanged: (v) => setState(() =>
                                                  b4RoutingStatus[rt] = v)),
                                          RadioListTile<String>(
                                              title: const Text('No'),
                                              value: 'No',
                                              groupValue: b4RoutingStatus[rt],
                                              onChanged: (v) => setState(() =>
                                                  b4RoutingStatus[rt] = v)),
                                          if (b4RoutingStatus[rt] == 'No')
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 6.0),
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .stretch,
                                                  children: [
                                                    TextFormField(
                                                        controller:
                                                            b4ReasonControllers[
                                                                rt],
                                                        decoration:
                                                            const InputDecoration(
                                                                labelText:
                                                                    'If No - Enter the reason',
                                                                isDense: true)),
                                                    const SizedBox(height: 6),
                                                    ElevatedButton(
                                                        onPressed: () async {
                                                          final urls =
                                                              await _uploadMedia(
                                                                  'b4_${rt.toLowerCase()}',
                                                                  multiImage:
                                                                      true);
                                                          if (urls != null &&
                                                              urls.isNotEmpty)
                                                            setState(() {
                                                              b4Photos[rt] =
                                                                  urls.first;
                                                              b4PhotosMulti[
                                                                  rt] = urls;
                                                            });
                                                        },
                                                        child: const Text(
                                                            'Attach Photo / Video')),
                                                    const SizedBox(width: 8),
                                                    if (b4Photos[rt] != null)
                                                      const Icon(Icons.check_circle,
                                                          color: Colors.green),
                                                  ]),
                                            ),
                                        ]),
                                  ),

                                const SizedBox(height: 8),
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text('Other Plumbing Checks',
                                        style: theme.bodySmall)),
                                const SizedBox(height: 6),
                                Row(children: [
                                  ElevatedButton(
                                      onPressed: () async {
                                        final urls = await _uploadMedia(
                                            'plumbing_unnecessary_bends',
                                            multiImage: true);
                                        if (urls != null && urls.isNotEmpty)
                                          setState(() {});
                                      },
                                      child: const Text(
                                          'Attach Photo - Unnecessary bends / joints')),
                                ]),
                                const SizedBox(height: 6),
                                // Quick boolean checks for plumbing
                                Column(children: [
                                  Row(children: [
                                    Expanded(
                                        child: Text(
                                            'Verify correct pipe materials & sizes are used as per drawings')),
                                    const SizedBox(width: 8),
                                  ]),
                                  Row(children: [
                                    Expanded(
                                        child: RadioListTile<String>(
                                            title: const Text('Yes'),
                                            value: 'Yes',
                                            groupValue:
                                                b4RoutingStatus['MaterialOK'],
                                            onChanged: (v) => setState(() =>
                                                b4RoutingStatus['MaterialOK'] =
                                                    v))),
                                    Expanded(
                                        child: RadioListTile<String>(
                                            title: const Text('No'),
                                            value: 'No',
                                            groupValue:
                                                b4RoutingStatus['MaterialOK'],
                                            onChanged: (v) => setState(() =>
                                                b4RoutingStatus['MaterialOK'] =
                                                    v))),
                                  ]),
                                  if (b4RoutingStatus['MaterialOK'] == 'No')
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 6.0),
                                      child: TextFormField(
                                        controller:
                                            b4ReasonControllers['MaterialOK'],
                                        decoration: const InputDecoration(
                                          labelText: 'If No - Enter the reason',
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                    ),
                                  const SizedBox(height: 6),
                                  Row(children: [
                                    Expanded(
                                        child: Text(
                                            'Is there an access provided for Valve operations?')),
                                    const SizedBox(width: 8),
                                  ]),
                                  Row(children: [
                                    Expanded(
                                        child: RadioListTile<String>(
                                            title: const Text('Yes'),
                                            value: 'Yes',
                                            groupValue:
                                                b4RoutingStatus['ValveAccess'],
                                            onChanged: (v) => setState(() =>
                                                b4RoutingStatus['ValveAccess'] =
                                                    v))),
                                    Expanded(
                                        child: RadioListTile<String>(
                                            title: const Text('No'),
                                            value: 'No',
                                            groupValue:
                                                b4RoutingStatus['ValveAccess'],
                                            onChanged: (v) => setState(() =>
                                                b4RoutingStatus['ValveAccess'] =
                                                    v))),
                                  ]),
                                  const SizedBox(height: 8),
                                  // Additional requested plumbing checks
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text('Additional Plumbing Checks',
                                          style: theme.bodyMedium)),
                                  const SizedBox(height: 6),

                                  // Hot & Cold separation
                                  Text('Are Hot & Cold Water Lines separated?'),
                                  RadioListTile<String>(
                                      title: const Text('Yes'),
                                      value: 'Yes',
                                      groupValue: b4AdditionalChecks[
                                          'HotColdSeparated'],
                                      onChanged: (v) => setState(() =>
                                          b4AdditionalChecks[
                                              'HotColdSeparated'] = v)),
                                  RadioListTile<String>(
                                      title: const Text('No'),
                                      value: 'No',
                                      groupValue: b4AdditionalChecks[
                                          'HotColdSeparated'],
                                      onChanged: (v) => setState(() =>
                                          b4AdditionalChecks[
                                              'HotColdSeparated'] = v)),
                                  if (b4AdditionalChecks['HotColdSeparated'] ==
                                      'No')
                                    Padding(
                                        padding:
                                            const EdgeInsets.only(top: 6.0),
                                        child: Column(children: [
                                          TextFormField(
                                              controller:
                                                  b4AdditionalReasonControllers[
                                                      'HotColdSeparated'],
                                              decoration: const InputDecoration(
                                                  labelText:
                                                      'If No - Enter the reason',
                                                  isDense: true)),
                                          const SizedBox(height: 6),
                                          ElevatedButton(
                                              onPressed: () async {
                                                final urls = await _uploadMedia(
                                                    'b4_hotcold_separation',
                                                    multiImage: true);
                                                if (urls != null &&
                                                    urls.isNotEmpty)
                                                  setState(() {
                                                    b4AdditionalPhotos[
                                                            'HotColdSeparated'] =
                                                        urls.first;
                                                    b4AdditionalPhotosMulti[
                                                            'HotColdSeparated'] =
                                                        urls;
                                                  });
                                              },
                                              child: const Text(
                                                  'Attach Photo / Video'))
                                        ])),

                                  const SizedBox(height: 8),
                                  // Pressure testing
                                  Text(
                                      'Is pressure testing done & documented?'),
                                  RadioListTile<String>(
                                      title: const Text('Yes'),
                                      value: 'Yes',
                                      groupValue:
                                          b4AdditionalChecks['PressureTested'],
                                      onChanged: (v) => setState(() =>
                                          b4AdditionalChecks['PressureTested'] =
                                              v)),
                                  RadioListTile<String>(
                                      title: const Text('No'),
                                      value: 'No',
                                      groupValue:
                                          b4AdditionalChecks['PressureTested'],
                                      onChanged: (v) => setState(() =>
                                          b4AdditionalChecks['PressureTested'] =
                                              v)),
                                  if (b4AdditionalChecks['PressureTested'] ==
                                      'No')
                                    Padding(
                                        padding:
                                            const EdgeInsets.only(top: 6.0),
                                        child: Column(children: [
                                          TextFormField(
                                              controller:
                                                  b4AdditionalReasonControllers[
                                                      'PressureTested'],
                                              decoration: const InputDecoration(
                                                  labelText:
                                                      'If No - Enter the reason',
                                                  isDense: true)),
                                          const SizedBox(height: 6),
                                          ElevatedButton(
                                              onPressed: () async {
                                                final urls = await _uploadMedia(
                                                    'b4_pressure_testing',
                                                    multiImage: true);
                                                if (urls != null &&
                                                    urls.isNotEmpty)
                                                  setState(() {
                                                    b4AdditionalPhotos[
                                                            'PressureTested'] =
                                                        urls.first;
                                                    b4AdditionalPhotosMulti[
                                                            'PressureTested'] =
                                                        urls;
                                                  });
                                              },
                                              child: const Text(
                                                  'Attach Photo / Video'))
                                        ])),

                                  const SizedBox(height: 8),
                                  // Sanitary & Soil separation
                                  Text(
                                      'Are Sanitary & Soil Waste lines separated?'),
                                  RadioListTile<String>(
                                      title: const Text('Yes'),
                                      value: 'Yes',
                                      groupValue: b4AdditionalChecks[
                                          'SanitarySoilSeparated'],
                                      onChanged: (v) => setState(() =>
                                          b4AdditionalChecks[
                                              'SanitarySoilSeparated'] = v)),
                                  RadioListTile<String>(
                                      title: const Text('No'),
                                      value: 'No',
                                      groupValue: b4AdditionalChecks[
                                          'SanitarySoilSeparated'],
                                      onChanged: (v) => setState(() =>
                                          b4AdditionalChecks[
                                              'SanitarySoilSeparated'] = v)),
                                  if (b4AdditionalChecks[
                                          'SanitarySoilSeparated'] ==
                                      'No')
                                    Padding(
                                        padding:
                                            const EdgeInsets.only(top: 6.0),
                                        child: Column(children: [
                                          TextFormField(
                                              controller:
                                                  b4AdditionalReasonControllers[
                                                      'SanitarySoilSeparated'],
                                              decoration: const InputDecoration(
                                                  labelText:
                                                      'If No - Enter the reason',
                                                  isDense: true)),
                                          const SizedBox(height: 6),
                                          ElevatedButton(
                                              onPressed: () async {
                                                final urls = await _uploadMedia(
                                                    'b4_sanitary_soil_separation',
                                                    multiImage: true);
                                                if (urls != null &&
                                                    urls.isNotEmpty)
                                                  setState(() {
                                                    b4AdditionalPhotos[
                                                            'SanitarySoilSeparated'] =
                                                        urls.first;
                                                    b4AdditionalPhotosMulti[
                                                            'SanitarySoilSeparated'] =
                                                        urls;
                                                  });
                                              },
                                              child: const Text(
                                                  'Attach Photo / Video'))
                                        ])),

                                  const SizedBox(height: 8),
                                  // Inspection chambers
                                  Text(
                                      'Is the Inspection chambers made as per drawings?'),
                                  RadioListTile<String>(
                                      title: const Text('Yes'),
                                      value: 'Yes',
                                      groupValue: b4AdditionalChecks[
                                          'InspectionChambersOK'],
                                      onChanged: (v) => setState(() =>
                                          b4AdditionalChecks[
                                              'InspectionChambersOK'] = v)),
                                  RadioListTile<String>(
                                      title: const Text('No'),
                                      value: 'No',
                                      groupValue: b4AdditionalChecks[
                                          'InspectionChambersOK'],
                                      onChanged: (v) => setState(() =>
                                          b4AdditionalChecks[
                                              'InspectionChambersOK'] = v)),
                                  if (b4AdditionalChecks[
                                          'InspectionChambersOK'] ==
                                      'No')
                                    Padding(
                                        padding:
                                            const EdgeInsets.only(top: 6.0),
                                        child: Column(children: [
                                          TextFormField(
                                              controller:
                                                  b4AdditionalReasonControllers[
                                                      'InspectionChambersOK'],
                                              decoration: const InputDecoration(
                                                  labelText:
                                                      'If No - Enter the reason',
                                                  isDense: true)),
                                          const SizedBox(height: 6),
                                          ElevatedButton(
                                              onPressed: () async {
                                                final urls = await _uploadMedia(
                                                    'b4_inspection_chambers',
                                                    multiImage: true);
                                                if (urls != null &&
                                                    urls.isNotEmpty)
                                                  setState(() {
                                                    b4AdditionalPhotos[
                                                            'InspectionChambersOK'] =
                                                        urls.first;
                                                    b4AdditionalPhotosMulti[
                                                            'InspectionChambersOK'] =
                                                        urls;
                                                  });
                                              },
                                              child: const Text(
                                                  'Attach Photo / Video'))
                                        ])),
                                ]),
                              ],
                            ),
                          ]),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // SAVE button (existing behavior preserved, but includes visit/media fields in insertion)
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        10.0, 0.0, 10.0, 0.0),
                    child: FFButtonWidget(
                      onPressed: () async {
                        currentUserLocationValue = await getCurrentUserLocation(
                            defaultLocation: const LatLng(0.0, 0.0));
                        _model.qcroutput =
                            await actions.convertQcResponsesToJson(
                          FFAppState().qcr.map((e) => e.toMap()).toList(),
                        );

                        // Build the form JSON once and reuse for both tables
                        final formJson = <String, dynamic>{
                          'qcr': _model.qcroutput,
                          'visitDocumentation': {
                            'templateType': templateTypeValue,
                            'siteVisitNumber':
                                int.tryParse(siteVisitNumberController.text),
                            'siteVisitDate': siteVisitDate?.toIso8601String(),
                          },
                          'media': {
                            'siteSurroundingsVideoUrl':
                                siteSurroundingsVideoUrl,
                            'streetAisle': streetAisle,
                            'northFacingPhotoUrl': northFacingPhotoUrl,
                            'northFacingPhotoUrls': northFacingPhotoUrls,
                            'facadeType': facadeType,
                            'completeFacadePhotoUrl': completeFacadePhotoUrl,
                            'completeFacadePhotoUrls': completeFacadePhotoUrls,
                            'lhsPhotoUrl': lhsPhotoUrl,
                            'lhsPhotoUrls': lhsPhotoUrls,
                            'rhsPhotoUrl': rhsPhotoUrl,
                            'rhsPhotoUrls': rhsPhotoUrls,
                            'oppositePhotoUrl': oppositePhotoUrl,
                            'oppositePhotoUrls': oppositePhotoUrls,
                          },
                          'siteVisitChecklist': {
                            'A': {
                              'a1Drawings': a1Drawings,
                              'a2Is3DAvailable': a2Is3DAvailable,
                              'a3VendorDetails': a3VendorDetails,
                              'a4VendorReps': a4VendorReps,
                              'a5': {
                                'fourD': a5_4dController.text,
                                'mepConsultant': a5_mepController.text,
                              },
                              'a6': {
                                'markingDone': a6MarkingDone,
                                'reason': a6ReasonController.text,
                              },
                              'a7': {
                                'deviations': a7Deviations,
                                'markingPhotos': a7MarkingPhotos,
                                'pointsToResolve':
                                    a7PointsToResolveController.text,
                                'finalSolution': a7FinalSolutionController.text,
                                'finalSolutionAttachmentUrl':
                                    a7FinalSolutionAttachmentUrl,
                                'finalSolutionAttachmentUrls':
                                    a7FinalSolutionAttachmentUrls,
                                'finalSolutionDate':
                                    a7FinalSolutionDate?.toIso8601String(),
                              },
                            },
                            'B': {
                              'b1': {
                                'conduitStatus': b1ConduitStatus,
                                'reasons': b1ReasonControllers
                                    .map((k, v) => MapEntry(k, v.text)),
                                'photos': b1Photos,
                                'photosMulti': b1PhotosMulti,
                              },
                              'b2': {
                                'items': b2Items,
                                'reasons': b2Reasons,
                                'photos': b2Photos,
                                'photosMulti': b2PhotosMulti,
                                'certificates': b2Certificates,
                              },
                              'b3': {
                                'checks': b3Checks,
                                'reasons': b3ReasonControllers
                                    .map((k, v) => MapEntry(k, v.text)),
                                'photos': b3Photos,
                                'photosMulti': b3PhotosMulti,
                                'acChecks': b3AcChecks,
                                'acReasons': b3AcReasonControllers
                                    .map((k, v) => MapEntry(k, v.text)),
                              },
                              'b4': {
                                'routingStatus': b4RoutingStatus,
                                'routingReasons': b4ReasonControllers
                                    .map((k, v) => MapEntry(k, v.text)),
                                'photos': b4Photos,
                                'photosMulti': b4PhotosMulti,
                                'materialOK': b4RoutingStatus['MaterialOK'],
                                'valveAccess': b4RoutingStatus['ValveAccess'],
                                'additionalChecks': b4AdditionalChecks,
                                'additionalReasons':
                                    b4AdditionalReasonControllers
                                        .map((k, v) => MapEntry(k, v.text)),
                                'additionalPhotos': b4AdditionalPhotos,
                                'additionalPhotosMulti':
                                    b4AdditionalPhotosMulti,
                              },
                            }
                          }
                        };

                        // Insert into recceresponses table (existing behavior) and capture inserted id
                        RecceresponsesRow? insertedResponse;
                        try {
                          insertedResponse =
                              await RecceresponsesTable().insert({
                            'formjson': formJson,
                            'submittedby': currentUserUid,
                            'submittedat':
                                supaSerialize<DateTime>(getCurrentTimestamp),
                            'createdat':
                                supaSerialize<DateTime>(getCurrentTimestamp),
                            'reccestageid': widget!.recestageId,
                            'projectid': selectedProjectId ?? widget.projectId,
                            'location': currentUserLocationValue?.toString(),
                            'stageno': 3,
                          });
                        } catch (e) {
                          print('Error inserting recceresponse: $e');
                          //ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          // content: Text('Failed to save response: $e')));
                        }

                        // Also add an entry into History table with same formjson
                        try {
                          // Determine recceresponse id and stageNo defaults
                          final String? historyRecceresponseId =
                              insertedResponse?.recceresponseid;
                          final int historyStageNo =
                              insertedResponse?.getField<int>('stageno') ?? 3;

                          final historyData = <String, dynamic>{
                            'formjson': formJson,
                            'submittedat':
                                supaSerialize<DateTime>(getCurrentTimestamp),
                            'createdat':
                                supaSerialize<DateTime>(getCurrentTimestamp),
                            'projectid': selectedProjectId ?? widget.projectId,
                            'location': currentUserLocationValue?.toString(),
                            'stageno': historyStageNo,
                          };

                          // Attach recceresponseid if found, otherwise null
                          historyData['recceresponseid'] =
                              historyRecceresponseId;

                          // Attach submittedby only if available to avoid FK errors
                          if (currentUserUid != null) {
                            historyData['submittedby'] = currentUserUid;
                          }

                          final insertedHistory =
                              await HistoryTable().insert(historyData);
                          print(
                              'Inserted history id: ${insertedHistory.historyId}');
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  'Saved history: ${insertedHistory.historyId}')));
                        } catch (e) {
                          print('Error inserting history: $e');
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Failed to save history: $e')));
                        }

                        FFAppState().qcr = [];
                        safeSetState(() {});
                        context.safePop();

                        safeSetState(() {});
                      },
                      text: 'Save',
                      options: FFButtonOptions(
                        width: double.infinity,
                        height: 40.0,
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            16.0, 0.0, 16.0, 0.0),
                        color: theme.secondary,
                        textStyle:
                            theme.titleSmall.override(color: Colors.white),
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
