import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_timer.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'addproject_model.dart';
export 'addproject_model.dart';

class AddprojectWidget extends StatefulWidget {
  const AddprojectWidget({
    Key? key,
    required this.projectType,
  }) : super(key: key);

  final String? projectType;

  static String routeName = 'addproject';
  static String routePath = '/addprojectOflfine';

  @override
  State<AddprojectWidget> createState() => _AddprojectWidgetState();
}

class _AddprojectWidgetState extends State<AddprojectWidget> {
  late AddprojectModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  // SECTION 1 state (Project Type & Scope)
  Map<String, bool> projectTypeChecks = {
    'Regional': false,
    'Corporate': false,
    'Brands': false,
    'Sites': false,
    'F&B projects': false,
    'International': false,
  };
  Map<String, bool> projectCategoryChecks = {
    'Design Concept': false,
    'Design Development': false,
    'Design Adaptation/Rollout': false,
  };
  String projectSize = 'Small'; // Small, Medium, Large, Big Box
  Map<String, bool> specificProjectTypes = {
    'F & B project': false,
    'Office Interiors': false,
    'Others': false,
  };

  // SECTION 2 controllers (Location & Address)
  final TextEditingController parentCompanyController = TextEditingController();
  final TextEditingController brandNameController = TextEditingController();
  final TextEditingController projectStateController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController addressAreaController = TextEditingController();
  final TextEditingController googlePinController = TextEditingController();
  String? propertyTypeValue;
  final TextEditingController breadthController = TextEditingController();
  final TextEditingController carpetAreaController = TextEditingController();
  String? locationTypeValue;

  // SECTION 3 controllers (Client & Team)
  final TextEditingController client1NameController = TextEditingController();
  final TextEditingController client1EmailController = TextEditingController();
  final TextEditingController client1PhoneController = TextEditingController();
  final TextEditingController clientProjectInchargeController = TextEditingController();
  final TextEditingController teamHeadController = TextEditingController();
  final TextEditingController teamHandlingNameController = TextEditingController();
  final TextEditingController teamHandlingEmailController = TextEditingController();
  final TextEditingController teamHandlingPhoneController = TextEditingController();

  // SECTION 4 (Template & Date) -- kept variables but UI is commented out
  String? templateTypeValue;
  final TextEditingController siteVisitNumberController = TextEditingController();
  DateTime? siteVisitDate;
  final TextEditingController siteVisitDateController = TextEditingController();

