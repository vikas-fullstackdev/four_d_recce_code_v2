import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '/backend/schema/structs/index.dart';

import '/backend/supabase/supabase.dart';

import '/auth/base_auth_user_provider.dart';

import '/main.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/lat_lng.dart';
import '/flutter_flow/place.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'serialization_util.dart';

import '/index.dart';

export 'package:go_router/go_router.dart';
export 'serialization_util.dart';

const kTransitionInfoKey = '__transition_info__';

GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();

class AppStateNotifier extends ChangeNotifier {
  AppStateNotifier._();

  static AppStateNotifier? _instance;
  static AppStateNotifier get instance => _instance ??= AppStateNotifier._();

  BaseAuthUser? initialUser;
  BaseAuthUser? user;
  bool showSplashImage = true;
  String? _redirectLocation;

  /// Determines whether the app will refresh and build again when a sign
  /// in or sign out happens. This is useful when the app is launched or
  /// on an unexpected logout. However, this must be turned off when we
  /// intend to sign in/out and then navigate or perform any actions after.
  /// Otherwise, this will trigger a refresh and interrupt the action(s).
  bool notifyOnAuthChange = true;

  bool get loading => user == null || showSplashImage;
  bool get loggedIn => user?.loggedIn ?? false;
  bool get initiallyLoggedIn => initialUser?.loggedIn ?? false;
  bool get shouldRedirect => loggedIn && _redirectLocation != null;

  String getRedirectLocation() => _redirectLocation!;
  bool hasRedirect() => _redirectLocation != null;
  void setRedirectLocationIfUnset(String loc) => _redirectLocation ??= loc;
  void clearRedirectLocation() => _redirectLocation = null;

  /// Mark as not needing to notify on a sign in / out when we intend
  /// to perform subsequent actions (such as navigation) afterwards.
  void updateNotifyOnAuthChange(bool notify) => notifyOnAuthChange = notify;

  void update(BaseAuthUser newUser) {
    final shouldUpdate =
        user?.uid == null || newUser.uid == null || user?.uid != newUser.uid;
    initialUser ??= newUser;
    user = newUser;
    // Refresh the app on auth change unless explicitly marked otherwise.
    // No need to update unless the user has changed.
    if (notifyOnAuthChange && shouldUpdate) {
      notifyListeners();
    }
    // Once again mark the notifier as needing to update on auth change
    // (in order to catch sign in / out events).
    updateNotifyOnAuthChange(true);
  }

  void stopShowingSplashImage() {
    showSplashImage = false;
    notifyListeners();
  }
}

