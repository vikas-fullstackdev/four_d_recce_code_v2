import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_timer.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/upload_data.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'add_store_new_annoted_image_widget.dart'
    show AddStoreNewAnnotedImageWidget;
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddStoreNewAnnotedImageModel
    extends FlutterFlowModel<AddStoreNewAnnotedImageWidget> {
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
  bool isDataUploading_siteLocUploadDataA1 = false;
  List<FFUploadedFile> uploadedLocalFiles_siteLocUploadDataA1 = [];
  List<String> uploadedFileUrls_siteLocUploadDataA1 = [];

  bool isDataUploading_locationPlanUploadDataEq2 = false;
  List<FFUploadedFile> uploadedLocalFiles_locationPlanUploadDataEq2 = [];
  List<String> uploadedFileUrls_locationPlanUploadDataEq2 = [];

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
  bool isDataUploading_q21UploadData74b31 = false;
  List<FFUploadedFile> uploadedLocalFiles_q21UploadData74b31 = [];
  List<String> uploadedFileUrls_q21UploadData74b31 = [];

  bool isDataUploading_q22UploadData74b32 = false;
  List<FFUploadedFile> uploadedLocalFiles_q22UploadData74b32 = [];
  List<String> uploadedFileUrls_q22UploadData74b32 = [];

  bool isDataUploading_q23UploadData74b33 = false;
  List<FFUploadedFile> uploadedLocalFiles_q23UploadData74b33 = [];
  List<String> uploadedFileUrls_q23UploadData74b33 = [];

  // State field(s) for Switch widget.
  bool? switchValue2;
  // State field(s) for Switch widget.
  bool? switchValue3;
  // State field(s) for q3DropDown widget.
  List<String>? q3DropDownValue;
  FormFieldController<List<String>>? q3DropDownValueController;
  bool isDataUploading_q41UploadData74b41 = false;
  List<FFUploadedFile> uploadedLocalFiles_q41UploadData74b41 = [];
  List<String> uploadedFileUrls_q41UploadData74b41 = [];

  bool isDataUploading_q42UploadData74b42 = false;
  List<FFUploadedFile> uploadedLocalFiles_q42UploadData74b42 = [];
  List<String> uploadedFileUrls_q42UploadData74b42 = [];

  bool isDataUploading_q43UploadData74b42 = false;
  List<FFUploadedFile> uploadedLocalFiles_q43UploadData74b42 = [];
  List<String> uploadedFileUrls_q43UploadData74b42 = [];

  // State field(s) for q5Switch widget.
  bool? q5SwitchValue;
  bool isDataUploading_q51UploadData74b5 = false;
  List<FFUploadedFile> uploadedLocalFiles_q51UploadData74b5 = [];
  List<String> uploadedFileUrls_q51UploadData74b5 = [];

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
