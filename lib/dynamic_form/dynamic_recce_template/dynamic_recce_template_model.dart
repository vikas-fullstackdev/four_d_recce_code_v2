import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'dynamic_recce_template_widget.dart' show DynamicRecceTemplateWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DynamicRecceTemplateModel
    extends FlutterFlowModel<DynamicRecceTemplateWidget> {
  ///  Local state fields for this page.

  DynamicFieldsDataTypeStruct? dynamicTemplateObject;
  void updateDynamicTemplateObjectStruct(
      Function(DynamicFieldsDataTypeStruct) updateFn) {
    updateFn(dynamicTemplateObject ??= DynamicFieldsDataTypeStruct());
  }

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;
  // State field(s) for int_aSwitch widget.
  bool? intASwitchValue;
  // State field(s) for int_a1 widget.
  bool? intA1Value;
  // State field(s) for int_a2 widget.
  bool? intA2Value;
  // State field(s) for int_a3 widget.
  bool? intA3Value;
  // State field(s) for int_a4 widget.
  bool? intA4Value;
  // State field(s) for int_a5 widget.
  bool? intA5Value;
  // State field(s) for int_a6 widget.
  bool? intA6Value;
  // State field(s) for int_a7 widget.
  bool? intA7Value;
  // State field(s) for FacadeElevationSwitch widget.
  bool? facadeElevationSwitchValue;
  // State field(s) for SwitchListTile widget.
  bool? switchListTileValue1;
  // State field(s) for int_b1 widget.
  bool? intB1Value;
  // State field(s) for int_b2 widget.
  bool? intB2Value;
  // State field(s) for int_b3 widget.
  bool? intB3Value;
  // State field(s) for int_b4 widget.
  bool? intB4Value;
  // State field(s) for int_b5 widget.
  bool? intB5Value;
  // State field(s) for LiftsEscalatorsSwitch widget.
  bool? liftsEscalatorsSwitchValue;
  // State field(s) for SwitchListTile widget.
  bool? switchListTileValue2;
  // State field(s) for int_c1 widget.
  bool? intC1Value;
  // State field(s) for int_c2 widget.
  bool? intC2Value;
  // State field(s) for int_c3 widget.
  bool? intC3Value;
  // State field(s) for int_c4 widget.
  bool? intC4Value;
  // State field(s) for StaircaseSwitch widget.
  bool? staircaseSwitchValue;
  // State field(s) for int_d1 widget.
  bool? intD1Value;
  // State field(s) for int_d2 widget.
  bool? intD2Value;
  // State field(s) for int_d3 widget.
  bool? intD3Value;
  // State field(s) for SwitchListTile widget.
  bool? switchListTileValue3;
  // State field(s) for SwitchListTile widget.
  bool? switchListTileValue4;
  // State field(s) for SwitchListTile widget.
  bool? switchListTileValue5;
  // State field(s) for SwitchListTile widget.
  bool? switchListTileValue6;
  // State field(s) for SwitchListTile widget.
  bool? switchListTileValue7;
  // State field(s) for STRUCTURALDATASwitch widget.
  bool? sTRUCTURALDATASwitchValue;
  // State field(s) for int_e1 widget.
  bool? intE1Value;
  // State field(s) for int_e2 widget.
  bool? intE2Value;
  // State field(s) for int_e3 widget.
  bool? intE3Value;
  // State field(s) for int_e4 widget.
  bool? intE4Value;
  // State field(s) for int_e5 widget.
  bool? intE5Value;
  // State field(s) for int_e6 widget.
  bool? intE6Value;
  // State field(s) for int_e7 widget.
  bool? intE7Value;
  // State field(s) for int_e8 widget.
  bool? intE8Value;
  // State field(s) for int_e9 widget.
  bool? intE9Value;
  // State field(s) for int_e10 widget.
  bool? intE10Value;
  // State field(s) for int_e11 widget.
  bool? intE11Value;
  // State field(s) for int_e12 widget.
  bool? intE12Value;
  // State field(s) for int_e13 widget.
  bool? intE13Value;
  // State field(s) for int_e14 widget.
  bool? intE14Value;
  // State field(s) for CIVILWORKSINTERIORSwitch widget.
  bool? cIVILWORKSINTERIORSwitchValue;
  // State field(s) for int_f1 widget.
  bool? intF1Value;
  // State field(s) for int_f2 widget.
  bool? intF2Value;
  // State field(s) for int_f3 widget.
  bool? intF3Value;
  // State field(s) for int_f4 widget.
  bool? intF4Value;
  // State field(s) for int_f5 widget.
  bool? intF5Value;
  // State field(s) for PLUMBINGWORKSSwitch widget.
  bool? pLUMBINGWORKSSwitchValue;
  // State field(s) for int_g1 widget.
  bool? intG1Value;
  // State field(s) for int_g2 widget.
  bool? intG2Value;
  // State field(s) for int_g3 widget.
  bool? intG3Value;
  // State field(s) for int_g4 widget.
  bool? intG4Value;
  // State field(s) for int_g5 widget.
  bool? intG5Value;
  // State field(s) for MEPBasicInformationSwitch widget.
  bool? mEPBasicInformationSwitchValue;
  // State field(s) for mep_a1 widget.
  bool? mepA1Value;
  // State field(s) for mep_a2 widget.
  bool? mepA2Value;
  // State field(s) for MEPELECTRICALWORKSSwitch widget.
  bool? mEPELECTRICALWORKSSwitchValue;
  // State field(s) for MEPElectricalBoardSupplySwitch widget.
  bool? mEPElectricalBoardSupplySwitchValue;
  // State field(s) for mep_b_1_a widget.
  bool? mepB1AValue;
  // State field(s) for mep_b_1_b widget.
  bool? mepB1BValue;
  // State field(s) for mep_b_1_c widget.
  bool? mepB1CValue;
  // State field(s) for mep_b_1_d widget.
  bool? mepB1DValue;
  // State field(s) for mep_b_1_e widget.
  bool? mepB1EValue;
  // State field(s) for mep_b_1_f widget.
  bool? mepB1FValue;
  // State field(s) for mep_b_1_g widget.
  bool? mepB1GValue;
  // State field(s) for mep_b_1_h widget.
  bool? mepB1HValue;
  // State field(s) for MEPDGSupplySwitch widget.
  bool? mEPDGSupplySwitchValue;
  // State field(s) for mep_b_2_a widget.
  bool? mepB2AValue;
  // State field(s) for mep_b_2_b widget.
  bool? mepB2BValue;
  // State field(s) for mep_b_2_c widget.
  bool? mepB2CValue;
  // State field(s) for mep_b_2_d widget.
  bool? mepB2DValue;
  // State field(s) for mep_b_2_e widget.
  bool? mepB2EValue;
  // State field(s) for mep_b_2_f widget.
  bool? mepB2FValue;
  // State field(s) for MEPExistingSetupSwitch widget.
  bool? mEPExistingSetupSwitchValue;
  // State field(s) for mep_b_3 widget.
  bool? mepB3Value;
  // State field(s) for MEPPowerFactorcorrectionSwitch widget.
  bool? mEPPowerFactorcorrectionSwitchValue;
  // State field(s) for mep_b_4 widget.
  bool? mepB4Value;
  // State field(s) for MEPEarthingSwitch widget.
  bool? mEPEarthingSwitchValue;
  // State field(s) for mep_b_5_a widget.
  bool? mepB5AValue;
  // State field(s) for mep_b_5_b widget.
  bool? mepB5BValue;
  // State field(s) for MEPTypeofconduitsprovidedSwitch widget.
  bool? mEPTypeofconduitsprovidedSwitchValue;
  // State field(s) for mep_b_6 widget.
  bool? mepB6Value;
  // State field(s) for MEPRequiredDocumentsfromBaseBuilderSwitch widget.
  bool? mEPRequiredDocumentsfromBaseBuilderSwitchValue;
  // State field(s) for mep_b_7_a widget.
  bool? mepB7AValue;
  // State field(s) for mep_b_7_b widget.
  bool? mepB7BValue;
  // State field(s) for mep_cSwitch widget.
  bool? mepCSwitchValue;
  // State field(s) for mep_c_1Switch widget.
  bool? mepC1SwitchValue;
  // State field(s) for mep_c_1_a widget.
  bool? mepC1AValue;
  // State field(s) for mep_c_1_b widget.
  bool? mepC1BValue;
  // State field(s) for mep_c_1_c widget.
  bool? mepC1CValue;
  // State field(s) for mep_c_1_d widget.
  bool? mepC1DValue;
  // State field(s) for mep_c_1_e widget.
  bool? mepC1EValue;
  // State field(s) for mep_c_1_f widget.
  bool? mepC1FValue;
  // State field(s) for mep_c_1_g widget.
  bool? mepC1GValue;
  // State field(s) for mep_c_1_h widget.
  bool? mepC1HValue;
  // State field(s) for mep_c_1_i widget.
  bool? mepC1IValue;
  // State field(s) for mep_c_2Switch widget.
  bool? mepC2SwitchValue;
  // State field(s) for mep_c_2_a widget.
  bool? mepC2AValue;
  // State field(s) for mep_c_2_b widget.
  bool? mepC2BValue;
  // State field(s) for mep_c_2_c widget.
  bool? mepC2CValue;
  // State field(s) for mep_c_2_d widget.
  bool? mepC2DValue;
  // State field(s) for mep_c_2_e widget.
  bool? mepC2EValue;
  // State field(s) for mep_c_2_f widget.
  bool? mepC2FValue;
  // State field(s) for mep_c_2_g widget.
  bool? mepC2GValue;
  // State field(s) for mep_c_3Switch widget.
  bool? mepC3SwitchValue;
  // State field(s) for mep_c_3_a widget.
  bool? mepC3AValue;
  // State field(s) for mep_c_3_b widget.
  bool? mepC3BValue;
  // State field(s) for mep_c_3_c widget.
  bool? mepC3CValue;
  // State field(s) for mep_c_3_d widget.
  bool? mepC3DValue;
  // State field(s) for mep_c_3_e widget.
  bool? mepC3EValue;
  // State field(s) for mep_c_3_f widget.
  bool? mepC3FValue;
  // State field(s) for mep_c_3_g widget.
  bool? mepC3GValue;
  // State field(s) for mep_c_3_h widget.
  bool? mepC3HValue;
  // State field(s) for mep_c_3_i widget.
  bool? mepC3IValue;
  // State field(s) for mep_c_3_j widget.
  bool? mepC3JValue;
  // State field(s) for mep_c_3_k widget.
  bool? mepC3KValue;
  // State field(s) for mep_c_3_l widget.
  bool? mepC3LValue;
  // State field(s) for mep_c_4Switch widget.
  bool? mepC4SwitchValue1;
  // State field(s) for mep_c_4_a widget.
  bool? mepC4AValue;
  // State field(s) for mep_c_4_b widget.
  bool? mepC4BValue;
  // State field(s) for mep_c_4_c widget.
  bool? mepC4CValue;
  // State field(s) for mep_c_4_d widget.
  bool? mepC4DValue;
  // State field(s) for mep_c_4_e widget.
  bool? mepC4EValue;
  // State field(s) for mep_c_4_f widget.
  bool? mepC4FValue;
  // State field(s) for mep_c_5Switch widget.
  bool? mepC5SwitchValue;
  // State field(s) for mep_c_5_a widget.
  bool? mepC5AValue1;
  // State field(s) for mep_c_5_b widget.
  bool? mepC5BValue1;
  // State field(s) for mep_c_5_c widget.
  bool? mepC5CValue1;
  // State field(s) for mep_c_5_d widget.
  bool? mepC5DValue1;
  // State field(s) for mep_c_5_e widget.
  bool? mepC5EValue1;
  // State field(s) for mep_c_5_f widget.
  bool? mepC5FValue1;
  // State field(s) for mep_c_5_g widget.
  bool? mepC5GValue1;
  // State field(s) for mep_c_5_h widget.
  bool? mepC5HValue1;
  // State field(s) for mep_c_5_i widget.
  bool? mepC5IValue1;
  // State field(s) for mep_c_5_j widget.
  bool? mepC5JValue1;
  // State field(s) for mep_c_5_k widget.
  bool? mepC5KValue1;
  // State field(s) for mep_c_5_a widget.
  bool? mepC5AValue2;
  // State field(s) for mep_c_5_b widget.
  bool? mepC5BValue2;
  // State field(s) for mep_c_5_c widget.
  bool? mepC5CValue2;
  // State field(s) for mep_c_5_d widget.
  bool? mepC5DValue2;
  // State field(s) for mep_c_5_e widget.
  bool? mepC5EValue2;
  // State field(s) for mep_c_5_f widget.
  bool? mepC5FValue2;
  // State field(s) for mep_c_5_g widget.
  bool? mepC5GValue2;
  // State field(s) for mep_c_5_h widget.
  bool? mepC5HValue2;
  // State field(s) for mep_c_5_i widget.
  bool? mepC5IValue2;
  // State field(s) for mep_c_5_j widget.
  bool? mepC5JValue2;
  // State field(s) for mep_c_5_k widget.
  bool? mepC5KValue2;
  // State field(s) for mep_c_4Switch widget.
  bool? mepC4SwitchValue2;
  // State field(s) for SwitchListTile widget.
  bool? switchListTileValue8;
  // State field(s) for mep_c_4Switch widget.
  bool? mepC4SwitchValue3;
  // State field(s) for mep_dSwitch widget.
  bool? mepDSwitchValue;
  // State field(s) for SwitchListTile widget.
  bool? switchListTileValue9;
  // State field(s) for SwitchListTile widget.
  bool? switchListTileValue10;
  // State field(s) for SwitchListTile widget.
  bool? switchListTileValue11;
  // State field(s) for mep_eSwitch widget.
  bool? mepESwitchValue;
  // State field(s) for SwitchListTile widget.
  bool? switchListTileValue12;
  // State field(s) for SwitchListTile widget.
  bool? switchListTileValue13;
  // State field(s) for SwitchListTile widget.
  bool? switchListTileValue14;
  // State field(s) for SwitchListTile widget.
  bool? switchListTileValue15;
  // State field(s) for SwitchListTile widget.
  bool? switchListTileValue16;
  // State field(s) for SwitchListTile widget.
  bool? switchListTileValue17;
  // State field(s) for SwitchListTile widget.
  bool? switchListTileValue18;
  // State field(s) for SwitchListTile widget.
  bool? switchListTileValue19;
  // State field(s) for SwitchListTile widget.
  bool? switchListTileValue20;
  // State field(s) for SwitchListTile widget.
  bool? switchListTileValue21;
  // State field(s) for SwitchListTile widget.
  bool? switchListTileValue22;
  // State field(s) for SwitchListTile widget.
  bool? switchListTileValue23;
  // State field(s) for SwitchListTile widget.
  bool? switchListTileValue24;
  // State field(s) for SwitchListTile widget.
  bool? switchListTileValue25;
  // State field(s) for SwitchListTile widget.
  bool? switchListTileValue26;
  // State field(s) for SwitchListTile widget.
  bool? switchListTileValue27;
  // State field(s) for SwitchListTile widget.
  bool? switchListTileValue28;
  // State field(s) for mep_fSwitch widget.
  bool? mepFSwitchValue;
  // State field(s) for mep_f_1Switch widget.
  bool? mepF1SwitchValue;
  // State field(s) for SwitchListTile widget.
  bool? switchListTileValue29;
  // State field(s) for SwitchListTile widget.
  bool? switchListTileValue30;
  // State field(s) for SwitchListTile widget.
  bool? switchListTileValue31;
  // State field(s) for SwitchListTile widget.
  bool? switchListTileValue32;
  // State field(s) for SwitchListTile widget.
  bool? switchListTileValue33;
  // State field(s) for SwitchListTile widget.
  bool? switchListTileValue34;
  // State field(s) for SwitchListTile widget.
  bool? switchListTileValue35;
  // State field(s) for mep_f_2Switch widget.
  bool? mepF2SwitchValue;
  // State field(s) for SwitchListTile widget.
  bool? switchListTileValue36;
  // State field(s) for SwitchListTile widget.
  bool? switchListTileValue37;
  // State field(s) for SwitchListTile widget.
  bool? switchListTileValue38;
  // State field(s) for mep_f_3Switch widget.
  bool? mepF3SwitchValue;
  // State field(s) for SwitchListTile widget.
  bool? switchListTileValue39;
  // State field(s) for mep_f_4Switch widget.
  bool? mepF4SwitchValue;
  // State field(s) for SwitchListTile widget.
  bool? switchListTileValue40;
  // State field(s) for SwitchListTile widget.
  bool? switchListTileValue41;
  // State field(s) for SwitchListTile widget.
  bool? switchListTileValue42;
  // State field(s) for mep_f_5Switch widget.
  bool? mepF5SwitchValue;
  // State field(s) for SwitchListTile widget.
  bool? switchListTileValue43;
  // State field(s) for SwitchListTile widget.
  bool? switchListTileValue44;
  // State field(s) for SwitchListTile widget.
  bool? switchListTileValue45;
  // State field(s) for SwitchListTile widget.
  bool? switchListTileValue46;
  // State field(s) for SwitchListTile widget.
  bool? switchListTileValue47;
  // State field(s) for SwitchListTile widget.
  bool? switchListTileValue48;
  // State field(s) for SwitchListTile widget.
  bool? switchListTileValue49;
  // State field(s) for SwitchListTile widget.
  bool? switchListTileValue50;
  // State field(s) for SwitchListTile widget.
  bool? switchListTileValue51;
  // State field(s) for SwitchListTile widget.
  bool? switchListTileValue52;
  // State field(s) for SwitchListTile widget.
  bool? switchListTileValue53;
  // State field(s) for SwitchListTile widget.
  bool? switchListTileValue54;
  // State field(s) for SwitchListTile widget.
  bool? switchListTileValue55;
  // State field(s) for SwitchListTile widget.
  bool? switchListTileValue56;
  // State field(s) for mep_gSwitch widget.
  bool? mepGSwitchValue;
  // State field(s) for SwitchListTile widget.
  bool? switchListTileValue57;
  // State field(s) for SwitchListTile widget.
  bool? switchListTileValue58;
  // State field(s) for SwitchListTile widget.
  bool? switchListTileValue59;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