GoRouter createRouter(AppStateNotifier appStateNotifier) => GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      refreshListenable: appStateNotifier,
      navigatorKey: appNavigatorKey,
      errorBuilder: (context, state) =>
          appStateNotifier.loggedIn ? NavBarPage() : WelcomeScreenWidget(),
      routes: [
        FFRoute(
          name: '_initialize',
          path: '/',
          builder: (context, _) =>
              appStateNotifier.loggedIn ? NavBarPage() : WelcomeScreenWidget(),
        ),
        FFRoute(
          name: HomePageWidget.routeName,
          path: HomePageWidget.routePath,
          builder: (context, params) => params.isEmpty
              ? NavBarPage(initialPage: 'HomePage')
              : HomePageWidget(
                  projectType: params.getParam(
                    'projectType',
                    ParamType.String,
                  ),
                ),
        ),
        FFRoute(
          name: SignInWidget.routeName,
          path: SignInWidget.routePath,
          builder: (context, params) => SignInWidget(),
        ),
        FFRoute(
          name: SignUpWidget.routeName,
          path: SignUpWidget.routePath,
          builder: (context, params) => SignUpWidget(),
        ),
        FFRoute(
          name: ForgetPasswordWidget.routeName,
          path: ForgetPasswordWidget.routePath,
          builder: (context, params) => ForgetPasswordWidget(),
        ),
        FFRoute(
          name: ResetpasswordWidget.routeName,
          path: ResetpasswordWidget.routePath,
          builder: (context, params) => ResetpasswordWidget(),
        ),
        FFRoute(
          name: WelcomeScreenWidget.routeName,
          path: WelcomeScreenWidget.routePath,
          builder: (context, params) => WelcomeScreenWidget(),
        ),
        FFRoute(
          name: ReceTemplateWidget.routeName,
          path: ReceTemplateWidget.routePath,
          builder: (context, params) => ReceTemplateWidget(
            projectID: params.getParam(
              'projectID',
              ParamType.String,
            ),
            reccestageid: params.getParam(
              'reccestageid',
              ParamType.String,
            ),
            stageNo: params.getParam(
              'stageNo',
              ParamType.String,
            ),
            projectName: params.getParam(
              'projectName',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: AddprojectWidget.routeName,
          path: AddprojectWidget.routePath,
          builder: (context, params) => AddprojectWidget(
            projectType: params.getParam(
              'projectType',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: ProjectDetailPageWidget.routeName,
          path: ProjectDetailPageWidget.routePath,
          builder: (context, params) => ProjectDetailPageWidget(
            projectId: params.getParam(
              'projectId',
              ParamType.String,
            ),
            projectName: params.getParam(
              'projectName',
              ParamType.String,
            ),
            proectImage: params.getParam(
              'proectImage',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: DynamicRecceTemplateWidget.routeName,
          path: DynamicRecceTemplateWidget.routePath,
          builder: (context, params) => DynamicRecceTemplateWidget(
            currentPageIndex: params.getParam(
              'currentPageIndex',
              ParamType.int,
            ),
            projectID: params.getParam(
              'projectID',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: TaskWidget.routeName,
          path: TaskWidget.routePath,
          builder: (context, params) => TaskWidget(
            projectID: params.getParam(
              'projectID',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: DynamicRecceTemplateCopyWidget.routeName,
          path: DynamicRecceTemplateCopyWidget.routePath,
          builder: (context, params) => DynamicRecceTemplateCopyWidget(
            currentPageIndex: params.getParam(
              'currentPageIndex',
              ParamType.int,
            ),
            projectID: params.getParam(
              'projectID',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: DynamicRecceTemplate2Widget.routeName,
          path: DynamicRecceTemplate2Widget.routePath,
          builder: (context, params) => DynamicRecceTemplate2Widget(
            projectID: params.getParam(
              'projectID',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: MessagesWidget.routeName,
          path: MessagesWidget.routePath,
          builder: (context, params) => MessagesWidget(),
        ),
        FFRoute(
          name: QueryWidget.routeName,
          path: QueryWidget.routePath,
          builder: (context, params) => QueryWidget(),
        ),
        FFRoute(
          name: UploadSiteVisitInfoWidget.routeName,
          path: UploadSiteVisitInfoWidget.routePath,
          builder: (context, params) => UploadSiteVisitInfoWidget(),
        ),
        FFRoute(
          name: UploadQcVisitWidget.routeName,
          path: UploadQcVisitWidget.routePath,
          builder: (context, params) => UploadQcVisitWidget(),
        ),
        FFRoute(
          name: UploadAssetVerificationWidget.routeName,
          path: UploadAssetVerificationWidget.routePath,
          builder: (context, params) => UploadAssetVerificationWidget(),
        ),
        FFRoute(
          name: AddStoreWidget.routeName,
          path: AddStoreWidget.routePath,
          builder: (context, params) => AddStoreWidget(
            projectId: params.getParam(
              'projectId',
              ParamType.String,
            ),
            uploadSiteLocation: params.getParam(
              'uploadSiteLocation',
              ParamType.FFUploadedFile,
            ),
          ),
        ),
        FFRoute(
          name: MakeQcVisitWidget.routeName,
          path: MakeQcVisitWidget.routePath,
          builder: (context, params) => MakeQcVisitWidget(
            projectId: params.getParam(
              'projectId',
              ParamType.String,
            ),
            question: params.getParam(
              'question',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: StoreAnalysisWidget.routeName,
          path: StoreAnalysisWidget.routePath,
          builder: (context, params) => StoreAnalysisWidget(),
        ),
        FFRoute(
          name: StoreAnalysisDetailsWidget.routeName,
          path: StoreAnalysisDetailsWidget.routePath,
          builder: (context, params) => StoreAnalysisDetailsWidget(),
        ),
        FFRoute(
          name: QcVisitFormWidget.routeName,
          path: QcVisitFormWidget.routePath,
          builder: (context, params) => QcVisitFormWidget(
            projectId: params.getParam(
              'projectId',
              ParamType.String,
            ),
            recestageId: params.getParam(
              'recestageId',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: AddStoreNewWidget.routeName,
          path: AddStoreNewWidget.routePath,
          builder: (context, params) => AddStoreNewWidget(
            projectId: params.getParam(
              'projectId',
              ParamType.String,
            ),
            uploadSiteLocation: params.getParam(
              'uploadSiteLocation',
              ParamType.FFUploadedFile,
            ),
          ),
        ),
        FFRoute(
          name: MakeQcVisitCopyWidget.routeName,
          path: MakeQcVisitCopyWidget.routePath,
          builder: (context, params) => MakeQcVisitCopyWidget(),
        ),
        FFRoute(
          name: MakeQc2VisitWidget.routeName,
          path: MakeQc2VisitWidget.routePath,
          builder: (context, params) => MakeQc2VisitWidget(
            projectId: params.getParam(
              'projectId',
              ParamType.String,
            ),
            question: params.getParam(
              'question',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: MakeAssetVerificationWidget.routeName,
          path: MakeAssetVerificationWidget.routePath,
          builder: (context, params) => MakeAssetVerificationWidget(
            projectId: params.getParam(
              'projectId',
              ParamType.String,
            ),
            question: params.getParam(
              'question',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: AssetVerificationFormWidget.routeName,
          path: AssetVerificationFormWidget.routePath,
          builder: (context, params) => AssetVerificationFormWidget(
            projectId: params.getParam(
              'projectId',
              ParamType.String,
            ),
            recestageId: params.getParam(
              'recestageId',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: Qc2VisitFormWidget.routeName,
          path: Qc2VisitFormWidget.routePath,
          builder: (context, params) => Qc2VisitFormWidget(
            projectId: params.getParam(
              'projectId',
              ParamType.String,
            ),
            recestageId: params.getParam(
              'recestageId',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: QcDetailsWidget.routeName,
          path: QcDetailsWidget.routePath,
          builder: (context, params) => QcDetailsWidget(
            projectId: params.getParam(
              'projectId',
              ParamType.String,
            ),
            projectName: params.getParam(
              'projectName',
              ParamType.String,
            ),
            proectImage: params.getParam(
              'proectImage',
              ParamType.String,
            ),
            recestageId: params.getParam(
              'recestageId',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: Qc2DetailsWidget.routeName,
          path: Qc2DetailsWidget.routePath,
          builder: (context, params) => Qc2DetailsWidget(
            projectId: params.getParam(
              'projectId',
              ParamType.String,
            ),
            projectName: params.getParam(
              'projectName',
              ParamType.String,
            ),
            proectImage: params.getParam(
              'proectImage',
              ParamType.String,
            ),
            recestageId: params.getParam(
              'recestageId',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: AssetVerificationDetailsWidget.routeName,
          path: AssetVerificationDetailsWidget.routePath,
          builder: (context, params) => AssetVerificationDetailsWidget(
            projectId: params.getParam(
              'projectId',
              ParamType.String,
            ),
            projectName: params.getParam(
              'projectName',
              ParamType.String,
            ),
            proectImage: params.getParam(
              'proectImage',
              ParamType.String,
            ),
            recestageId: params.getParam(
              'recestageId',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: QcDetailPageWidget.routeName,
          path: QcDetailPageWidget.routePath,
          builder: (context, params) => QcDetailPageWidget(
            projectId: params.getParam(
              'projectId',
              ParamType.String,
            ),
            projectName: params.getParam(
              'projectName',
              ParamType.String,
            ),
            proectImage: params.getParam(
              'proectImage',
              ParamType.String,
            ),
            recestageId: params.getParam(
              'recestageId',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: AvDetailPageWidget.routeName,
          path: AvDetailPageWidget.routePath,
          builder: (context, params) => AvDetailPageWidget(
            projectId: params.getParam(
              'projectId',
              ParamType.String,
            ),
            projectName: params.getParam(
              'projectName',
              ParamType.String,
            ),
            proectImage: params.getParam(
              'proectImage',
              ParamType.String,
            ),
            recestageId: params.getParam(
              'recestageId',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: SdrDetailPageWidget.routeName,
          path: SdrDetailPageWidget.routePath,
          builder: (context, params) => params.isEmpty
              ? NavBarPage(initialPage: 'sdrDetailPage')
              : SdrDetailPageWidget(
                  projectId: params.getParam(
                    'projectId',
                    ParamType.String,
                  ),
                  projectName: params.getParam(
                    'projectName',
                    ParamType.String,
                  ),
                  proectImage: params.getParam(
                    'proectImage',
                    ParamType.String,
                  ),
                  recestageId: params.getParam(
                    'recestageId',
                    ParamType.String,
                  ),
                ),
        ),
        FFRoute(
          name: QcDetailsCopyWidget.routeName,
          path: QcDetailsCopyWidget.routePath,
          builder: (context, params) => QcDetailsCopyWidget(
            projectId: params.getParam(
              'projectId',
              ParamType.String,
            ),
            projectName: params.getParam(
              'projectName',
              ParamType.String,
            ),
            proectImage: params.getParam(
              'proectImage',
              ParamType.String,
            ),
            recestageId: params.getParam(
              'recestageId',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: QceditDetailsFormWidget.routeName,
          path: QceditDetailsFormWidget.routePath,
          builder: (context, params) => QceditDetailsFormWidget(
            projectId: params.getParam(
              'projectId',
              ParamType.String,
            ),
            projectName: params.getParam(
              'projectName',
              ParamType.String,
            ),
            proectImage: params.getParam(
              'proectImage',
              ParamType.String,
            ),
            recestageId: params.getParam(
              'recestageId',
              ParamType.String,
            ),
            receresponseId: params.getParam(
              'receresponseId',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: QchistoryWidget.routeName,
          path: QchistoryWidget.routePath,
          builder: (context, params) => QchistoryWidget(
            projectId: params.getParam(
              'projectId',
              ParamType.String,
            ),
            projectName: params.getParam(
              'projectName',
              ParamType.String,
            ),
            proectImage: params.getParam(
              'proectImage',
              ParamType.String,
            ),
            recestageId: params.getParam(
              'recestageId',
              ParamType.String,
            ),
            responseId: params.getParam(
              'responseId',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: AddProjectOfflineWidget.routeName,
          path: AddProjectOfflineWidget.routePath,
          builder: (context, params) => AddProjectOfflineWidget(),
        ),
        FFRoute(
          name: QcDetailsHistoryWidget.routeName,
          path: QcDetailsHistoryWidget.routePath,
          builder: (context, params) => QcDetailsHistoryWidget(
            projectId: params.getParam(
              'projectId',
              ParamType.String,
            ),
            projectName: params.getParam(
              'projectName',
              ParamType.String,
            ),
            proectImage: params.getParam(
              'proectImage',
              ParamType.String,
            ),
            recestageId: params.getParam(
              'recestageId',
              ParamType.String,
            ),
            creatDate: params.getParam(
              'creatDate',
              ParamType.DateTime,
            ),
            responseId: params.getParam(
              'responseId',
              ParamType.String,
            ),
            historyId: params.getParam(
              'historyId',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: SelectWorkCopyWidget.routeName,
          path: SelectWorkCopyWidget.routePath,
          builder: (context, params) => SelectWorkCopyWidget(),
        ),
        FFRoute(
          name: TaskCopyWidget.routeName,
          path: TaskCopyWidget.routePath,
          builder: (context, params) => TaskCopyWidget(),
        ),
        FFRoute(
          name: ProfileWidget.routeName,
          path: ProfileWidget.routePath,
          builder: (context, params) => ProfileWidget(),
        ),
        FFRoute(
          name: SelectStageForPDFWidget.routeName,
          path: SelectStageForPDFWidget.routePath,
          builder: (context, params) => SelectStageForPDFWidget(
            recestageId: params.getParam(
              'recestageId',
              ParamType.String,
            ),
            projectId: params.getParam(
              'projectId',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: ProjectDetailScreenTestWidget.routeName,
          path: ProjectDetailScreenTestWidget.routePath,
          builder: (context, params) => ProjectDetailScreenTestWidget(
            projectId: params.getParam(
              'projectId',
              ParamType.String,
            ),
            projectName: params.getParam(
              'projectName',
              ParamType.String,
            ),
            proectImage: params.getParam(
              'proectImage',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: SelectStageForPDFPageWidget.routeName,
          path: SelectStageForPDFPageWidget.routePath,
          builder: (context, params) => SelectStageForPDFPageWidget(
            recestageId: params.getParam(
              'recestageId',
              ParamType.String,
            ),
            projectId: params.getParam(
              'projectId',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: ReceDetailsWidget.routeName,
          path: ReceDetailsWidget.routePath,
          builder: (context, params) => ReceDetailsWidget(
            projectId: params.getParam(
              'projectId',
              ParamType.String,
            ),
            projectName: params.getParam(
              'projectName',
              ParamType.String,
            ),
            proectImage: params.getParam(
              'proectImage',
              ParamType.String,
            ),
            recestageId: params.getParam(
              'recestageId',
              ParamType.String,
            ),
            recceflatJson: params.getParam(
              'recceflatJson',
              ParamType.JSON,
            ),
            receresponseid: params.getParam(
              'receresponseid',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: UploadDesignCopyWidget.routeName,
          path: UploadDesignCopyWidget.routePath,
          builder: (context, params) => UploadDesignCopyWidget(),
        ),
        FFRoute(
          name: EditProfileWidget.routeName,
          path: EditProfileWidget.routePath,
          builder: (context, params) => EditProfileWidget(),
        ),
        FFRoute(
          name: AccountSettingsWidget.routeName,
          path: AccountSettingsWidget.routePath,
          builder: (context, params) => AccountSettingsWidget(
            password: params.getParam(
              'password',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: EditPasswordPageWidget.routeName,
          path: EditPasswordPageWidget.routePath,
          builder: (context, params) => EditPasswordPageWidget(),
        ),
        FFRoute(
          name: EditEmailPgaeWidget.routeName,
          path: EditEmailPgaeWidget.routePath,
          builder: (context, params) => EditEmailPgaeWidget(
            password: params.getParam(
              'password',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: TaskCopy2Widget.routeName,
          path: TaskCopy2Widget.routePath,
          builder: (context, params) => TaskCopy2Widget(),
        ),
        FFRoute(
          name: StoreDetailPageWidget.routeName,
          path: StoreDetailPageWidget.routePath,
          builder: (context, params) => StoreDetailPageWidget(
            projectId: params.getParam(
              'projectId',
              ParamType.String,
            ),
            projectName: params.getParam(
              'projectName',
              ParamType.String,
            ),
            proectImage: params.getParam(
              'proectImage',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: TaskCopy3Widget.routeName,
          path: TaskCopy3Widget.routePath,
          builder: (context, params) => TaskCopy3Widget(),
        ),
        FFRoute(
          name: ProjectSettingsWidget.routeName,
          path: ProjectSettingsWidget.routePath,
          builder: (context, params) => ProjectSettingsWidget(
            password: params.getParam(
              'password',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: DynamicRecceTemplate3Widget.routeName,
          path: DynamicRecceTemplate3Widget.routePath,
          builder: (context, params) => DynamicRecceTemplate3Widget(
            projectID: params.getParam(
              'projectID',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: AssignReccePageWidget.routeName,
          path: AssignReccePageWidget.routePath,
          builder: (context, params) => AssignReccePageWidget(
            recestageId: params.getParam(
              'recestageId',
              ParamType.String,
            ),
            projectId: params.getParam(
              'projectId',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: ReceDetailsHistoryWidget.routeName,
          path: ReceDetailsHistoryWidget.routePath,
          builder: (context, params) => ReceDetailsHistoryWidget(
            projectId: params.getParam(
              'projectId',
              ParamType.String,
            ),
            projectName: params.getParam(
              'projectName',
              ParamType.String,
            ),
            proectImage: params.getParam(
              'proectImage',
              ParamType.String,
            ),
            recestageId: params.getParam(
              'recestageId',
              ParamType.String,
            ),
            recceflatJson: params.getParam(
              'recceflatJson',
              ParamType.JSON,
            ),
          ),
        ),
        FFRoute(
          name: DynamicRecceTemplate3CopyWidget.routeName,
          path: DynamicRecceTemplate3CopyWidget.routePath,
          builder: (context, params) => DynamicRecceTemplate3CopyWidget(
            projectID: params.getParam(
              'projectID',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: ReceTemplateEditWidget.routeName,
          path: ReceTemplateEditWidget.routePath,
          builder: (context, params) => ReceTemplateEditWidget(
            projectID: params.getParam(
              'projectID',
              ParamType.String,
            ),
            reccestageid: params.getParam(
              'reccestageid',
              ParamType.String,
            ),
            stageNo: params.getParam(
              'stageNo',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: ReceTemplateListWidget.routeName,
          path: ReceTemplateListWidget.routePath,
          builder: (context, params) => ReceTemplateListWidget(
            projectId: params.getParam(
              'projectId',
              ParamType.String,
            ),
            projectName: params.getParam(
              'projectName',
              ParamType.String,
            ),
            proectImage: params.getParam(
              'proectImage',
              ParamType.String,
            ),
            recestageId: params.getParam(
              'recestageId',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: UsersListWidget.routeName,
          path: UsersListWidget.routePath,
          builder: (context, params) => UsersListWidget(),
        ),
        FFRoute(
          name: AssignRolesWidget.routeName,
          path: AssignRolesWidget.routePath,
          builder: (context, params) => AssignRolesWidget(
            userId: params.getParam(
              'userId',
              ParamType.String,
            ),
            uaerName: params.getParam(
              'uaerName',
              ParamType.String,
            ),
            userEmail: params.getParam(
              'userEmail',
              ParamType.String,
            ),
            userimage: params.getParam(
              'userimage',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: AddStoreNewAnnotedImageWidget.routeName,
          path: AddStoreNewAnnotedImageWidget.routePath,
          builder: (context, params) => AddStoreNewAnnotedImageWidget(
            projectId: params.getParam(
              'projectId',
              ParamType.String,
            ),
            uploadSiteLocation: params.getParam(
              'uploadSiteLocation',
              ParamType.FFUploadedFile,
            ),
          ),
        ),
        FFRoute(
          name: RecceTemplateWorkingWidget.routeName,
          path: RecceTemplateWorkingWidget.routePath,
          builder: (context, params) => RecceTemplateWorkingWidget(
            projectID: params.getParam(
              'projectID',
              ParamType.String,
            ),
            reccestageid: params.getParam(
              'reccestageid',
              ParamType.String,
            ),
            stageNo: params.getParam(
              'stageNo',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: AssignUserInProjectWidget.routeName,
          path: AssignUserInProjectWidget.routePath,
          builder: (context, params) => AssignUserInProjectWidget(
            recestageId: params.getParam(
              'recestageId',
              ParamType.String,
            ),
            projectId: params.getParam(
              'projectId',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: ReceTemplateWorkingWidget.routeName,
          path: ReceTemplateWorkingWidget.routePath,
          builder: (context, params) => ReceTemplateWorkingWidget(
            projectID: params.getParam(
              'projectID',
              ParamType.String,
            ),
            reccestageid: params.getParam(
              'reccestageid',
              ParamType.String,
            ),
            stageNo: params.getParam(
              'stageNo',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: AnnotatedImagesForStoreDetailWidget.routeName,
          path: AnnotatedImagesForStoreDetailWidget.routePath,
          builder: (context, params) => AnnotatedImagesForStoreDetailWidget(
            projectId: params.getParam(
              'projectId',
              ParamType.String,
            ),
            projectName: params.getParam(
              'projectName',
              ParamType.String,
            ),
            proectImage: params.getParam(
              'proectImage',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: AssignUserInProjectCopyWidget.routeName,
          path: AssignUserInProjectCopyWidget.routePath,
          builder: (context, params) => AssignUserInProjectCopyWidget(
            recestageId: params.getParam(
              'recestageId',
              ParamType.String,
            ),
            projectId: params.getParam(
              'projectId',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: RemoveUsersInProjectWidget.routeName,
          path: RemoveUsersInProjectWidget.routePath,
          builder: (context, params) => RemoveUsersInProjectWidget(
            recestageId: params.getParam(
              'recestageId',
              ParamType.String,
            ),
            projectId: params.getParam(
              'projectId',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: TaskCopy4Widget.routeName,
          path: TaskCopy4Widget.routePath,
          builder: (context, params) => TaskCopy4Widget(),
        ),
        FFRoute(
          name: AssignUserInProjectCopy2Widget.routeName,
          path: AssignUserInProjectCopy2Widget.routePath,
          builder: (context, params) => AssignUserInProjectCopy2Widget(
            recestageId: params.getParam(
              'recestageId',
              ParamType.String,
            ),
            projectId: params.getParam(
              'projectId',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: RemoveUserFromProjectWidget.routeName,
          path: RemoveUserFromProjectWidget.routePath,
          builder: (context, params) => RemoveUserFromProjectWidget(
            recestageId: params.getParam(
              'recestageId',
              ParamType.String,
            ),
            projectId: params.getParam(
              'projectId',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: TaskNewWidget.routeName,
          path: TaskNewWidget.routePath,
          builder: (context, params) => TaskNewWidget(),
        ),
        FFRoute(
          name: EditProjectWidget.routeName,
          path: EditProjectWidget.routePath,
          builder: (context, params) => EditProjectWidget(
            projectID: params.getParam(
              'projectID',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: OpeningScreenWidget.routeName,
          path: OpeningScreenWidget.routePath,
          builder: (context, params) => params.isEmpty
              ? NavBarPage(initialPage: 'OpeningScreen')
              : OpeningScreenWidget(),
        ),
        FFRoute(
          name: ReceTemplateCopyWidget.routeName,
          path: ReceTemplateCopyWidget.routePath,
          builder: (context, params) => ReceTemplateCopyWidget(
            projectID: params.getParam(
              'projectID',
              ParamType.String,
            ),
            reccestageid: params.getParam(
              'reccestageid',
              ParamType.String,
            ),
            stageNo: params.getParam(
              'stageNo',
              ParamType.String,
            ),
            projectName: params.getParam(
              'projectName',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: QcWidget.routeName,
          path: QcWidget.routePath,
          builder: (context, params) =>
              params.isEmpty ? NavBarPage(initialPage: 'qc') : QcWidget(),
        ),
        FFRoute(
          name: FinalStageWidget.routeName,
          path: FinalStageWidget.routePath,
          builder: (context, params) => params.isEmpty
              ? NavBarPage(initialPage: 'finalStage')
              : FinalStageWidget(),
        )
      ].map((r) => r.toRoute(appStateNotifier)).toList(),
    );

extension NavParamExtensions on Map<String, String?> {
  Map<String, String> get withoutNulls => Map.fromEntries(
        entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
}

extension NavigationExtensions on BuildContext {
  void goNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : goNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void pushNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : pushNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void safePop() {
    // If there is only one route on the stack, navigate to the initial
    // page instead of popping.
    if (canPop()) {
      pop();
    } else {
      go('/');
    }
  }
}

extension GoRouterExtensions on GoRouter {
  AppStateNotifier get appState => AppStateNotifier.instance;
  void prepareAuthEvent([bool ignoreRedirect = false]) =>
      appState.hasRedirect() && !ignoreRedirect
          ? null
          : appState.updateNotifyOnAuthChange(false);
  bool shouldRedirect(bool ignoreRedirect) =>
      !ignoreRedirect && appState.hasRedirect();
  void clearRedirectLocation() => appState.clearRedirectLocation();
  void setRedirectLocationIfUnset(String location) =>
      appState.updateNotifyOnAuthChange(false);
}

extension _GoRouterStateExtensions on GoRouterState {
  Map<String, dynamic> get extraMap =>
      extra != null ? extra as Map<String, dynamic> : {};
  Map<String, dynamic> get allParams => <String, dynamic>{}
    ..addAll(pathParameters)
    ..addAll(uri.queryParameters)
    ..addAll(extraMap);
  TransitionInfo get transitionInfo => extraMap.containsKey(kTransitionInfoKey)
      ? extraMap[kTransitionInfoKey] as TransitionInfo
      : TransitionInfo.appDefault();
}

class FFParameters {
  FFParameters(this.state, [this.asyncParams = const {}]);

  final GoRouterState state;
  final Map<String, Future<dynamic> Function(String)> asyncParams;

  Map<String, dynamic> futureParamValues = {};

  // Parameters are empty if the params map is empty or if the only parameter
  // present is the special extra parameter reserved for the transition info.
  bool get isEmpty =>
      state.allParams.isEmpty ||
      (state.allParams.length == 1 &&
          state.extraMap.containsKey(kTransitionInfoKey));
  bool isAsyncParam(MapEntry<String, dynamic> param) =>
      asyncParams.containsKey(param.key) && param.value is String;
  bool get hasFutures => state.allParams.entries.any(isAsyncParam);
  Future<bool> completeFutures() => Future.wait(
        state.allParams.entries.where(isAsyncParam).map(
          (param) async {
            final doc = await asyncParams[param.key]!(param.value)
                .onError((_, __) => null);
            if (doc != null) {
              futureParamValues[param.key] = doc;
              return true;
            }
            return false;
          },
        ),
      ).onError((_, __) => [false]).then((v) => v.every((e) => e));

  dynamic getParam<T>(
    String paramName,
    ParamType type, {
    bool isList = false,
    StructBuilder<T>? structBuilder,
  }) {
    if (futureParamValues.containsKey(paramName)) {
      return futureParamValues[paramName];
    }
    if (!state.allParams.containsKey(paramName)) {
      return null;
    }
    final param = state.allParams[paramName];
    // Got parameter from `extras`, so just directly return it.
    if (param is! String) {
      return param;
    }
    // Return serialized value.
    return deserializeParam<T>(
      param,
      type,
      isList,
      structBuilder: structBuilder,
    );
  }
}

class FFRoute {
  const FFRoute({
    required this.name,
    required this.path,
    required this.builder,
    this.requireAuth = false,
    this.asyncParams = const {},
    this.routes = const [],
  });

  final String name;
  final String path;
  final bool requireAuth;
  final Map<String, Future<dynamic> Function(String)> asyncParams;
  final Widget Function(BuildContext, FFParameters) builder;
  final List<GoRoute> routes;

  GoRoute toRoute(AppStateNotifier appStateNotifier) => GoRoute(
        name: name,
        path: path,
        redirect: (context, state) {
          if (appStateNotifier.shouldRedirect) {
            final redirectLocation = appStateNotifier.getRedirectLocation();
            appStateNotifier.clearRedirectLocation();
            return redirectLocation;
          }

          if (requireAuth && !appStateNotifier.loggedIn) {
            appStateNotifier.setRedirectLocationIfUnset(state.uri.toString());
            return '/welcomeScreen';
          }
          return null;
        },
        pageBuilder: (context, state) {
          fixStatusBarOniOS16AndBelow(context);
          final ffParams = FFParameters(state, asyncParams);
          final page = ffParams.hasFutures
              ? FutureBuilder(
                  future: ffParams.completeFutures(),
                  builder: (context, _) => builder(context, ffParams),
                )
              : builder(context, ffParams);
          final child = appStateNotifier.loading
              ? Center(
                  child: SizedBox(
                    width: 50.0,
                    height: 50.0,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        FlutterFlowTheme.of(context).primary,
                      ),
                    ),
                  ),
                )
              : page;

          final transitionInfo = state.transitionInfo;
          return transitionInfo.hasTransition
              ? CustomTransitionPage(
                  key: state.pageKey,
                  child: child,
                  transitionDuration: transitionInfo.duration,
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          PageTransition(
                    type: transitionInfo.transitionType,
                    duration: transitionInfo.duration,
                    reverseDuration: transitionInfo.duration,
                    alignment: transitionInfo.alignment,
                    child: child,
                  ).buildTransitions(
                    context,
                    animation,
                    secondaryAnimation,
                    child,
                  ),
                )
              : MaterialPage(key: state.pageKey, child: child);
        },
        routes: routes,
      );
}

class TransitionInfo {
  const TransitionInfo({
    required this.hasTransition,
    this.transitionType = PageTransitionType.fade,
    this.duration = const Duration(milliseconds: 300),
    this.alignment,
  });

  final bool hasTransition;
  final PageTransitionType transitionType;
  final Duration duration;
  final Alignment? alignment;

  static TransitionInfo appDefault() => TransitionInfo(hasTransition: false);
}

class RootPageContext {
  const RootPageContext(this.isRootPage, [this.errorRoute]);
  final bool isRootPage;
  final String? errorRoute;

  static bool isInactiveRootPage(BuildContext context) {
    final rootPageContext = context.read<RootPageContext?>();
    final isRootPage = rootPageContext?.isRootPage ?? false;
    final location = GoRouterState.of(context).uri.toString();
    return isRootPage &&
        location != '/' &&
        location != rootPageContext?.errorRoute;
  }

  static Widget wrap(Widget child, {String? errorRoute}) => Provider.value(
        value: RootPageContext(true, errorRoute),
        child: child,
      );
}

extension GoRouterLocationExtension on GoRouter {
  String getCurrentLocation() {
    final RouteMatch lastMatch = routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : routerDelegate.currentConfiguration;
    return matchList.uri.toString();
  }
}
