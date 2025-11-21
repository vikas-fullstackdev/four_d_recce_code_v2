import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'edit_project_widget.dart' show EditProjectWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EditProjectModel extends FlutterFlowModel<EditProjectWidget> {
  ///  State fields for stateful widgets in this page.

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
  bool isDataUploading_uploadData74b1 = false;
  FFUploadedFile uploadedLocalFile_uploadData74b1 =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');
  String uploadedFileUrl_uploadData74b1 = '';

  // Stores action output result for [Backend Call - Update Row(s)] action in Button widget.
  List<ProjectsRow>? projectInfoVar;

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
