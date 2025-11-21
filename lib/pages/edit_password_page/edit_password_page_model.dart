import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/edit_password/edit_password_widget.dart';
import 'dart:ui';
import '/index.dart';
import 'edit_password_page_widget.dart' show EditPasswordPageWidget;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EditPasswordPageModel extends FlutterFlowModel<EditPasswordPageWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for oldpasswordTextField widget.
  FocusNode? oldpasswordTextFieldFocusNode;
  TextEditingController? oldpasswordTextFieldTextController;
  late bool oldpasswordTextFieldVisibility;
  String? Function(BuildContext, String?)?
      oldpasswordTextFieldTextControllerValidator;
  // State field(s) for newPasswordTextField widget.
  FocusNode? newPasswordTextFieldFocusNode;
  TextEditingController? newPasswordTextFieldTextController;
  late bool newPasswordTextFieldVisibility;
  String? Function(BuildContext, String?)?
      newPasswordTextFieldTextControllerValidator;
  // Model for editPassword component.
  late EditPasswordModel editPasswordModel;

  @override
  void initState(BuildContext context) {
    oldpasswordTextFieldVisibility = false;
    newPasswordTextFieldVisibility = false;
    editPasswordModel = createModel(context, () => EditPasswordModel());
  }

  @override
  void dispose() {
    oldpasswordTextFieldFocusNode?.dispose();
    oldpasswordTextFieldTextController?.dispose();

    newPasswordTextFieldFocusNode?.dispose();
    newPasswordTextFieldTextController?.dispose();

    editPasswordModel.dispose();
  }
}
