import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import 'store_analysis_details_widget.dart' show StoreAnalysisDetailsWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class StoreAnalysisDetailsModel
    extends FlutterFlowModel<StoreAnalysisDetailsWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for storeNameTextField widget.
  FocusNode? storeNameTextFieldFocusNode;
  TextEditingController? storeNameTextFieldTextController;
  String? Function(BuildContext, String?)?
      storeNameTextFieldTextControllerValidator;
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
  // State field(s) for Switch widget.
  bool? switchValue1;
  // State field(s) for q1Switch widget.
  bool? q1SwitchValue;
  // State field(s) for q1DropDown widget.
  String? q1DropDownValue;
  FormFieldController<String>? q1DropDownValueController;
  // State field(s) for Switch widget.
  bool? switchValue2;
  // State field(s) for Switch widget.
  bool? switchValue3;
  // State field(s) for q3DropDown widget.
  List<String>? q3DropDownValue;
  FormFieldController<List<String>>? q3DropDownValueController;
  // State field(s) for q5Switch widget.
  bool? q5SwitchValue;
  // Stores action output result for [Backend Call - Insert Row] action in Button widget.
  StoreRow? projectInfoVar;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    storeNameTextFieldFocusNode?.dispose();
    storeNameTextFieldTextController?.dispose();

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
