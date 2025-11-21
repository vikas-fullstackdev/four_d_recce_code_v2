import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import 'dart:ui';
import 'edit_profile_widget.dart' show EditProfileWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EditProfileModel extends FlutterFlowModel<EditProfileWidget> {
  ///  Local state fields for this page.

  List<dynamic> proposedSiteLocation = [];
  void addToProposedSiteLocation(dynamic item) =>
      proposedSiteLocation.add(item);
  void removeFromProposedSiteLocation(dynamic item) =>
      proposedSiteLocation.remove(item);
  void removeAtIndexFromProposedSiteLocation(int index) =>
      proposedSiteLocation.removeAt(index);
  void insertAtIndexInProposedSiteLocation(int index, dynamic item) =>
      proposedSiteLocation.insert(index, item);
  void updateProposedSiteLocationAtIndex(
          int index, Function(dynamic) updateFn) =>
      proposedSiteLocation[index] = updateFn(proposedSiteLocation[index]);

  ///  State fields for stateful widgets in this page.

  // State field(s) for userNameTextField widget.
  FocusNode? userNameTextFieldFocusNode;
  TextEditingController? userNameTextFieldTextController;
  String? Function(BuildContext, String?)?
      userNameTextFieldTextControllerValidator;
  // State field(s) for mobileNoTextField widget.
  FocusNode? mobileNoTextFieldFocusNode;
  TextEditingController? mobileNoTextFieldTextController;
  String? Function(BuildContext, String?)?
      mobileNoTextFieldTextControllerValidator;
  bool isDataUploading_locationPlanUploadDataProfile = false;
  FFUploadedFile uploadedLocalFile_locationPlanUploadDataProfile =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');
  String uploadedFileUrl_locationPlanUploadDataProfile = '';

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    userNameTextFieldFocusNode?.dispose();
    userNameTextFieldTextController?.dispose();

    mobileNoTextFieldFocusNode?.dispose();
    mobileNoTextFieldTextController?.dispose();
  }
}
