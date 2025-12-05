import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'sign_up_model.dart';
export 'sign_up_model.dart';

class SignUpWidget extends StatefulWidget {
  const SignUpWidget({super.key});

  static String routeName = 'signUp';
  static String routePath = '/signUp';

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  late SignUpModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SignUpModel());

    _model.nameTextFieldTextController ??= TextEditingController();
    _model.nameTextFieldFocusNode ??= FocusNode();

    _model.emailTextFieldTextController ??= TextEditingController();
    _model.emailTextFieldFocusNode ??= FocusNode();

    _model.passwordTextFieldTextController ??= TextEditingController();
    _model.passwordTextFieldFocusNode ??= FocusNode();

    _model.confirmPasswordTextFieldTextController ??= TextEditingController();
    _model.confirmPasswordTextFieldFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: theme.primaryBackground,
        appBar: AppBar(
          backgroundColor: theme.primaryBackground,
          elevation: 0,
          leading: FlutterFlowIconButton(
            borderColor: const Color(0xFF9E9F9F),
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 40.0,
            icon: Icon(Icons.arrow_back, color: theme.primaryText, size: 22.0),
            onPressed: () async {
              context.safePop();
            },
          ),
          title: Text('Create account', style: theme.titleMedium),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 18.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text('Create your account', style: theme.titleLarge.override(fontWeight: FontWeight.w700)),
                  const SizedBox(height: 8),
                  Text('Sign up to start capturing site details.', style: theme.bodySmall, textAlign: TextAlign.center),
                  const SizedBox(height: 18),

                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _model.nameTextFieldTextController,
                            focusNode: _model.nameTextFieldFocusNode,
                            decoration: InputDecoration(labelText: 'Name', filled: true, fillColor: theme.secondaryBackground),
                            validator: _model.nameTextFieldTextControllerValidator.asValidator(context),
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: _model.emailTextFieldTextController,
                            focusNode: _model.emailTextFieldFocusNode,
                            decoration: InputDecoration(labelText: 'Email', filled: true, fillColor: theme.secondaryBackground),
                            validator: _model.emailTextFieldTextControllerValidator.asValidator(context),
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: _model.passwordTextFieldTextController,
                            focusNode: _model.passwordTextFieldFocusNode,
                            obscureText: !_model.passwordTextFieldVisibility,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              filled: true,
                              fillColor: theme.secondaryBackground,
                              suffixIcon: InkWell(
                                onTap: () => safeSetState(() => _model.passwordTextFieldVisibility = !_model.passwordTextFieldVisibility),
                                focusNode: FocusNode(skipTraversal: true),
                                child: Icon(_model.passwordTextFieldVisibility ? Icons.visibility_outlined : Icons.visibility_off_outlined, size: 22),
                              ),
                            ),
                            validator: _model.passwordTextFieldTextControllerValidator.asValidator(context),
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: _model.confirmPasswordTextFieldTextController,
                            focusNode: _model.confirmPasswordTextFieldFocusNode,
                            obscureText: !_model.confirmPasswordTextFieldVisibility,
                            decoration: InputDecoration(
                              labelText: 'Confirm Password',
                              filled: true,
                              fillColor: theme.secondaryBackground,
                              suffixIcon: InkWell(
                                onTap: () => safeSetState(() => _model.confirmPasswordTextFieldVisibility = !_model.confirmPasswordTextFieldVisibility),
                                focusNode: FocusNode(skipTraversal: true),
                                child: Icon(_model.confirmPasswordTextFieldVisibility ? Icons.visibility_outlined : Icons.visibility_off_outlined, size: 22),
                              ),
                            ),
                            validator: _model.confirmPasswordTextFieldTextControllerValidator.asValidator(context),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),

                  FFButtonWidget(
                    onPressed: () async {
                      GoRouter.of(context).prepareAuthEvent();

                      // Basic validation
                      final name = _model.nameTextFieldTextController.text.trim();
                      final email = _model.emailTextFieldTextController.text.trim();
                      final pass = _model.passwordTextFieldTextController.text;
                      final confirm = _model.confirmPasswordTextFieldTextController.text;

                      if (name.isEmpty || email.isEmpty || pass.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Please fill all required fields')),
                        );
                        return;
                      }
                      if (pass != confirm) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Passwords don\'t match!')),
                        );
                        return;
                      }

                      try {
                        final authResult = await authManager.createAccountWithEmail(
                          context,
                          email,
                          pass,
                        );
                        print('createAccountWithEmail result: $authResult');

                        if (authResult == null) {
                          const errMsg = 'Sign up failed (auth returned null)';
                          print(errMsg);
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text(errMsg)));
                          return;
                        }

                        // ---- Get UID robustly (different auth wrappers return different shapes) ----
                        String? uid;

                        try {
                          uid = (authResult as dynamic)?.user?.id as String?;
                        } catch (_) {}

                        try {
                          uid ??= (authResult as dynamic)?.userId as String?;
                        } catch (_) {}

                        try {
                          uid ??= (authResult as dynamic)?.id as String?;
                        } catch (_) {}

                        uid ??= currentUserUid;
                        if (uid == null || uid.isEmpty) {
                          await Future.delayed(const Duration(seconds: 1));
                          uid = currentUserUid;
                        }

                        if (uid == null || uid.isEmpty) {
                          const msg =
                              'Account created. Please confirm email (check your inbox). Profile row will be created on first login.';
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text(msg)));
                          return;
                        }

                        final baseRow = {
                          'userid': uid,
                          'name': name,
                          'email': email,
                          'createdat': supaSerialize<DateTime>(getCurrentTimestamp),
                          'role': 'viewer',
                        };

                        try {
                          await UsersTable().insert(baseRow);
                        } catch (insertErr) {
                          final rowWithPassword = Map<String, dynamic>.from(baseRow)..['password'] = pass;
                          try {
                            await UsersTable().insert(rowWithPassword);
                          } catch (secondErr) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Account created but profile insert failed. Please login after confirming your email.')),
                            );
                          }
                        }

                        context.pushNamedAuth(OpeningScreenWidget.routeName, context.mounted);
                      } catch (e, st) {
                        print('Sign up error: $e\n$st');
                        final msg = e?.toString() ?? 'Unknown exception';
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Sign up failed: $msg')),
                        );
                        await showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: const Text('Sign up error'),
                            content: SingleChildScrollView(child: Text(msg)),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text('OK'),
                              )
                            ],
                          ),
                        );
                        return;
                      }
                    },
                    text: 'Create account',
                    options: FFButtonOptions(
                      width: double.infinity,
                      height: 50.0,
                      color: theme.secondary,
                      textStyle: theme.titleSmall.override(color: theme.secondaryBackground, fontWeight: FontWeight.w700),
                      elevation: 0.0,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),

                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have an account? ', style: theme.bodySmall),
                      InkWell(
                        onTap: () async {
                          context.pushNamed(SignInWidget.routeName);
                        },
                        child: Text('Sign in', style: theme.bodySmall.override(color: theme.primary, fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
