import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'add_project_offline_model.dart';
export 'add_project_offline_model.dart';

class AddProjectOfflineWidget extends StatefulWidget {
  const AddProjectOfflineWidget({super.key});

  static String routeName = 'addProjectOffline';
  static String routePath = '/addproject';

  @override
  State<AddProjectOfflineWidget> createState() =>
      _AddProjectOfflineWidgetState();
}

class _AddProjectOfflineWidgetState extends State<AddProjectOfflineWidget> {
  late AddProjectOfflineModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AddProjectOfflineModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.onPageLoadisDeviceOnline = await actions.isDeviceOnline();
      await showDialog(
        context: context,
        builder: (alertDialogContext) {
          return AlertDialog(
            title: Text('The device is active'),
            content: Text(_model.onPageLoadisDeviceOnline!.toString()),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(alertDialogContext),
                child: Text('Ok'),
              ),
            ],
          );
        },
      );
      if (_model.onPageLoadisDeviceOnline == true) {
        _model.onPageLoadOfflieData = await actions.getOfflineForm(
          'offlineForms',
        );
        _model.onPageLoadStoreToBackend = await RecceresponsesTable().insert({
          'reccestageid': '0bee28f5-b3cd-4d34-aea9-c64a1dfc291d',
          'formjson': _model.onPageLoadOfflieData,
          'submittedby': '4c315b52-a0cb-4446-802b-1e98e6b00bf5',
          'submittedat': supaSerialize<DateTime>(getCurrentTimestamp),
          'createdat': supaSerialize<DateTime>(getCurrentTimestamp),
          'location': 'Bengaluru',
          'stageNo': 1,
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Data saved!',
              style: TextStyle(
                color: FlutterFlowTheme.of(context).primaryText,
              ),
            ),
            duration: Duration(milliseconds: 4000),
            backgroundColor: FlutterFlowTheme.of(context).secondary,
          ),
        );
      } else {
        await actions.saveOfflineForm(
          'offlineForms',
          getCurrentTimestamp.toString(),
          _model.jsonFormData!,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Save to Hive',
              style: TextStyle(
                color: FlutterFlowTheme.of(context).primaryText,
              ),
            ),
            duration: Duration(milliseconds: 4000),
            backgroundColor: FlutterFlowTheme.of(context).secondary,
          ),
        );
        _model.onPageLoadgetOfflineData = await actions.getOfflineForm(
          'offlineForms',
        );
      }
    });

    _model.projectnameTextFieldTextController ??= TextEditingController();
    _model.projectnameTextFieldFocusNode ??= FocusNode();

    _model.clientNameTextFieldTextController ??= TextEditingController();
    _model.clientNameTextFieldFocusNode ??= FocusNode();

    _model.clientPhoneTextFieldTextController ??= TextEditingController();
    _model.clientPhoneTextFieldFocusNode ??= FocusNode();

    _model.contactdetailsTextFieldTextController ??= TextEditingController();
    _model.contactdetailsTextFieldFocusNode ??= FocusNode();

    _model.partnerNameTextFieldTextController ??= TextEditingController();
    _model.partnerNameTextFieldFocusNode ??= FocusNode();

    _model.partnerPhoneTextFieldTextController ??= TextEditingController();
    _model.partnerPhoneTextFieldFocusNode ??= FocusNode();

    _model.partnerDetailsTextFieldTextController ??= TextEditingController();
    _model.partnerDetailsTextFieldFocusNode ??= FocusNode();

    _model.addressOfSiteTextFieldTextController ??= TextEditingController();
    _model.addressOfSiteTextFieldFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  // --- UI only changed below, logic and controllers preserved ---
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
          backgroundColor: theme.primaryBackground,
          elevation: 0,
          leading: FlutterFlowIconButton(
            borderColor: Color(0xFF9E9F9F),
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 40.0,
            icon: Icon(
              Icons.arrow_back,
              color: theme.primaryText,
              size: 22.0,
            ),
            onPressed: () async {
              context.safePop();
            },
          ),
          title: Text(
            'New Project',
            style: theme.titleMedium.override(
              font: GoogleFonts.inter(fontWeight: FontWeight.w700),
              fontSize: 18,
            ),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                // Summary card with image
                Card(
                  margin: const EdgeInsets.only(top: 12, bottom: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 2,
                  child: Container(
                    width: double.infinity,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    child: Row(
                      children: [
                        Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            color: theme.secondary.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(Icons.business_outlined,
                              color: theme.secondary, size: 28),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Create project',
                                  style: theme.titleSmall.override(
                                      font: GoogleFonts.inter(
                                          fontWeight: FontWeight.w700))),
                              const SizedBox(height: 6),
                              Text(
                                'Fill basic details. Data will be stored according to device connectivity.',
                                style: theme.bodySmall,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.info_outline, color: theme.primaryText),
                        )
                      ],
                    ),
                  ),
                ),

                // Form area
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // Light card with grouped inputs
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: theme.secondaryBackground,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 6,
                                  offset: Offset(0, 2))
                            ],
                            border: Border.all(color: Color(0xFFEEE9E9), width: 1),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Project name (bigger field)
                              TextFormField(
                                controller:
                                    _model.projectnameTextFieldTextController,
                                focusNode: _model.projectnameTextFieldFocusNode,
                                decoration: InputDecoration(
                                  labelText: 'Project name',
                                  hintText: 'Enter project name',
                                  prefixIcon: Icon(Icons.drive_file_rename_outline),
                                  filled: true,
                                  fillColor: theme.secondaryBackground,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xFFF29315), width: 1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: theme.primary, width: 1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                style: theme.bodyMedium,
                                maxLines: 3,
                                minLines: 1,
                                cursorColor: theme.primaryText,
                                validator: _model
                                    .projectnameTextFieldTextControllerValidator
                                    .asValidator(context),
                              ),
                              const SizedBox(height: 12),

                              // Two-column row: client name + phone
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: _model
                                          .clientNameTextFieldTextController,
                                      focusNode:
                                          _model.clientNameTextFieldFocusNode,
                                      decoration: InputDecoration(
                                        labelText: 'Client name',
                                        hintText: 'Enter client name',
                                        prefixIcon: Icon(Icons.person_outline),
                                        filled: true,
                                        fillColor: theme.secondaryBackground,
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xFFF29315), width: 1),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: theme.primary, width: 1),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                      ),
                                      style: theme.bodyMedium,
                                      maxLines: 1,
                                      cursorColor: theme.primaryText,
                                      validator: _model
                                          .clientNameTextFieldTextControllerValidator
                                          .asValidator(context),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: TextFormField(
                                      controller: _model
                                          .clientPhoneTextFieldTextController,
                                      focusNode:
                                          _model.clientPhoneTextFieldFocusNode,
                                      decoration: InputDecoration(
                                        labelText: 'Client phone',
                                        hintText: 'Mobile number',
                                        prefixIcon: Icon(Icons.phone_outlined),
                                        filled: true,
                                        fillColor: theme.secondaryBackground,
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xFFF29315), width: 1),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: theme.primary, width: 1),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                      ),
                                      style: theme.bodyMedium,
                                      keyboardType: TextInputType.phone,
                                      maxLines: 1,
                                      cursorColor: theme.primaryText,
                                      validator: _model
                                          .clientPhoneTextFieldTextControllerValidator
                                          .asValidator(context),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 12),

                              TextFormField(
                                controller: _model
                                    .contactdetailsTextFieldTextController,
                                focusNode:
                                    _model.contactdetailsTextFieldFocusNode,
                                decoration: InputDecoration(
                                  labelText: 'Client contact details',
                                  hintText: 'Additional contact info',
                                  prefixIcon: Icon(Icons.contact_page_outlined),
                                  filled: true,
                                  fillColor: theme.secondaryBackground,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xFFF29315), width: 1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: theme.primary, width: 1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                style: theme.bodyMedium,
                                maxLines: 3,
                                cursorColor: theme.primaryText,
                                validator: _model
                                    .contactdetailsTextFieldTextControllerValidator
                                    .asValidator(context),
                              ),

                              const SizedBox(height: 12),

                              // Partner info group
                              Divider(),
                              Text('Partner details',
                                  style: theme.titleSmall.override(
                                      font: GoogleFonts.inter(
                                          fontWeight: FontWeight.w600))),
                              const SizedBox(height: 8),
                              TextFormField(
                                controller: _model
                                    .partnerNameTextFieldTextController,
                                focusNode:
                                    _model.partnerNameTextFieldFocusNode,
                                decoration: InputDecoration(
                                  labelText: 'Partner name',
                                  prefixIcon: Icon(Icons.group_outlined),
                                  filled: true,
                                  fillColor: theme.secondaryBackground,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xFFF29315), width: 1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: theme.primary, width: 1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                style: theme.bodyMedium,
                                maxLines: 1,
                                cursorColor: theme.primaryText,
                                validator: _model
                                    .partnerNameTextFieldTextControllerValidator
                                    .asValidator(context),
                              ),
                              const SizedBox(height: 8),
                              TextFormField(
                                controller: _model
                                    .partnerPhoneTextFieldTextController,
                                focusNode:
                                    _model.partnerPhoneTextFieldFocusNode,
                                decoration: InputDecoration(
                                  labelText: 'Partner phone',
                                  prefixIcon: Icon(Icons.phone_android),
                                  filled: true,
                                  fillColor: theme.secondaryBackground,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xFFF29315), width: 1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: theme.primary, width: 1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                style: theme.bodyMedium,
                                maxLines: 1,
                                cursorColor: theme.primaryText,
                                validator: _model
                                    .partnerPhoneTextFieldTextControllerValidator
                                    .asValidator(context),
                              ),
                              const SizedBox(height: 8),
                              TextFormField(
                                controller: _model
                                    .partnerDetailsTextFieldTextController,
                                focusNode:
                                    _model.partnerDetailsTextFieldFocusNode,
                                decoration: InputDecoration(
                                  labelText: 'Partner contact details',
                                  prefixIcon: Icon(Icons.info_outline),
                                  filled: true,
                                  fillColor: theme.secondaryBackground,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xFFF29315), width: 1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: theme.primary, width: 1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                style: theme.bodyMedium,
                                maxLines: 2,
                                cursorColor: theme.primaryText,
                                validator: _model
                                    .partnerDetailsTextFieldTextControllerValidator
                                    .asValidator(context),
                              ),

                              const SizedBox(height: 12),

                              TextFormField(
                                controller:
                                    _model.addressOfSiteTextFieldTextController,
                                focusNode:
                                    _model.addressOfSiteTextFieldFocusNode,
                                decoration: InputDecoration(
                                  labelText: 'Address of site',
                                  hintText: 'Full site address',
                                  prefixIcon: Icon(Icons.location_on_outlined),
                                  filled: true,
                                  fillColor: theme.secondaryBackground,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xFFF29315), width: 1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: theme.primary, width: 1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                style: theme.bodyMedium,
                                maxLines: 3,
                                cursorColor: theme.primaryText,
                                validator: _model
                                    .addressOfSiteTextFieldTextControllerValidator
                                    .asValidator(context),
                              ),
                              const SizedBox(height: 12),

                              // Upload logo + preview row
                              Row(
                                children: [
                                  Expanded(
                                    child: FFButtonWidget(
                                      onPressed: () async {
                                        // kept intentionally blank to preserve existing behavior
                                      },
                                      text: 'Upload Client Logo',
                                      options: FFButtonOptions(
                                        height: 40.0,
                                        color: theme.secondaryBackground,
                                        textStyle: theme.titleSmall.override(
                                          font: GoogleFonts.interTight(),
                                          color: theme.secondary,
                                        ),
                                        elevation: 0,
                                        borderSide:
                                            BorderSide(color: theme.secondary),
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Container(
                                    width: 84,
                                    height: 56,
                                    clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: Color(0xFFEEE9E9)),
                                    ),
                                    child: Image.network(
                                      'https://images.unsplash.com/photo-1557188969-16b469a5b6c2?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwxfHxiZWF1dGlmdWwlMjBvY2VhbnxlbnwwfHx8fDE3NTQ5OTkxMTV8MA&ixlib=rb-4.1.0&q=80&w=1080',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),

                // Bottom action bar (keeps same save logic)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => context.safePop(),
                          style: OutlinedButton.styleFrom(
                              side: BorderSide(color: theme.primaryText),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(28))),
                          child: Text('Cancel',
                              style: theme.titleSmall.override(
                                  color: theme.primaryText, fontSize: 14)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: FFButtonWidget(
                          onPressed: () async {
                            _model.jsonFormData = <String, dynamic>{
                              'projectName':
                                  _model.projectnameTextFieldTextController
                                      .text,
                              'clientName':
                                  _model.clientNameTextFieldTextController
                                      .text,
                              'clientPhoneNumber':
                                  _model.clientPhoneTextFieldTextController
                                      .text,
                            };
                            safeSetState(() {});
                            _model.onButtonDeviceOnline =
                                await actions.isDeviceOnline();
                            if (_model.onButtonDeviceOnline == false) {
                              await RecceresponsesTable().insert({
                                'reccestageid':
                                    '0bee28f5-b3cd-4d34-aea9-c64a1dfc291d',
                                'formjson': _model.jsonFormData,
                                'submittedby':
                                    '4c315b52-a0cb-4446-802b-1e98e6b00bf5',
                                'submittedat':
                                    supaSerialize<DateTime>(getCurrentTimestamp),
                                'createdat':
                                    supaSerialize<DateTime>(getCurrentTimestamp),
                                'location': 'Bengaluru',
                                'stageNo': 1,
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Data saved!',
                                    style: TextStyle(
                                      color: theme.primaryText,
                                    ),
                                  ),
                                  duration: Duration(milliseconds: 4000),
                                  backgroundColor: theme.secondary,
                                ),
                              );
                            } else {
                              await actions.saveOfflineForm(
                                'offlineForms',
                                getCurrentTimestamp.toString(),
                                _model.jsonFormData!,
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Save to Hive',
                                    style: TextStyle(
                                      color: theme.primaryText,
                                    ),
                                  ),
                                  duration: Duration(milliseconds: 4000),
                                  backgroundColor: theme.secondary,
                                ),
                              );
                              _model.getOfflineData =
                                  await actions.getOfflineForm(
                                'offlineForms',
                              );
                            }

                            safeSetState(() {});
                          },
                          text: 'Save',
                          options: FFButtonOptions(
                            height: 44.0,
                            color: theme.secondary,
                            textStyle: theme.titleSmall.override(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                            elevation: 0.0,
                            borderRadius: BorderRadius.circular(28.0),
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
    );
  }
}
