import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'rece_template_list_widget.dart' show ReceTemplateListWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ReceTemplateListModel extends FlutterFlowModel<ReceTemplateListWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - flattenJsonChildrenOnly] action in ListTile widget.
  dynamic? flatJson1;
  // Stores action output result for [Backend Call - Update Row(s)] action in ListTile widget.
  List<RecceresponsesRow>? recceStraightJsonOutput;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
