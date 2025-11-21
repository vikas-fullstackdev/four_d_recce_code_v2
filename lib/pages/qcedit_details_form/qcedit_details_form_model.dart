import '/auth/supabase_auth/auth_util.dart';
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/components/qc_edit_form_component_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import 'qcedit_details_form_widget.dart' show QceditDetailsFormWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class QceditDetailsFormModel extends FlutterFlowModel<QceditDetailsFormWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - convertQcResponsesToJson] action in Button widget.
  List<dynamic>? qcroutput1;
  // Stores action output result for [Backend Call - Update Row(s)] action in Button widget.
  List<RecceresponsesRow>? updatedrow;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
