import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'rece_template_edit_widget.dart' show ReceTemplateEditWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ReceTemplateEditModel extends FlutterFlowModel<ReceTemplateEditWidget> {
  ///  Local state fields for this page.

  dynamic localOfflineState;

  List<String> visibleItems = [];
  void addToVisibleItems(String item) => visibleItems.add(item);
  void removeFromVisibleItems(String item) => visibleItems.remove(item);
  void removeAtIndexFromVisibleItems(int index) => visibleItems.removeAt(index);
  void insertAtIndexInVisibleItems(int index, String item) =>
      visibleItems.insert(index, item);
  void updateVisibleItemsAtIndex(int index, Function(String) updateFn) =>
      visibleItems[index] = updateFn(visibleItems[index]);

  int? currentPageIndex = 0;

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // Stores action output result for [Backend Call - Query Rows] action in receTemplateEdit widget.
  List<ReccetemplatesRow>? dynamicRecceTemaplteData;
  // Stores action output result for [Custom Action - syncHiveToSupabase] action in receTemplateEdit widget.
  String? syncHoveToSupabaseOnSaveButton;
  // Stores action output result for [Custom Action - fetchAndFilterPages] action in receTemplateEdit widget.
  List<String>? filterAndFetchPages;
  // Stores action output result for [Custom Action - getAllTruePageIndex] action in receTemplateEdit widget.
  List<int>? getAllTruePageIndex;
  // Stores action output result for [Custom Action - getFirstPageIndex] action in receTemplateEdit widget.
  int? getFirstPageInde;
  // Stores action output result for [Custom Action - getLastPageIndex] action in receTemplateEdit widget.
  int? getLastPageIndex;
  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;
  // Stores action output result for [Custom Action - getNextPageIndex] action in PageView widget.
  int? getNextPageIndex;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode3;
  TextEditingController? textController3;
  String? Function(BuildContext, String?)? textController3Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode4;
  TextEditingController? textController4;
  String? Function(BuildContext, String?)? textController4Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode5;
  TextEditingController? textController5;
  String? Function(BuildContext, String?)? textController5Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode6;
  TextEditingController? textController6;
  String? Function(BuildContext, String?)? textController6Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode7;
  TextEditingController? textController7;
  String? Function(BuildContext, String?)? textController7Validator;
  // State field(s) for TextFieldInt_B1 widget.
  FocusNode? textFieldIntB1FocusNode;
  TextEditingController? textFieldIntB1TextController;
  String? Function(BuildContext, String?)?
      textFieldIntB1TextControllerValidator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode8;
  TextEditingController? textController9;
  String? Function(BuildContext, String?)? textController9Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode9;
  TextEditingController? textController10;
  String? Function(BuildContext, String?)? textController10Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode10;
  TextEditingController? textController11;
  String? Function(BuildContext, String?)? textController11Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode11;
  TextEditingController? textController12;
  String? Function(BuildContext, String?)? textController12Validator;
  // State field(s) for TextFieldInt_C1 widget.
  FocusNode? textFieldIntC1FocusNode;
  TextEditingController? textFieldIntC1TextController;
  String? Function(BuildContext, String?)?
      textFieldIntC1TextControllerValidator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode12;
  TextEditingController? textController14;
  String? Function(BuildContext, String?)? textController14Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode13;
  TextEditingController? textController15;
  String? Function(BuildContext, String?)? textController15Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode14;
  TextEditingController? textController16;
  String? Function(BuildContext, String?)? textController16Validator;
  // State field(s) for TextFieldint_d1 widget.
  FocusNode? textFieldintD1FocusNode;
  TextEditingController? textFieldintD1TextController;
  String? Function(BuildContext, String?)?
      textFieldintD1TextControllerValidator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode15;
  TextEditingController? textController18;
  String? Function(BuildContext, String?)? textController18Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode16;
  TextEditingController? textController19;
  String? Function(BuildContext, String?)? textController19Validator;
  // State field(s) for TextFieldInt_e1 widget.
  FocusNode? textFieldIntE1FocusNode;
  TextEditingController? textFieldIntE1TextController;
  String? Function(BuildContext, String?)?
      textFieldIntE1TextControllerValidator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode17;
  TextEditingController? textController21;
  String? Function(BuildContext, String?)? textController21Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode18;
  TextEditingController? textController22;
  String? Function(BuildContext, String?)? textController22Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode19;
  TextEditingController? textController23;
  String? Function(BuildContext, String?)? textController23Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode20;
  TextEditingController? textController24;
  String? Function(BuildContext, String?)? textController24Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode21;
  TextEditingController? textController25;
  String? Function(BuildContext, String?)? textController25Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode22;
  TextEditingController? textController26;
  String? Function(BuildContext, String?)? textController26Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode23;
  TextEditingController? textController27;
  String? Function(BuildContext, String?)? textController27Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode24;
  TextEditingController? textController28;
  String? Function(BuildContext, String?)? textController28Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode25;
  TextEditingController? textController29;
  String? Function(BuildContext, String?)? textController29Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode26;
  TextEditingController? textController30;
  String? Function(BuildContext, String?)? textController30Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode27;
  TextEditingController? textController31;
  String? Function(BuildContext, String?)? textController31Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode28;
  TextEditingController? textController32;
  String? Function(BuildContext, String?)? textController32Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode29;
  TextEditingController? textController33;
  String? Function(BuildContext, String?)? textController33Validator;
  // State field(s) for TextFieldInt_f1 widget.
  FocusNode? textFieldIntF1FocusNode;
  TextEditingController? textFieldIntF1TextController;
  String? Function(BuildContext, String?)?
      textFieldIntF1TextControllerValidator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode30;
  TextEditingController? textController35;
  String? Function(BuildContext, String?)? textController35Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode31;
  TextEditingController? textController36;
  String? Function(BuildContext, String?)? textController36Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode32;
  TextEditingController? textController37;
  String? Function(BuildContext, String?)? textController37Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode33;
  TextEditingController? textController38;
  String? Function(BuildContext, String?)? textController38Validator;
  // State field(s) for TextFieldInt_g1 widget.
  FocusNode? textFieldIntG1FocusNode;
  TextEditingController? textFieldIntG1TextController;
  String? Function(BuildContext, String?)?
      textFieldIntG1TextControllerValidator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode34;
  TextEditingController? textController40;
  String? Function(BuildContext, String?)? textController40Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode35;
  TextEditingController? textController41;
  String? Function(BuildContext, String?)? textController41Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode36;
  TextEditingController? textController42;
  String? Function(BuildContext, String?)? textController42Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode37;
  TextEditingController? textController43;
  String? Function(BuildContext, String?)? textController43Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode38;
  TextEditingController? textController44;
  String? Function(BuildContext, String?)? textController44Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode39;
  TextEditingController? textController45;
  String? Function(BuildContext, String?)? textController45Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode40;
  TextEditingController? textController46;
  String? Function(BuildContext, String?)? textController46Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode41;
  TextEditingController? textController47;
  String? Function(BuildContext, String?)? textController47Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode42;
  TextEditingController? textController48;
  String? Function(BuildContext, String?)? textController48Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode43;
  TextEditingController? textController49;
  String? Function(BuildContext, String?)? textController49Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode44;
  TextEditingController? textController50;
  String? Function(BuildContext, String?)? textController50Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode45;
  TextEditingController? textController51;
  String? Function(BuildContext, String?)? textController51Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode46;
  TextEditingController? textController52;
  String? Function(BuildContext, String?)? textController52Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode47;
  TextEditingController? textController53;
  String? Function(BuildContext, String?)? textController53Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode48;
  TextEditingController? textController54;
  String? Function(BuildContext, String?)? textController54Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode49;
  TextEditingController? textController55;
  String? Function(BuildContext, String?)? textController55Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode50;
  TextEditingController? textController56;
  String? Function(BuildContext, String?)? textController56Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode51;
  TextEditingController? textController57;
  String? Function(BuildContext, String?)? textController57Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode52;
  TextEditingController? textController58;
  String? Function(BuildContext, String?)? textController58Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode53;
  TextEditingController? textController59;
  String? Function(BuildContext, String?)? textController59Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode54;
  TextEditingController? textController60;
  String? Function(BuildContext, String?)? textController60Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode55;
  TextEditingController? textController61;
  String? Function(BuildContext, String?)? textController61Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode56;
  TextEditingController? textController62;
  String? Function(BuildContext, String?)? textController62Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode57;
  TextEditingController? textController63;
  String? Function(BuildContext, String?)? textController63Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode58;
  TextEditingController? textController64;
  String? Function(BuildContext, String?)? textController64Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode59;
  TextEditingController? textController65;
  String? Function(BuildContext, String?)? textController65Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode60;
  TextEditingController? textController66;
  String? Function(BuildContext, String?)? textController66Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode61;
  TextEditingController? textController67;
  String? Function(BuildContext, String?)? textController67Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode62;
  TextEditingController? textController68;
  String? Function(BuildContext, String?)? textController68Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode63;
  TextEditingController? textController69;
  String? Function(BuildContext, String?)? textController69Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode64;
  TextEditingController? textController70;
  String? Function(BuildContext, String?)? textController70Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode65;
  TextEditingController? textController71;
  String? Function(BuildContext, String?)? textController71Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode66;
  TextEditingController? textController72;
  String? Function(BuildContext, String?)? textController72Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode67;
  TextEditingController? textController73;
  String? Function(BuildContext, String?)? textController73Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode68;
  TextEditingController? textController74;
  String? Function(BuildContext, String?)? textController74Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode69;
  TextEditingController? textController75;
  String? Function(BuildContext, String?)? textController75Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode70;
  TextEditingController? textController76;
  String? Function(BuildContext, String?)? textController76Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode71;
  TextEditingController? textController77;
  String? Function(BuildContext, String?)? textController77Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode72;
  TextEditingController? textController78;
  String? Function(BuildContext, String?)? textController78Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode73;
  TextEditingController? textController79;
  String? Function(BuildContext, String?)? textController79Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode74;
  TextEditingController? textController80;
  String? Function(BuildContext, String?)? textController80Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode75;
  TextEditingController? textController81;
  String? Function(BuildContext, String?)? textController81Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode76;
  TextEditingController? textController82;
  String? Function(BuildContext, String?)? textController82Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode77;
  TextEditingController? textController83;
  String? Function(BuildContext, String?)? textController83Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode78;
  TextEditingController? textController84;
  String? Function(BuildContext, String?)? textController84Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode79;
  TextEditingController? textController85;
  String? Function(BuildContext, String?)? textController85Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode80;
  TextEditingController? textController86;
  String? Function(BuildContext, String?)? textController86Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode81;
  TextEditingController? textController87;
  String? Function(BuildContext, String?)? textController87Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode82;
  TextEditingController? textController88;
  String? Function(BuildContext, String?)? textController88Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode83;
  TextEditingController? textController89;
  String? Function(BuildContext, String?)? textController89Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode84;
  TextEditingController? textController90;
  String? Function(BuildContext, String?)? textController90Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode85;
  TextEditingController? textController91;
  String? Function(BuildContext, String?)? textController91Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode86;
  TextEditingController? textController92;
  String? Function(BuildContext, String?)? textController92Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode87;
  TextEditingController? textController93;
  String? Function(BuildContext, String?)? textController93Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode88;
  TextEditingController? textController94;
  String? Function(BuildContext, String?)? textController94Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode89;
  TextEditingController? textController95;
  String? Function(BuildContext, String?)? textController95Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode90;
  TextEditingController? textController96;
  String? Function(BuildContext, String?)? textController96Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode91;
  TextEditingController? textController97;
  String? Function(BuildContext, String?)? textController97Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode92;
  TextEditingController? textController98;
  String? Function(BuildContext, String?)? textController98Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode93;
  TextEditingController? textController99;
  String? Function(BuildContext, String?)? textController99Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode94;
  TextEditingController? textController100;
  String? Function(BuildContext, String?)? textController100Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode95;
  TextEditingController? textController101;
  String? Function(BuildContext, String?)? textController101Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode96;
  TextEditingController? textController102;
  String? Function(BuildContext, String?)? textController102Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode97;
  TextEditingController? textController103;
  String? Function(BuildContext, String?)? textController103Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode98;
  TextEditingController? textController104;
  String? Function(BuildContext, String?)? textController104Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode99;
  TextEditingController? textController105;
  String? Function(BuildContext, String?)? textController105Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode100;
  TextEditingController? textController106;
  String? Function(BuildContext, String?)? textController106Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode101;
  TextEditingController? textController107;
  String? Function(BuildContext, String?)? textController107Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode102;
  TextEditingController? textController108;
  String? Function(BuildContext, String?)? textController108Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode103;
  TextEditingController? textController109;
  String? Function(BuildContext, String?)? textController109Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode104;
  TextEditingController? textController110;
  String? Function(BuildContext, String?)? textController110Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode105;
  TextEditingController? textController111;
  String? Function(BuildContext, String?)? textController111Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode106;
  TextEditingController? textController112;
  String? Function(BuildContext, String?)? textController112Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode107;
  TextEditingController? textController113;
  String? Function(BuildContext, String?)? textController113Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode108;
  TextEditingController? textController114;
  String? Function(BuildContext, String?)? textController114Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode109;
  TextEditingController? textController115;
  String? Function(BuildContext, String?)? textController115Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode110;
  TextEditingController? textController116;
  String? Function(BuildContext, String?)? textController116Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode111;
  TextEditingController? textController117;
  String? Function(BuildContext, String?)? textController117Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode112;
  TextEditingController? textController118;
  String? Function(BuildContext, String?)? textController118Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode113;
  TextEditingController? textController119;
  String? Function(BuildContext, String?)? textController119Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode114;
  TextEditingController? textController120;
  String? Function(BuildContext, String?)? textController120Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode115;
  TextEditingController? textController121;
  String? Function(BuildContext, String?)? textController121Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode116;
  TextEditingController? textController122;
  String? Function(BuildContext, String?)? textController122Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode117;
  TextEditingController? textController123;
  String? Function(BuildContext, String?)? textController123Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode118;
  TextEditingController? textController124;
  String? Function(BuildContext, String?)? textController124Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode119;
  TextEditingController? textController125;
  String? Function(BuildContext, String?)? textController125Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode120;
  TextEditingController? textController126;
  String? Function(BuildContext, String?)? textController126Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode121;
  TextEditingController? textController127;
  String? Function(BuildContext, String?)? textController127Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode122;
  TextEditingController? textController128;
  String? Function(BuildContext, String?)? textController128Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode123;
  TextEditingController? textController129;
  String? Function(BuildContext, String?)? textController129Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode124;
  TextEditingController? textController130;
  String? Function(BuildContext, String?)? textController130Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode125;
  TextEditingController? textController131;
  String? Function(BuildContext, String?)? textController131Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode126;
  TextEditingController? textController132;
  String? Function(BuildContext, String?)? textController132Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode127;
  TextEditingController? textController133;
  String? Function(BuildContext, String?)? textController133Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode128;
  TextEditingController? textController134;
  String? Function(BuildContext, String?)? textController134Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode129;
  TextEditingController? textController135;
  String? Function(BuildContext, String?)? textController135Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode130;
  TextEditingController? textController136;
  String? Function(BuildContext, String?)? textController136Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode131;
  TextEditingController? textController137;
  String? Function(BuildContext, String?)? textController137Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode132;
  TextEditingController? textController138;
  String? Function(BuildContext, String?)? textController138Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode133;
  TextEditingController? textController139;
  String? Function(BuildContext, String?)? textController139Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode134;
  TextEditingController? textController140;
  String? Function(BuildContext, String?)? textController140Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode135;
  TextEditingController? textController141;
  String? Function(BuildContext, String?)? textController141Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode136;
  TextEditingController? textController142;
  String? Function(BuildContext, String?)? textController142Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode137;
  TextEditingController? textController143;
  String? Function(BuildContext, String?)? textController143Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode138;
  TextEditingController? textController144;
  String? Function(BuildContext, String?)? textController144Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode139;
  TextEditingController? textController145;
  String? Function(BuildContext, String?)? textController145Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode140;
  TextEditingController? textController146;
  String? Function(BuildContext, String?)? textController146Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode141;
  TextEditingController? textController147;
  String? Function(BuildContext, String?)? textController147Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode142;
  TextEditingController? textController148;
  String? Function(BuildContext, String?)? textController148Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode143;
  TextEditingController? textController149;
  String? Function(BuildContext, String?)? textController149Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode144;
  TextEditingController? textController150;
  String? Function(BuildContext, String?)? textController150Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode145;
  TextEditingController? textController151;
  String? Function(BuildContext, String?)? textController151Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode146;
  TextEditingController? textController152;
  String? Function(BuildContext, String?)? textController152Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode147;
  TextEditingController? textController153;
  String? Function(BuildContext, String?)? textController153Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode148;
  TextEditingController? textController154;
  String? Function(BuildContext, String?)? textController154Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode149;
  TextEditingController? textController155;
  String? Function(BuildContext, String?)? textController155Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode150;
  TextEditingController? textController156;
  String? Function(BuildContext, String?)? textController156Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode151;
  TextEditingController? textController157;
  String? Function(BuildContext, String?)? textController157Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode152;
  TextEditingController? textController158;
  String? Function(BuildContext, String?)? textController158Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode153;
  TextEditingController? textController159;
  String? Function(BuildContext, String?)? textController159Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode154;
  TextEditingController? textController160;
  String? Function(BuildContext, String?)? textController160Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode155;
  TextEditingController? textController161;
  String? Function(BuildContext, String?)? textController161Validator;
  // Stores action output result for [Custom Action - getPreviousPageIndex] action in Button widget.
  int? getPreviousPageIndex;
  // Stores action output result for [Custom Action - getNextPageIndex] action in Button widget.
  int? getNextIndex;
  // Stores action output result for [Custom Action - syncHiveToSupabase] action in Button widget.
  String? syncHiveToSupabaseOnSaveButton;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode1?.dispose();
    textController1?.dispose();

    textFieldFocusNode2?.dispose();
    textController2?.dispose();

    textFieldFocusNode3?.dispose();
    textController3?.dispose();

    textFieldFocusNode4?.dispose();
    textController4?.dispose();

    textFieldFocusNode5?.dispose();
    textController5?.dispose();

    textFieldFocusNode6?.dispose();
    textController6?.dispose();

    textFieldFocusNode7?.dispose();
    textController7?.dispose();

    textFieldIntB1FocusNode?.dispose();
    textFieldIntB1TextController?.dispose();

    textFieldFocusNode8?.dispose();
    textController9?.dispose();

    textFieldFocusNode9?.dispose();
    textController10?.dispose();

    textFieldFocusNode10?.dispose();
    textController11?.dispose();

    textFieldFocusNode11?.dispose();
    textController12?.dispose();

    textFieldIntC1FocusNode?.dispose();
    textFieldIntC1TextController?.dispose();

    textFieldFocusNode12?.dispose();
    textController14?.dispose();

    textFieldFocusNode13?.dispose();
    textController15?.dispose();

    textFieldFocusNode14?.dispose();
    textController16?.dispose();

    textFieldintD1FocusNode?.dispose();
    textFieldintD1TextController?.dispose();

    textFieldFocusNode15?.dispose();
    textController18?.dispose();

    textFieldFocusNode16?.dispose();
    textController19?.dispose();

    textFieldIntE1FocusNode?.dispose();
    textFieldIntE1TextController?.dispose();

    textFieldFocusNode17?.dispose();
    textController21?.dispose();

    textFieldFocusNode18?.dispose();
    textController22?.dispose();

    textFieldFocusNode19?.dispose();
    textController23?.dispose();

    textFieldFocusNode20?.dispose();
    textController24?.dispose();

    textFieldFocusNode21?.dispose();
    textController25?.dispose();

    textFieldFocusNode22?.dispose();
    textController26?.dispose();

    textFieldFocusNode23?.dispose();
    textController27?.dispose();

    textFieldFocusNode24?.dispose();
    textController28?.dispose();

    textFieldFocusNode25?.dispose();
    textController29?.dispose();

    textFieldFocusNode26?.dispose();
    textController30?.dispose();

    textFieldFocusNode27?.dispose();
    textController31?.dispose();

    textFieldFocusNode28?.dispose();
    textController32?.dispose();

    textFieldFocusNode29?.dispose();
    textController33?.dispose();

    textFieldIntF1FocusNode?.dispose();
    textFieldIntF1TextController?.dispose();

    textFieldFocusNode30?.dispose();
    textController35?.dispose();

    textFieldFocusNode31?.dispose();
    textController36?.dispose();

    textFieldFocusNode32?.dispose();
    textController37?.dispose();

    textFieldFocusNode33?.dispose();
    textController38?.dispose();

    textFieldIntG1FocusNode?.dispose();
    textFieldIntG1TextController?.dispose();

    textFieldFocusNode34?.dispose();
    textController40?.dispose();

    textFieldFocusNode35?.dispose();
    textController41?.dispose();

    textFieldFocusNode36?.dispose();
    textController42?.dispose();

    textFieldFocusNode37?.dispose();
    textController43?.dispose();

    textFieldFocusNode38?.dispose();
    textController44?.dispose();

    textFieldFocusNode39?.dispose();
    textController45?.dispose();

    textFieldFocusNode40?.dispose();
    textController46?.dispose();

    textFieldFocusNode41?.dispose();
    textController47?.dispose();

    textFieldFocusNode42?.dispose();
    textController48?.dispose();

    textFieldFocusNode43?.dispose();
    textController49?.dispose();

    textFieldFocusNode44?.dispose();
    textController50?.dispose();

    textFieldFocusNode45?.dispose();
    textController51?.dispose();

    textFieldFocusNode46?.dispose();
    textController52?.dispose();

    textFieldFocusNode47?.dispose();
    textController53?.dispose();

    textFieldFocusNode48?.dispose();
    textController54?.dispose();

    textFieldFocusNode49?.dispose();
    textController55?.dispose();

    textFieldFocusNode50?.dispose();
    textController56?.dispose();

    textFieldFocusNode51?.dispose();
    textController57?.dispose();

    textFieldFocusNode52?.dispose();
    textController58?.dispose();

    textFieldFocusNode53?.dispose();
    textController59?.dispose();

    textFieldFocusNode54?.dispose();
    textController60?.dispose();

    textFieldFocusNode55?.dispose();
    textController61?.dispose();

    textFieldFocusNode56?.dispose();
    textController62?.dispose();

    textFieldFocusNode57?.dispose();
    textController63?.dispose();

    textFieldFocusNode58?.dispose();
    textController64?.dispose();

    textFieldFocusNode59?.dispose();
    textController65?.dispose();

    textFieldFocusNode60?.dispose();
    textController66?.dispose();

    textFieldFocusNode61?.dispose();
    textController67?.dispose();

    textFieldFocusNode62?.dispose();
    textController68?.dispose();

    textFieldFocusNode63?.dispose();
    textController69?.dispose();

    textFieldFocusNode64?.dispose();
    textController70?.dispose();

    textFieldFocusNode65?.dispose();
    textController71?.dispose();

    textFieldFocusNode66?.dispose();
    textController72?.dispose();

    textFieldFocusNode67?.dispose();
    textController73?.dispose();

    textFieldFocusNode68?.dispose();
    textController74?.dispose();

    textFieldFocusNode69?.dispose();
    textController75?.dispose();

    textFieldFocusNode70?.dispose();
    textController76?.dispose();

    textFieldFocusNode71?.dispose();
    textController77?.dispose();

    textFieldFocusNode72?.dispose();
    textController78?.dispose();

    textFieldFocusNode73?.dispose();
    textController79?.dispose();

    textFieldFocusNode74?.dispose();
    textController80?.dispose();

    textFieldFocusNode75?.dispose();
    textController81?.dispose();

    textFieldFocusNode76?.dispose();
    textController82?.dispose();

    textFieldFocusNode77?.dispose();
    textController83?.dispose();

    textFieldFocusNode78?.dispose();
    textController84?.dispose();

    textFieldFocusNode79?.dispose();
    textController85?.dispose();

    textFieldFocusNode80?.dispose();
    textController86?.dispose();

    textFieldFocusNode81?.dispose();
    textController87?.dispose();

    textFieldFocusNode82?.dispose();
    textController88?.dispose();

    textFieldFocusNode83?.dispose();
    textController89?.dispose();

    textFieldFocusNode84?.dispose();
    textController90?.dispose();

    textFieldFocusNode85?.dispose();
    textController91?.dispose();

    textFieldFocusNode86?.dispose();
    textController92?.dispose();

    textFieldFocusNode87?.dispose();
    textController93?.dispose();

    textFieldFocusNode88?.dispose();
    textController94?.dispose();

    textFieldFocusNode89?.dispose();
    textController95?.dispose();

    textFieldFocusNode90?.dispose();
    textController96?.dispose();

    textFieldFocusNode91?.dispose();
    textController97?.dispose();

    textFieldFocusNode92?.dispose();
    textController98?.dispose();

    textFieldFocusNode93?.dispose();
    textController99?.dispose();

    textFieldFocusNode94?.dispose();
    textController100?.dispose();

    textFieldFocusNode95?.dispose();
    textController101?.dispose();

    textFieldFocusNode96?.dispose();
    textController102?.dispose();

    textFieldFocusNode97?.dispose();
    textController103?.dispose();

    textFieldFocusNode98?.dispose();
    textController104?.dispose();

    textFieldFocusNode99?.dispose();
    textController105?.dispose();

    textFieldFocusNode100?.dispose();
    textController106?.dispose();

    textFieldFocusNode101?.dispose();
    textController107?.dispose();

    textFieldFocusNode102?.dispose();
    textController108?.dispose();

    textFieldFocusNode103?.dispose();
    textController109?.dispose();

    textFieldFocusNode104?.dispose();
    textController110?.dispose();

    textFieldFocusNode105?.dispose();
    textController111?.dispose();

    textFieldFocusNode106?.dispose();
    textController112?.dispose();

    textFieldFocusNode107?.dispose();
    textController113?.dispose();

    textFieldFocusNode108?.dispose();
    textController114?.dispose();

    textFieldFocusNode109?.dispose();
    textController115?.dispose();

    textFieldFocusNode110?.dispose();
    textController116?.dispose();

    textFieldFocusNode111?.dispose();
    textController117?.dispose();

    textFieldFocusNode112?.dispose();
    textController118?.dispose();

    textFieldFocusNode113?.dispose();
    textController119?.dispose();

    textFieldFocusNode114?.dispose();
    textController120?.dispose();

    textFieldFocusNode115?.dispose();
    textController121?.dispose();

    textFieldFocusNode116?.dispose();
    textController122?.dispose();

    textFieldFocusNode117?.dispose();
    textController123?.dispose();

    textFieldFocusNode118?.dispose();
    textController124?.dispose();

    textFieldFocusNode119?.dispose();
    textController125?.dispose();

    textFieldFocusNode120?.dispose();
    textController126?.dispose();

    textFieldFocusNode121?.dispose();
    textController127?.dispose();

    textFieldFocusNode122?.dispose();
    textController128?.dispose();

    textFieldFocusNode123?.dispose();
    textController129?.dispose();

    textFieldFocusNode124?.dispose();
    textController130?.dispose();

    textFieldFocusNode125?.dispose();
    textController131?.dispose();

    textFieldFocusNode126?.dispose();
    textController132?.dispose();

    textFieldFocusNode127?.dispose();
    textController133?.dispose();

    textFieldFocusNode128?.dispose();
    textController134?.dispose();

    textFieldFocusNode129?.dispose();
    textController135?.dispose();

    textFieldFocusNode130?.dispose();
    textController136?.dispose();

    textFieldFocusNode131?.dispose();
    textController137?.dispose();

    textFieldFocusNode132?.dispose();
    textController138?.dispose();

    textFieldFocusNode133?.dispose();
    textController139?.dispose();

    textFieldFocusNode134?.dispose();
    textController140?.dispose();

    textFieldFocusNode135?.dispose();
    textController141?.dispose();

    textFieldFocusNode136?.dispose();
    textController142?.dispose();

    textFieldFocusNode137?.dispose();
    textController143?.dispose();

    textFieldFocusNode138?.dispose();
    textController144?.dispose();

    textFieldFocusNode139?.dispose();
    textController145?.dispose();

    textFieldFocusNode140?.dispose();
    textController146?.dispose();

    textFieldFocusNode141?.dispose();
    textController147?.dispose();

    textFieldFocusNode142?.dispose();
    textController148?.dispose();

    textFieldFocusNode143?.dispose();
    textController149?.dispose();

    textFieldFocusNode144?.dispose();
    textController150?.dispose();

    textFieldFocusNode145?.dispose();
    textController151?.dispose();

    textFieldFocusNode146?.dispose();
    textController152?.dispose();

    textFieldFocusNode147?.dispose();
    textController153?.dispose();

    textFieldFocusNode148?.dispose();
    textController154?.dispose();

    textFieldFocusNode149?.dispose();
    textController155?.dispose();

    textFieldFocusNode150?.dispose();
    textController156?.dispose();

    textFieldFocusNode151?.dispose();
    textController157?.dispose();

    textFieldFocusNode152?.dispose();
    textController158?.dispose();

    textFieldFocusNode153?.dispose();
    textController159?.dispose();

    textFieldFocusNode154?.dispose();
    textController160?.dispose();

    textFieldFocusNode155?.dispose();
    textController161?.dispose();
  }
}
