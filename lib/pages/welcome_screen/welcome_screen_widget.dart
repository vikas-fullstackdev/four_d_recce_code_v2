import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'welcome_screen_model.dart';
export 'welcome_screen_model.dart';

class WelcomeScreenWidget extends StatefulWidget {
  const WelcomeScreenWidget({super.key});

  static String routeName = 'welcomeScreen';
  static String routePath = '/welcomeScreen';

  @override
  State<WelcomeScreenWidget> createState() => _WelcomeScreenWidgetState();
}

class _WelcomeScreenWidgetState extends State<WelcomeScreenWidget> {
  late WelcomeScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => WelcomeScreenModel());

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
        body: SafeArea(
          top: true,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 32.0),
            child: Column(
              children: [
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Welcome',
                    style: theme.titleLarge.override(font: GoogleFonts.interTight(fontWeight: FontWeight.w700)),
                  ),
                ),
                const SizedBox(height: 18),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 28.0, horizontal: 18.0),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: Image.asset(
                            'assets/images/logo.png',
                            width: 160.0,
                            height: 160.0,
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(height: 18),
                        Text(
                          '4D Site Recce',
                          style: theme.titleMedium.override(font: GoogleFonts.interTight(fontWeight: FontWeight.w600, fontSize: 20)),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Capture site details, work offline and sync when online.',
                          style: theme.bodySmall,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 26),

                // Primary actions
                FFButtonWidget(
                  onPressed: () async {
                    context.pushNamed(SignUpWidget.routeName);
                  },
                  text: 'Get started',
                  options: FFButtonOptions(
                    width: double.infinity,
                    height: 50.0,
                    color: theme.primary,
                    textStyle: theme.titleSmall.override(color: theme.secondaryBackground, fontWeight: FontWeight.w600),
                    borderRadius: BorderRadius.circular(12.0),
                    elevation: 0,
                  ),
                ),
                const SizedBox(height: 12),
                OutlinedButton(
                  onPressed: () async {
                    context.pushNamed(SignInWidget.routeName);
                  },
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    side: BorderSide(color: theme.primaryText.withOpacity(0.12)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text('Log in', style: theme.titleSmall),
                ),

                const Spacer(),

                // Secondary gradient CTA (keeps original navigation)
                // InkWell(
                //   onTap: () async {
                //     context.pushNamed(SignInWidget.routeName);
                //   },
                //   child: Container(
                //     width: double.infinity,
                //     height: 48,
                //     decoration: BoxDecoration(
                //       gradient: LinearGradient(colors: [theme.accent1, const Color(0xFFF81724)]),
                //       borderRadius: BorderRadius.circular(12),
                //     ),
                //     // child: Center(
                //     //   child: Text('Quick login', style: theme.bodyMedium.override(color: theme.secondaryBackground, fontWeight: FontWeight.w600)),
                //     // ),
                //   ),
                // ),

                const SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have account? ', style: theme.bodySmall),
                    InkWell(
                      onTap: () async {
                        context.pushNamed(SignInWidget.routeName);
                      },
                      child: Text('Sign in', style: theme.bodySmall.override(color: theme.primary, fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
