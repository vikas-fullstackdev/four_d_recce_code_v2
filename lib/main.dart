import '/custom_code/actions/index.dart' as actions;
import 'package:provider/provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'auth/supabase_auth/supabase_user_provider.dart';
import 'auth/supabase_auth/auth_util.dart';

import '/backend/supabase/supabase.dart';
import 'backend/firebase/firebase_config.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'package:google_fonts/google_fonts.dart';
import 'flutter_flow/nav/nav.dart';
import 'index.dart';
// import 'package:four_d_recce_code/notification_service.dart';
import '/notification_service.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  GoogleFonts.config.allowRuntimeFetching = false;

  GoRouter.optionURLReflectsImperativeAPIs = true;
  usePathUrlStrategy();

  //await initFirebase();

  // Start initial custom actions code
  await actions.initHive();
  await actions.openHiveBoxes();
  // End initial custom actions code

  await SupaFlow.initialize();

  // initialize the notification
  // WidgetsFlutterBinding.ensureInitialized();
  // await NotificationService.init();
  await NotificationService.init();

  final appState = FFAppState(); // Initialize FFAppState
  await appState.initializePersistedState();

  runApp(ChangeNotifierProvider(
    create: (context) => appState,
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class MyAppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;

  late AppStateNotifier _appStateNotifier;
  late GoRouter _router;
  String getRoute([RouteMatch? routeMatch]) {
    final RouteMatch lastMatch =
        routeMatch ?? _router.routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : _router.routerDelegate.currentConfiguration;
    return matchList.uri.toString();
  }

  List<String> getRouteStack() =>
      _router.routerDelegate.currentConfiguration.matches
          .map((e) => getRoute(e))
          .toList();
  late Stream<BaseAuthUser> userStream;

  @override
  void initState() {
    super.initState();

    _appStateNotifier = AppStateNotifier.instance;
    _router = createRouter(_appStateNotifier);
    userStream = fourDRecceCodeSupabaseUserStream()
      ..listen((user) {
        _appStateNotifier.update(user);
      });
    jwtTokenStream.listen((_) {});
    Future.delayed(
      Duration(milliseconds: 1000),
      () => _appStateNotifier.stopShowingSplashImage(),
    );
  }

  void setThemeMode(ThemeMode mode) => safeSetState(() {
        _themeMode = mode;
      });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'FourDRecceCode',
      scrollBehavior: MyAppScrollBehavior(),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en', '')],
      theme: ThemeData(
        brightness: Brightness.light,
        useMaterial3: false,
      ),
      themeMode: _themeMode,
      routerConfig: _router,
    );
  }
}

class NavBarPage extends StatefulWidget {
  const NavBarPage({
    Key? key,
    this.initialPage,
    this.page, // child page provided by ShellRoute
    this.disableResizeToAvoidBottomInset = false, // added property with default
  }) : super(key: key);

  final String? initialPage;
  final Widget? page;
  final bool disableResizeToAvoidBottomInset; // added property

  @override
  _NavBarPageState createState() => _NavBarPageState();
}

/// This is the private State class that goes with NavBarPage.
class _NavBarPageState extends State<NavBarPage> {
  String _currentPageName = 'OpeningScreen';
  late Widget? _currentPage;

  @override
  void initState() {
    super.initState();
    _currentPageName = widget.initialPage ?? _currentPageName;
    _currentPage = widget.page;
  }

  @override
  Widget build(BuildContext context) {
    final tabs = {
      'OpeningScreen': OpeningScreenWidget(),
      'HomePage': HomePageWidget(),
      'sdrDetailPage': SdrDetailPageWidget(),
      'qc': QcWidget(),
      'finalStage': FinalStageWidget(),
    };

    // Determine which page name to use for the current selected index.
    // Prefer the ShellRoute-provided page (widget.page) when present so the
    // bottom nav highlights the correct tab after a GoRouter navigation.
    String currentPageName = _currentPageName;
    if (widget.page != null) {
      final childTypeName = widget.page!.runtimeType.toString();
      if (childTypeName == OpeningScreenWidget().runtimeType.toString()) {
        currentPageName = 'OpeningScreen';
      } else if (childTypeName == HomePageWidget().runtimeType.toString()) {
        currentPageName = 'HomePage';
      } else if (childTypeName == SdrDetailPageWidget().runtimeType.toString()) {
        currentPageName = 'sdrDetailPage';
      } else if (childTypeName == QcWidget().runtimeType.toString()) {
        currentPageName = 'qc';
      } else if (childTypeName == FinalStageWidget().runtimeType.toString()) {
        currentPageName = 'finalStage';
      }
    }

    final currentIndex = tabs.keys.toList().indexOf(currentPageName);
    // Ensure index is valid for BottomNavigationBar (cannot be -1)
    final safeCurrentIndex = currentIndex >= 0 ? currentIndex : 0;

    // Hide bottom nav for unauthenticated screens provided by ShellRoute
    // or when the current route path is an unauthenticated route
    // (covers the initial visit '/').
    // Use the helper extension in nav.dart to get the current router location.
    final path = Uri.parse(GoRouter.of(context).getCurrentLocation()).path;
    final unauthPaths = {'/', WelcomeScreenWidget.routePath, SignInWidget.routePath, SignUpWidget.routePath};
    final childTypeName = widget.page?.runtimeType.toString();
    final hideNavForUnauthScreens =
        unauthPaths.contains(path) ||
        (childTypeName != null &&
            ['WelcomeScreenWidget', 'SignInWidget', 'SignUpWidget'].contains(childTypeName));

    return Scaffold(
      resizeToAvoidBottomInset: !widget.disableResizeToAvoidBottomInset,
      // Prefer the ShellRoute-provided page when present; otherwise use the normal tab content:
      body: widget.page ?? tabs[_currentPageName],
      bottomNavigationBar: hideNavForUnauthScreens
          ? null
          : BottomNavigationBar(
              currentIndex: safeCurrentIndex,
              onTap: (i) {
                // Map tab index -> route name
                final routeNames = [
                  OpeningScreenWidget.routeName, // Home
                  HomePageWidget.routeName, // Projects
                  SdrDetailPageWidget.routeName, // Recce
                  QcWidget.routeName, // QC
                  FinalStageWidget.routeName, // Final
                ];

                safeSetState(() {
                  _currentPage = null;
                  _currentPageName = tabs.keys.toList()[i];
                });

                // Navigate to the selected route so router shows the correct page.
                // Use context.goNamed to replace location.
                if (i >= 0 && i < routeNames.length) {
                  try {
                    context.goNamed(routeNames[i]);
                  } catch (_) {
                    // Fallback: do nothing if navigation fails
                  }
                }
              },
              backgroundColor: FlutterFlowTheme.of(context).alternate,
              selectedItemColor: FlutterFlowTheme.of(context).secondary,
              unselectedItemColor: FlutterFlowTheme.of(context).secondaryText,
              showSelectedLabels: true,
              showUnselectedLabels: false,
              type: BottomNavigationBarType.fixed,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                  ),
                  label: 'Home',
                  tooltip: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.view_list,
                    size: 25.0,
                  ),
                  label: 'Projects',
                  tooltip: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.edit_square,
                    size: 24.0,
                  ),
                  label: 'Recce',
                  tooltip: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.check,
                    size: 24.0,
                  ),
                  label: 'QC',
                  tooltip: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.star,
                    size: 24.0,
                  ),
                  label: 'Final',
                  tooltip: '',
                ),
              ],
            ),
    );
  }
}
