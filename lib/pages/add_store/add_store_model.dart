import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_timer.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'add_store_widget.dart' show AddStoreWidget;
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddStoreModel extends FlutterFlowModel<AddStoreWidget> {
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

  // State field(s) for storeNameTextField widget.
  FocusNode? storeNameTextFieldFocusNode;
  TextEditingController? storeNameTextFieldTextController;
  String? Function(BuildContext, String?)?
      storeNameTextFieldTextControllerValidator;
  // State field(s) for storeAddressTextField widget.
  FocusNode? storeAddressTextFieldFocusNode;
  TextEditingController? storeAddressTextFieldTextController;
  String? Function(BuildContext, String?)?
      storeAddressTextFieldTextControllerValidator;
  // State field(s) for cityDescriptionTextField widget.
  FocusNode? cityDescriptionTextFieldFocusNode;
  TextEditingController? cityDescriptionTextFieldTextController;
  String? Function(BuildContext, String?)?
      cityDescriptionTextFieldTextControllerValidator;
  // State field(s) for cityTierTextField widget.
  FocusNode? cityTierTextFieldFocusNode;
  TextEditingController? cityTierTextFieldTextController;
  String? Function(BuildContext, String?)?
      cityTierTextFieldTextControllerValidator;
  // State field(s) for locationDescriptionTextField widget.
  FocusNode? locationDescriptionTextFieldFocusNode;
  TextEditingController? locationDescriptionTextFieldTextController;
  String? Function(BuildContext, String?)?
      locationDescriptionTextFieldTextControllerValidator;
  bool isDataUploading_uploadDataUhn = false;
  List<FFUploadedFile> uploadedLocalFiles_uploadDataUhn = [];
  List<String> uploadedFileUrls_uploadDataUhn = [];

  bool isDataUploading_uploadDataEq2 = false;
  List<FFUploadedFile> uploadedLocalFiles_uploadDataEq2 = [];
  List<String> uploadedFileUrls_uploadDataEq2 = [];

  // Stores action output result for [Backend Call - Update Row(s)] action in Button widget.
  List<ProjectsRow>? storeInfo;
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
    storeNameTextFieldFocusNode?.dispose();
    storeNameTextFieldTextController?.dispose();

    storeAddressTextFieldFocusNode?.dispose();
    storeAddressTextFieldTextController?.dispose();

    cityDescriptionTextFieldFocusNode?.dispose();
    cityDescriptionTextFieldTextController?.dispose();

    cityTierTextFieldFocusNode?.dispose();
    cityTierTextFieldTextController?.dispose();

    locationDescriptionTextFieldFocusNode?.dispose();
    locationDescriptionTextFieldTextController?.dispose();

    timerController.dispose();
  }
}
