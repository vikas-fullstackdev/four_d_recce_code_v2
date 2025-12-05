import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_timer.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import 'dart:ui';
import 'dart:typed_data'; // <-- added to ensure Uint8List is available
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'addproject_widget.dart' show AddprojectWidget;
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddprojectModel extends FlutterFlowModel<AddprojectWidget> {
  ///  Local state fields for this page.

  dynamic projectsData;

  String? debugMessage;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - openHiveBoxes] action in addproject widget.
  bool? openHiveBxOnLoad;
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
  bool isDataUploading_uploadData74b = false;
  FFUploadedFile uploadedLocalFile_uploadData74b =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');
  String uploadedFileUrl_uploadData74b = '';

  // Stores action output result for [Custom Action - addRecordToHive] action in Button widget.
  String? addRecordToHive;
  // Stores action output result for [Custom Action - getRecordsFromHive] action in Button widget.
  String? projectsDataFromHive;
  // Stores action output result for [Backend Call - Insert Row] action in Button widget.
  ProjectsRow? projectInfoVar;
  // State field(s) for Timer widget.
  final timerInitialTimeMs = 3000;
  int timerMilliseconds = 3000;
  String timerValue = StopWatchTimer.getDisplayTime(
    3000,
    hours: false,
    milliSecond: false,
  );
  FlutterFlowTimerController timerController =
      FlutterFlowTimerController(StopWatchTimer(mode: StopWatchMode.countDown));

  // Stores action output result for [Custom Action - isDeviceOnline] action in Timer widget.
  bool? isDeviceOnlineTImer;

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

    timerController.dispose();
  }
}