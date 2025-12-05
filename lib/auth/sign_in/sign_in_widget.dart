import '/auth/supabase_auth/auth_util.dart';
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
import 'sign_in_model.dart';
export 'sign_in_model.dart';

class SignInWidget extends StatefulWidget {
  const SignInWidget({super.key});

  static String routeName = 'signIn';
  static String routePath = '/signIn';

  @override
  State<SignInWidget> createState() => _SignInWidgetState();
}

class _SignInWidgetState extends State<SignInWidget> {
  late SignInModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SignInModel());

    _model.emailFieldTextController ??= TextEditingController();
    _model.emailFieldFocusNode ??= FocusNode();

    _model.passwordFieldTextController ??= TextEditingController();
    _model.passwordFieldFocusNode ??= FocusNode();

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
          title: Text('Sign in', style: theme.titleMedium),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 18.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text('Welcome back', style: theme.titleLarge.override(fontWeight: FontWeight.w700)),
                  const SizedBox(height: 6),
                  Text('Sign in to continue capturing site details', style: theme.bodySmall, textAlign: TextAlign.center),
                  const SizedBox(height: 18),

                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _model.emailFieldTextController,
                            focusNode: _model.emailFieldFocusNode,
                            decoration: InputDecoration(labelText: 'Email', filled: true, fillColor: theme.secondaryBackground),
                            validator: _model.emailFieldTextControllerValidator.asValidator(context),
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: _model.passwordFieldTextController,
                            focusNode: _model.passwordFieldFocusNode,
                            obscureText: !_model.passwordFieldVisibility,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              filled: true,
                              fillColor: theme.secondaryBackground,
                              suffixIcon: InkWell(
                                onTap: () => safeSetState(() => _model.passwordFieldVisibility = !_model.passwordFieldVisibility),
                                focusNode: FocusNode(skipTraversal: true),
                                child: Icon(_model.passwordFieldVisibility ? Icons.visibility_outlined : Icons.visibility_off_outlined, size: 22),
                              ),
                            ),
                            validator: _model.passwordFieldTextControllerValidator.asValidator(context),
                          ),
                          const SizedBox(height: 8),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () async {
                                context.pushNamed(ForgetPasswordWidget.routeName);
                              },
                              child: Text('Forgot password?', style: theme.bodySmall.override(color: theme.primary)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),
                  FFButtonWidget(
                    onPressed: () async {
                      GoRouter.of(context).prepareAuthEvent();

                      final user = await authManager.signInWithEmail(
                        context,
                        _model.emailFieldTextController.text,
                        _model.passwordFieldTextController.text,
                      );
                      if (user == null) {
                        return;
                      }

                      context.goNamedAuth(OpeningScreenWidget.routeName, context.mounted);
                    },
                    text: 'Sign in',
                    options: FFButtonOptions(
                      width: double.infinity,
                      height: 50.0,
                      color: theme.secondary,
                      textStyle: theme.titleSmall.override(color: theme.secondaryBackground, fontWeight: FontWeight.w700),
                      elevation: 0.0,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),

                  // const SizedBox(height: 12),
                  // OutlinedButton.icon(
                  //   onPressed: () {
                  //     print('continueWithGoogleButton pressed ...');
                  //   },
                  //   icon: const FaIcon(FontAwesomeIcons.google, size: 16),
                  //   label: Text('Continue with Google', style: theme.bodySmall),
                  //   style: OutlinedButton.styleFrom(minimumSize: const Size.fromHeight(48), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                  // ),

                  const SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('First time here? ', style: theme.bodySmall),
                      InkWell(
                        onTap: () async {
                          context.pushNamed(SignUpWidget.routeName);
                        },
                        child: Text('Create an account', style: theme.bodySmall.override(color: theme.primary, fontWeight: FontWeight.w600)),
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
