import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/edit_email/edit_email_widget.dart';
import 'dart:ui';
import '/index.dart';
import 'edit_email_pgae_widget.dart' show EditEmailPgaeWidget;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EditEmailPgaeModel extends FlutterFlowModel<EditEmailPgaeWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for passwordTextField widget.
  FocusNode? passwordTextFieldFocusNode;
  TextEditingController? passwordTextFieldTextController;
  late bool passwordTextFieldVisibility;
  String? Function(BuildContext, String?)?
      passwordTextFieldTextControllerValidator;
  // State field(s) for newEmailTextField widget.
  FocusNode? newEmailTextFieldFocusNode;
  TextEditingController? newEmailTextFieldTextController;
  String? Function(BuildContext, String?)?
      newEmailTextFieldTextControllerValidator;
  String? _newEmailTextFieldTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'New Email is required';
    }

    if (!RegExp(kTextValidatorEmailRegex).hasMatch(val)) {
      return 'Has to be a valid email address.';
    }
    return null;
  }

  // Model for editEmail component.
  late EditEmailModel editEmailModel;

  @override
  void initState(BuildContext context) {
    passwordTextFieldVisibility = false;
    newEmailTextFieldTextControllerValidator =
        _newEmailTextFieldTextControllerValidator;
    editEmailModel = createModel(context, () => EditEmailModel());
  }

  @override
  void dispose() {
    passwordTextFieldFocusNode?.dispose();
    passwordTextFieldTextController?.dispose();

    newEmailTextFieldFocusNode?.dispose();
    newEmailTextFieldTextController?.dispose();

    editEmailModel.dispose();
  }
}
