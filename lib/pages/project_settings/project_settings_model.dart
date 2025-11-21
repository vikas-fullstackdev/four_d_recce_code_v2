import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'dart:ui';
import '/index.dart';
import 'project_settings_widget.dart' show ProjectSettingsWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProjectSettingsModel extends FlutterFlowModel<ProjectSettingsWidget> {
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

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
