import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_checkbox_group.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:math';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import 'select_stage_for_p_d_f_widget.dart' show SelectStageForPDFWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SelectStageForPDFModel extends FlutterFlowModel<SelectStageForPDFWidget> {
  ///  Local state fields for this page.

  List<String> selectedStages = [];
  void addToSelectedStages(String item) => selectedStages.add(item);
  void removeFromSelectedStages(String item) => selectedStages.remove(item);
  void removeAtIndexFromSelectedStages(int index) =>
      selectedStages.removeAt(index);
  void insertAtIndexInSelectedStages(int index, String item) =>
      selectedStages.insert(index, item);
  void updateSelectedStagesAtIndex(int index, Function(String) updateFn) =>
      selectedStages[index] = updateFn(selectedStages[index]);

  ///  State fields for stateful widgets in this page.

  // State field(s) for CheckboxGroup widget.
  FormFieldController<List<String>>? checkboxGroupValueController;
  List<String>? get checkboxGroupValues => checkboxGroupValueController?.value;
  set checkboxGroupValues(List<String>? v) =>
      checkboxGroupValueController?.value = v;

  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  // Stores action output result for [Custom Action - storeFinalPdfDatabase] action in Button widget.
  String? downloadFinalPDF;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