  // SECTION 5 (Media & Surroundings) -- kept variables but UI is commented out
  String streetAisle = 'Street on both sides';
  String facadeType = 'Single facade';
  String? siteSurroundingsVideoUrl;
  String? northFacingPhotoUrl;
  String? completeFacadePhotoUrl;
  String? lhsPhotoUrl;
  String? rhsPhotoUrl;
  String? oppositePhotoUrl;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AddprojectModel());

    // ensure model controllers exist as before
    _model.projectnameTextFieldTextController ??= TextEditingController();
    _model.projectnameTextFieldFocusNode ??= FocusNode();
    _model.clientNameTextFieldTextController ??= TextEditingController();
    _model.clientPhoneTextFieldTextController ??= TextEditingController();
    _model.contactdetailsTextFieldTextController ??= TextEditingController();
    _model.partnerNameTextFieldTextController ??= TextEditingController();
    _model.partnerPhoneTextFieldTextController ??= TextEditingController();
    _model.partnerDetailsTextFieldTextController ??= TextEditingController();
    _model.addressOfSiteTextFieldTextController ??= TextEditingController();
    _model.addressOfSiteTextFieldFocusNode ??= FocusNode();

    // On page load actions
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      try {
        await actions.initHive();
        _model.openHiveBxOnLoad = await actions.openHiveBoxes();
      } catch (e, st) {
        // non-fatal; show debug message
        print('initHive error: $e\n$st');
      }
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _model.dispose();

    parentCompanyController.dispose();
    brandNameController.dispose();
    projectStateController.dispose();
    cityController.dispose();
    addressAreaController.dispose();
    googlePinController.dispose();
    breadthController.dispose();
    carpetAreaController.dispose();

    client1NameController.dispose();
    client1EmailController.dispose();
    client1PhoneController.dispose();
    clientProjectInchargeController.dispose();
    teamHeadController.dispose();
    teamHandlingNameController.dispose();
    teamHandlingEmailController.dispose();
    teamHandlingPhoneController.dispose();

    siteVisitNumberController.dispose();
    siteVisitDateController.dispose();

    super.dispose();
  }

  // safe upload media helper
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
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Unsupported file format selected')));
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

  // wrapper to safely build expansion children; catches build exceptions so UI doesn't fully crash
  Widget _safeChildren(Widget Function() builder) {
    try {
      return builder();
    } catch (e, st) {
      print('build child error: $e\n$st');
      return Container(
        height: 220,
        color: Colors.red.shade800,
        child: Center(
          child: Text(
            'An error occurred building this section',
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
  }

  // VALIDATION: returns list of missing field labels
  List<String> _validateRequiredFields() {
    final missing = <String>[];

    // Project name
    final projectName = _model.projectnameTextFieldTextController?.text.trim() ?? '';
    if (projectName.isEmpty) missing.add('Project name');

    // Section 1: at least one selection in checkbox groups
    if (!projectTypeChecks.values.any((v) => v)) missing.add('Project Type (select at least one)');
    if (!projectCategoryChecks.values.any((v) => v)) missing.add('Project Category (select at least one)');
    if (projectSize.trim().isEmpty) missing.add('Project Size');
    if (!specificProjectTypes.values.any((v) => v)) missing.add('Specific Project Types (select at least one)');

    // Section 2
    if (locationTypeValue == null || locationTypeValue!.trim().isEmpty) missing.add('Location Type');
    if (parentCompanyController.text.trim().isEmpty) missing.add('Parent Company');
    if (brandNameController.text.trim().isEmpty) missing.add('Brand Name');
    if (projectStateController.text.trim().isEmpty) missing.add('Project Location State');
    if (cityController.text.trim().isEmpty) missing.add('City');
    if (addressAreaController.text.trim().isEmpty) missing.add('Address / Area');
    if (googlePinController.text.trim().isEmpty) missing.add('Google pin');
    if (propertyTypeValue == null || propertyTypeValue!.trim().isEmpty) missing.add('Property Type');
    if (breadthController.text.trim().isEmpty) missing.add('Exact Breadth of the site');
    if (carpetAreaController.text.trim().isEmpty) missing.add('Exact Carpet area of the site');

    // Section 3
    if (client1NameController.text.trim().isEmpty) missing.add('Client Contact 1: Name');
    final email1 = client1EmailController.text.trim();
    if (email1.isEmpty) {
      missing.add('Client Contact 1: Email Id');
    } else {
      final emailReg = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
      if (!emailReg.hasMatch(email1)) missing.add('Client Contact 1: Email Id (invalid)');
    }
    if (client1PhoneController.text.trim().isEmpty) missing.add('Client Contact 1: Phone');
    if (clientProjectInchargeController.text.trim().isEmpty) missing.add('Name of client - project Incharge');
    if (teamHeadController.text.trim().isEmpty) missing.add('4D Team head details (Name & Contact)');
    if (teamHandlingNameController.text.trim().isEmpty) missing.add('Team handling: Name');
    final teamEmail = teamHandlingEmailController.text.trim();
    if (teamEmail.isEmpty) {
      missing.add('Team handling: Email');
    } else {
      final emailReg = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
      if (!emailReg.hasMatch(teamEmail)) missing.add('Team handling: Email (invalid)');
    }
    if (teamHandlingPhoneController.text.trim().isEmpty) missing.add('Team handling: Phone');

    // NOTE: Section 4 (Template & Date) and Section 5 (Media uploads) are intentionally
    // not validated here because these fields are not required for this flow.

    return missing;
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: theme.primaryBackground,
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
                'Add project',
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
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      if (_model.isDeviceOnlineTImer == true)
                        FlutterFlowIconButton(
                          borderRadius: 8.0,
                          buttonSize: 40.0,
                          icon: const Icon(
                            Icons.online_prediction,
                            color: Color(0xFF00FF00),
                            size: 24.0,
                          ),
                          onPressed: () {
                            // no-op for now
                          },
                        ),
                      if (_model.isDeviceOnlineTImer == false)
                        FlutterFlowIconButton(
                          borderRadius: 8.0,
                          buttonSize: 40.0,
                          icon: const Icon(
                            Icons.cloud_off,
                            color: Color(0xFFFF0000),
                            size: 24.0,
                          ),
                          onPressed: () {
                            // no-op for now
                          },
                        ),
                      Align(
                        alignment: const AlignmentDirectional(0.0, 0.0),
                        child: FlutterFlowTimer(
                          key: const ValueKey('homeTimer'),
                          initialTime: _model.timerInitialTimeMs,
                          getDisplayTime: (value) => StopWatchTimer.getDisplayTime(
                            value,
                            hours: false,
                            milliSecond: false,
                          ),
                          controller: _model.timerController,
                          updateStateInterval: const Duration(milliseconds: 1000),
                          onChanged: (value, displayTime, shouldUpdate) {
                            _model.timerMilliseconds = value;
                            _model.timerValue = displayTime;
                            if (shouldUpdate) safeSetState(() {});
                          },
                          onEnded: () async {
                            _model.timerController.onStartTimer();
                            _model.isDeviceOnlineTImer = await actions.isDeviceOnline();
                            _model.timerController.timer.setPresetTime(mSec: 30000, add: false);
                            _model.timerController.onResetTimer();
                            _model.timerController.onStartTimer();
                            safeSetState(() {});
                          },
                          textAlign: TextAlign.start,
                          style: theme.headlineSmall!.override(
                            font: GoogleFonts.interTight(
                              fontWeight: theme.headlineSmall!.fontWeight,
                              fontStyle: theme.headlineSmall!.fontStyle,
                            ),
                            fontSize: 0.0,
                            letterSpacing: 0.0,
                            fontWeight: theme.headlineSmall!.fontWeight,
                            fontStyle: theme.headlineSmall!.fontStyle,
                          ),
                        ),
                      ),
                      if (responsiveVisibility(
                        context: context,
                        phone: false,
                        tablet: false,
                        tabletLandscape: false,
                        desktop: false,
                      ))
                        FlutterFlowIconButton(
                          borderRadius: 8.0,
                          buttonSize: 40.0,
                          icon: Icon(
                            Icons.receipt_long,
                            color: theme.secondary,
                            size: 24.0,
                          ),
                          onPressed: () async {
                            context.goNamed(ReceTemplateWidget.routeName);
                          },
                        ),
                    ],
                  ),
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
                ].divide(const SizedBox(width: 8.0)),
              ),
            ),
          ],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
            child: Column(
              children: [
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(color: theme.primary.withOpacity(0.08), borderRadius: BorderRadius.circular(10)),
                          child: Icon(Icons.add_business_outlined, color: theme.primary),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text('Create new project', style: theme.titleSmall),
                            const SizedBox(height: 6),
                            Text('Fill the form below. Submission respects online/offline state.', style: theme.bodySmall),
                          ]),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // Core project card
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: theme.secondaryBackground,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: const Color(0xFFECECEC)),
                          ),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                            TextFormField(
                              controller: _model.projectnameTextFieldTextController,
                              focusNode: _model.projectnameTextFieldFocusNode,
                              decoration: InputDecoration(labelText: 'Project name', hintText: 'Enter project name', prefixIcon: Icon(Icons.drive_file_rename_outline)),
                              maxLines: 3,
                              validator: (v) => null,
                            ),
                            const SizedBox(height: 12),

                            // SECTION 1: Project Type & Scope Selection
                            ExpansionTile(
                              title: Text('Project Type & Scope Selection', style: theme.titleSmall),
                              children: [
                                _safeChildren(() => Column(children: [
                                      // Project Type checkboxes
                                      Align(alignment: Alignment.centerLeft, child: Text('Project Type', style: theme.bodyMedium)),
                                      ...projectTypeChecks.keys.map((k) {
                                        return CheckboxListTile(
                                          title: Text(k),
                                          value: projectTypeChecks[k],
                                          controlAffinity: ListTileControlAffinity.leading,
                                          onChanged: (v) => setState(() => projectTypeChecks[k] = v ?? false),
                                        );
                                      }).toList(),
                                      const SizedBox(height: 6),
                                      Align(alignment: Alignment.centerLeft, child: Text('Project Category', style: theme.bodyMedium)),
                                      ...projectCategoryChecks.keys.map((k) {
                                        return CheckboxListTile(
                                          title: Text(k),
                                          value: projectCategoryChecks[k],
                                          controlAffinity: ListTileControlAffinity.leading,
                                          onChanged: (v) => setState(() => projectCategoryChecks[k] = v ?? false),
                                        );
                                      }).toList(),
                                      const SizedBox(height: 6),
                                      Align(alignment: Alignment.centerLeft, child: Text('Project Size (Carpet Area)', style: theme.bodyMedium)),
                                      RadioListTile<String>(title: const Text('Small (up to 3000 sq ft)'), value: 'Small', groupValue: projectSize, onChanged: (v) => setState(() => projectSize = v!)),
                                      RadioListTile<String>(title: const Text('Medium (3000-10,000 sq ft)'), value: 'Medium', groupValue: projectSize, onChanged: (v) => setState(() => projectSize = v!)),
                                      RadioListTile<String>(title: const Text('Large (10,001-50,000 sq ft)'), value: 'Large', groupValue: projectSize, onChanged: (v) => setState(() => projectSize = v!)),
                                      RadioListTile<String>(title: const Text('Big Box (50,001 and above)'), value: 'Big Box', groupValue: projectSize, onChanged: (v) => setState(() => projectSize = v!)),
                                      const SizedBox(height: 6),
                                      Align(alignment: Alignment.centerLeft, child: Text('Specific Project Types', style: theme.bodyMedium)),
                                      ...specificProjectTypes.keys.map((k) {
                                        return CheckboxListTile(title: Text(k), value: specificProjectTypes[k], controlAffinity: ListTileControlAffinity.leading, onChanged: (v) => setState(() => specificProjectTypes[k] = v ?? false));
                                      }).toList(),
                                    ])),
                              ],
                            ),

                            const SizedBox(height: 12),

                            // SECTION 2: Location & Address Details
                            ExpansionTile(
                              title: Text('Location & Address Details', style: theme.titleSmall),
                              children: [
                                _safeChildren(() => Column(children: [
                                      DropdownButtonFormField<String>(
                                        value: locationTypeValue,
                                        decoration: const InputDecoration(labelText: 'Location Type'),
                                        items: [
                                          'Part of a Mall',
                                          'Commercial complex (hybrid)',
                                          'High street',
                                          'Airport or Travel hubs',
                                          'Others',
                                        ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                                        onChanged: (v) => setState(() => locationTypeValue = v),
                                      ),
                                      const SizedBox(height: 8),
                                      TextFormField(controller: parentCompanyController, decoration: const InputDecoration(labelText: 'Parent Company', hintText: 'e.g. ABFRL')),
                                      const SizedBox(height: 8),
                                      TextFormField(controller: brandNameController, decoration: const InputDecoration(labelText: 'Brand Name', hintText: 'e.g. Allen Folly')),
                                      const SizedBox(height: 8),
                                      Row(children: [
                                        Expanded(child: TextFormField(controller: projectStateController, decoration: const InputDecoration(labelText: 'Project Location State'))),
                                        const SizedBox(width: 8),
                                        Expanded(child: TextFormField(controller: cityController, decoration: const InputDecoration(labelText: 'City'))),
                                      ]),
                                      const SizedBox(height: 8),
                                      TextFormField(controller: addressAreaController, decoration: const InputDecoration(labelText: 'Address / Area')),
                                      const SizedBox(height: 8),
                                      TextFormField(controller: googlePinController, decoration: const InputDecoration(labelText: 'Google pin (URL)')),
                                      const SizedBox(height: 8),
                                      DropdownButtonFormField<String>(
                                        value: propertyTypeValue,
                                        decoration: const InputDecoration(labelText: 'Property Type'),
                                        items: ['Retail', 'Office', 'F&B', 'Warehouse'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                                        onChanged: (v) => setState(() => propertyTypeValue = v),
                                      ),
                                      const SizedBox(height: 8),
                                      Row(children: [
                                        Expanded(child: TextFormField(controller: breadthController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Exact Breadth of the site (ft)'))),
                                        const SizedBox(width: 8),
                                        Expanded(child: TextFormField(controller: carpetAreaController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Exact Carpet area of the site (sq ft)'))),
                                      ]),
                                    ])),
                              ],
                            ),

                            const SizedBox(height: 12),

                            // SECTION 3: Client and Team Contact Details
                            ExpansionTile(
                              title: Text('Client & Team Contact Details', style: theme.titleSmall),
                              children: [
                                _safeChildren(() => Column(children: [
                                      TextFormField(controller: client1NameController, decoration: const InputDecoration(labelText: 'Client Contact 1: Name')),
                                      const SizedBox(height: 8),
                                      TextFormField(controller: client1EmailController, keyboardType: TextInputType.emailAddress, decoration: const InputDecoration(labelText: 'Client Contact 1: Email Id')),
                                      const SizedBox(height: 8),
                                      TextFormField(controller: client1PhoneController, keyboardType: TextInputType.phone, decoration: const InputDecoration(labelText: 'Client Contact 1: Phone')),
                                      const SizedBox(height: 8),
                                      TextFormField(controller: clientProjectInchargeController, decoration: const InputDecoration(labelText: 'Name of client - project Incharge')),
                                      const SizedBox(height: 8),
                                      TextFormField(controller: teamHeadController, decoration: const InputDecoration(labelText: '4D Team head details (Name & Contact)')),
                                      const SizedBox(height: 8),
                                      Align(alignment: Alignment.centerLeft, child: Text('Team handling the project', style: theme.bodyMedium)),
                                      TextFormField(controller: teamHandlingNameController, decoration: const InputDecoration(labelText: 'Name')),
                                      const SizedBox(height: 8),
                                      TextFormField(controller: teamHandlingEmailController, keyboardType: TextInputType.emailAddress, decoration: const InputDecoration(labelText: 'Email')),
                                      const SizedBox(height: 8),
                                      TextFormField(controller: teamHandlingPhoneController, keyboardType: TextInputType.phone, decoration: const InputDecoration(labelText: 'Phone')),
                                    ])),
                              ],
                            ),

                            const SizedBox(height: 12),

                            /*
                            // SECTION 4: Site Visit Template & Date
                            // Commented out per request (hidden)
                            ExpansionTile(
                              title: Text('Site Visit Template & Date', style: theme.titleSmall),
                              children: [
                                _safeChildren(() => Column(children: [
                                      DropdownButtonFormField<String>(
                                        value: templateTypeValue,
                                        decoration: const InputDecoration(labelText: 'Template Type'),
                                        items: [
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
                                        Expanded(child: TextFormField(controller: siteVisitNumberController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Site Visit Number'))),
                                        const SizedBox(width: 8),
                                        Expanded(child: TextFormField(controller: siteVisitDateController, readOnly: true, decoration: const InputDecoration(labelText: 'Site Visit Date', suffixIcon: Icon(Icons.calendar_today)), onTap: () async {
                                          final picked = await showDatePicker(context: context, initialDate: siteVisitDate ?? DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(2100));
                                          if (picked != null) {
                                            setState(() {
                                              siteVisitDate = picked;
                                              siteVisitDateController.text = picked.toIso8601String().split('T').first;
                                            });
                                          }
                                        })),
                                      ]),
                                    ])),
                              ],
                            ),
                            */

                            const SizedBox(height: 12),

                            /*
                            // SECTION 5: Site Location & Surroundings (Media Uploads)
                            // Commented out per request (hidden)
                            ExpansionTile(
                              title: Text('Site Location & Surroundings (Media Uploads)', style: theme.titleSmall),
                              children: [
                                _safeChildren(() => Column(children: [
                                      Row(children: [
                                        Expanded(child: ElevatedButton(onPressed: () async {
                                          final url = await _uploadMedia('site_surroundings_videos', allowVideo: true);
                                          if (url != null) setState(() => siteSurroundingsVideoUrl = url);
                                        }, child: const Text('Upload Site Surroundings Video'))),
                                        const SizedBox(width: 8),
                                        if (siteSurroundingsVideoUrl != null) const Icon(Icons.check_circle, color: Colors.green),
                                      ]),
                                      const SizedBox(height: 8),
                                      Align(alignment: Alignment.centerLeft, child: Text('Street / Aisle Description', style: theme.bodyMedium)),
                                      RadioListTile<String>(title: const Text('Street on both sides'), value: 'Street on both sides', groupValue: streetAisle, onChanged: (v) => setState(() => streetAisle = v!)),
                                      RadioListTile<String>(title: const Text('Aisle'), value: 'Aisle', groupValue: streetAisle, onChanged: (v) => setState(() => streetAisle = v!)),
                                      const SizedBox(height: 8),
                                      Row(children: [
                                        Expanded(child: ElevatedButton(onPressed: () async {
                                          final url = await _uploadMedia('north_facing_photo');
                                          if (url != null) setState(() => northFacingPhotoUrl = url);
                                        }, child: const Text('North Direction & Facing Photo'))),
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
                                        Expanded(child: ElevatedButton(onPressed: () async {
                                          final url = await _uploadMedia('complete_facade_photo');
                                          if (url != null) setState(() => completeFacadePhotoUrl = url);
                                        }, child: const Text('Complete Site Facade Photo'))),
                                        const SizedBox(width: 8),
                                        if (completeFacadePhotoUrl != null) const Icon(Icons.check_circle, color: Colors.green),
                                      ]),
                                      const SizedBox(height: 8),
                                      Row(children: [
                                        Expanded(child: ElevatedButton(onPressed: () async {
                                          final url = await _uploadMedia('lhs_site_photo');
                                          if (url != null) setState(() => lhsPhotoUrl = url);
                                        }, child: const Text('LHS of site Photo'))),
                                        const SizedBox(width: 8),
                                        if (lhsPhotoUrl != null) const Icon(Icons.check_circle, color: Colors.green),
                                      ]),
                                      const SizedBox(height: 8),
                                      Row(children: [
                                        Expanded(child: ElevatedButton(onPressed: () async {
                                          final url = await _uploadMedia('rhs_site_photo');
                                          if (url != null) setState(() => rhsPhotoUrl = url);
                                        }, child: const Text('RHS of site Photo'))),
                                        const SizedBox(width: 8),
                                        if (rhsPhotoUrl != null) const Icon(Icons.check_circle, color: Colors.green),
                                      ]),
                                      const SizedBox(height: 8),
                                      Row(children: [
                                        Expanded(child: ElevatedButton(onPressed: () async {
                                          final url = await _uploadMedia('opposite_side_site_photo');
                                          if (url != null) setState(() => oppositePhotoUrl = url);
                                        }, child: const Text('Opposite side of the site Photo'))),
                                        const SizedBox(width: 8),
                                        if (oppositePhotoUrl != null) const Icon(Icons.check_circle, color: Colors.green),
                                      ]),
                                    ])),
                              ],
                            ),
                            */

                          ]),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),

                // Bottom actions
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  child: Row(children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => context.safePop(),
                        style: OutlinedButton.styleFrom(side: BorderSide(color: theme.primaryText), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28))),
                        child: Text('Cancel', style: theme.titleSmall),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FFButtonWidget(
                        onPressed: () async {
                          try {
                            final missing = _validateRequiredFields();
                            if (missing.isNotEmpty) {
                              final msg = 'Please fill: ${missing.join(', ')}';
                              final snack = SnackBar(content: Text(msg), duration: const Duration(seconds: 4));
                              ScaffoldMessenger.of(context).showSnackBar(snack);
                              return;
                            }

                            final name = _model.projectnameTextFieldTextController?.text.trim() ?? '';
                            final uid = currentUserUid;
                            if (uid == null || uid.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('You must be logged in to add a project.')));
                              return;
                            }

                            final extraFields = <String, dynamic>{
                              // Section1
                              'projectType_checks': projectTypeChecks,
                              'projectCategory_checks': projectCategoryChecks,
                              'projectSize': projectSize,
                              'specificProjectTypes': specificProjectTypes,
                              // Section2
                              'locationType': locationTypeValue,
                              'parentCompany': parentCompanyController.text.trim(),
                              'brandName': brandNameController.text.trim(),
                              'projectState': projectStateController.text.trim(),
                              'city': cityController.text.trim(),
                              'addressArea': addressAreaController.text.trim(),
                              'googlePin': googlePinController.text.trim(),
                              'propertyType': propertyTypeValue,
                              'exactBreadth': breadthController.text.trim(),
                              'exactCarpetArea': carpetAreaController.text.trim(),
                              // Section3
                              'clientContact1': {
                                'name': client1NameController.text.trim(),
                                'email': client1EmailController.text.trim(),
                                'phone': client1PhoneController.text.trim(),
                              },
                              'clientProjectIncharge': clientProjectInchargeController.text.trim(),
                              'teamHead': teamHeadController.text.trim(),
                              'teamHandling': {
                                'name': teamHandlingNameController.text.trim(),
                                'email': teamHandlingEmailController.text.trim(),
                                'phone': teamHandlingPhoneController.text.trim(),
                              },
                              // Section4 (hidden) - still included if values present
                              'templateType': templateTypeValue,
                              'siteVisitNumber': siteVisitNumberController.text.trim(),
                              'siteVisitDate': siteVisitDate?.toIso8601String(),
                              // Section5 (hidden) - still included if values present
                              'siteSurroundingsVideoUrl': siteSurroundingsVideoUrl,
                              'streetAisle': streetAisle,
                              'northFacingPhotoUrl': northFacingPhotoUrl,
                              'facadeType': facadeType,
                              'completeFacadePhotoUrl': completeFacadePhotoUrl,
                              'lhsPhotoUrl': lhsPhotoUrl,
                              'rhsPhotoUrl': rhsPhotoUrl,
                              'oppositePhotoUrl': oppositePhotoUrl,
                            };

                            _model.projectsData = {
                              'pronjectName': name,
                              'clientName': _model.clientNameTextFieldTextController?.text.trim(),
                              'extraFields': extraFields,
                            };

                            try {
                              _model.addRecordToHive = await actions.addRecordToHive('projects', _model.projectsData.toString());
                              _model.projectsDataFromHive = await actions.getRecordsFromHive('projects');
                            } catch (h) {
                              print('Hive save error: $h');
                            }

                            try {
                              // Insert into Projects table:
                              // - name -> name
                              // - project_type -> project_type
                              // - all other form values -> project_details (JSONB)
                              _model.projectInfoVar = await ProjectsTable().insert({
                                'name': name,
                                'clientname': _model.clientNameTextFieldTextController?.text.trim(),
                                'status': 'new',
                                'managerid': uid,
                                'createdat': supaSerialize<DateTime>(getCurrentTimestamp),
                                'addressofsite': _model.addressOfSiteTextFieldTextController?.text.trim(),
                                'clientlogo': _model.uploadedFileUrl_uploadData74b,
                                'clientphone': _model.clientPhoneTextFieldTextController?.text.trim(),
                                'clientcontactdetails': _model.contactdetailsTextFieldTextController?.text.trim(),
                                'partnername': _model.partnerNameTextFieldTextController?.text.trim(),
                                'partnerphone': _model.partnerPhoneTextFieldTextController?.text.trim(),
                                'partnercontactdetails': _model.partnerDetailsTextFieldTextController?.text.trim(),
                                'projectcode': functions.getProjectCode(),
                                'project_type': widget.projectType ?? 'unknown',
                                // store the rest of fields as JSONB
                                'project_details': extraFields,
                              });

                              await ReccestagesTable().insert({
                                'projectid': _model.projectInfoVar?.projectid,
                                'stageno': 0,
                                'title': _model.projectInfoVar?.name,
                                'planneddate': supaSerialize<DateTime>(getCurrentTimestamp),
                                'createdat': supaSerialize<DateTime>(getCurrentTimestamp),
                              });

                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Project added successfully')));
                              FFAppState().clearProjectListCacheKey('projectList${uid}');
                              context.safePop();
                            } catch (e, st) {
                              print('Project insert failed: $e\n$st');
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to add project: ${e.toString()}')));
                            }
                          } catch (err, st) {
                            print('[Save] unexpected: $err\n$st');
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Unexpected error: ${err.toString()}')));
                          }
                        },
                        text: 'Save',
                        options: FFButtonOptions(height: 44.0, color: theme.secondary, textStyle: theme.titleSmall.override(color: Colors.white)),
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}