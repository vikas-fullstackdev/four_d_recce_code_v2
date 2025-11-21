import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import 'add_project_offline_widget.dart' show AddProjectOfflineWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddProjectOfflineModel extends FlutterFlowModel<AddProjectOfflineWidget> {
  ///  Local state fields for this page.

  dynamic jsonFormData;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - isDeviceOnline] action in addProjectOffline widget.
  bool? onPageLoadisDeviceOnline;
  // Stores action output result for [Custom Action - getOfflineForm] action in addProjectOffline widget.
  dynamic? onPageLoadOfflieData;
  // Stores action output result for [Backend Call - Insert Row] action in addProjectOffline widget.
  RecceresponsesRow? onPageLoadStoreToBackend;
  // Stores action output result for [Custom Action - getOfflineForm] action in addProjectOffline widget.
  dynamic? onPageLoadgetOfflineData;
  // State field(s) for projectnameTextField widget.
  FocusNode? projectnameTextFieldFocusNode;
  TextEditingController? projectnameTextFieldTextController;
  String? Function(BuildContext, String?)?
      projectnameTextFieldTextControllerValidator;
  // State field(s) for clientNameTextField widget.
  FocusNode? clientNameTextFieldFocusNode;
  TextEditingController? clientNameTextFieldTextController;
  String? Function(BuildContext, String?)?
      clientNameTextFieldTextControllerValidator;
  // State field(s) for clientPhoneTextField widget.
  FocusNode? clientPhoneTextFieldFocusNode;
  TextEditingController? clientPhoneTextFieldTextController;
  String? Function(BuildContext, String?)?
      clientPhoneTextFieldTextControllerValidator;
  // State field(s) for contactdetailsTextField widget.
  FocusNode? contactdetailsTextFieldFocusNode;
  TextEditingController? contactdetailsTextFieldTextController;
  String? Function(BuildContext, String?)?
      contactdetailsTextFieldTextControllerValidator;
  // State field(s) for partnerNameTextField widget.
  FocusNode? partnerNameTextFieldFocusNode;
  TextEditingController? partnerNameTextFieldTextController;
  String? Function(BuildContext, String?)?
      partnerNameTextFieldTextControllerValidator;
  // State field(s) for partnerPhoneTextField widget.
  FocusNode? partnerPhoneTextFieldFocusNode;
  TextEditingController? partnerPhoneTextFieldTextController;
  String? Function(BuildContext, String?)?
      partnerPhoneTextFieldTextControllerValidator;
  // State field(s) for partnerDetailsTextField widget.
  FocusNode? partnerDetailsTextFieldFocusNode;
  TextEditingController? partnerDetailsTextFieldTextController;
  String? Function(BuildContext, String?)?
      partnerDetailsTextFieldTextControllerValidator;
  // State field(s) for addressOfSiteTextField widget.
  FocusNode? addressOfSiteTextFieldFocusNode;
  TextEditingController? addressOfSiteTextFieldTextController;
  String? Function(BuildContext, String?)?
      addressOfSiteTextFieldTextControllerValidator;
  // Stores action output result for [Custom Action - isDeviceOnline] action in Button widget.
  bool? onButtonDeviceOnline;
  // Stores action output result for [Custom Action - getOfflineForm] action in Button widget.
  dynamic? getOfflineData;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    projectnameTextFieldFocusNode?.dispose();
    projectnameTextFieldTextController?.dispose();

    clientNameTextFieldFocusNode?.dispose();
    clientNameTextFieldTextController?.dispose();

    clientPhoneTextFieldFocusNode?.dispose();
    clientPhoneTextFieldTextController?.dispose();

    contactdetailsTextFieldFocusNode?.dispose();
    contactdetailsTextFieldTextController?.dispose();

    partnerNameTextFieldFocusNode?.dispose();
    partnerNameTextFieldTextController?.dispose();

    partnerPhoneTextFieldFocusNode?.dispose();
    partnerPhoneTextFieldTextController?.dispose();

    partnerDetailsTextFieldFocusNode?.dispose();
    partnerDetailsTextFieldTextController?.dispose();

    addressOfSiteTextFieldFocusNode?.dispose();
    addressOfSiteTextFieldTextController?.dispose();
  }
}
