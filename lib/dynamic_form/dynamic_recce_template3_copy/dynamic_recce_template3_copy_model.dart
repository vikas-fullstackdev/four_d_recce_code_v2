import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'dynamic_recce_template3_copy_widget.dart'
    show DynamicRecceTemplate3CopyWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DynamicRecceTemplate3CopyModel
    extends FlutterFlowModel<DynamicRecceTemplate3CopyWidget> {
  ///  Local state fields for this page.

  DynamicFieldsDataTypeStruct? localPageStateDynaicFieldVariable;
  void updateLocalPageStateDynaicFieldVariableStruct(
      Function(DynamicFieldsDataTypeStruct) updateFn) {
    updateFn(
        localPageStateDynaicFieldVariable ??= DynamicFieldsDataTypeStruct());
  }

  ///  State fields for stateful widgets in this page.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // State field(s) for IntSwitchListTile widget.
  bool? intSwitchListTileValue;
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
  // State field(s) for MepSwitchListTile widget.
  bool? mepSwitchListTileValue;
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
  // State field(s) for mep_d_a widget.
  bool? mepDAValue;
  // State field(s) for mep_d_b widget.
  bool? mepDBValue;
  // State field(s) for mep_d_c widget.
  bool? mepDCValue;
  // State field(s) for mep_eSwitch widget.
  bool? mepESwitchValue;
  // State field(s) for mep_e_a widget.
  bool? mepEAValue;
  // State field(s) for mep_e_b widget.
  bool? mepEBValue;
  // State field(s) for mep_e_c widget.
  bool? mepECValue;
  // State field(s) for mep_e_d widget.
  bool? mepEDValue;
  // State field(s) for mep_e_e widget.
  bool? mepEEValue;
  // State field(s) for mep_e_f widget.
  bool? mepEFValue;
  // State field(s) for mep_e_g widget.
  bool? mepEGValue;
  // State field(s) for mep_e_h widget.
  bool? mepEHValue;
  // State field(s) for mep_e_i widget.
  bool? mepEIValue;
  // State field(s) for mep_e_j widget.
  bool? mepEJValue;
  // State field(s) for mep_e_k widget.
  bool? mepEKValue;
  // State field(s) for mep_e_l widget.
  bool? mepELValue;
  // State field(s) for mep_e_m widget.
  bool? mepEMValue;
  // State field(s) for mep_e_n widget.
  bool? mepENValue;
  // State field(s) for mep_e_o widget.
  bool? mepEOValue;
  // State field(s) for mep_e_p widget.
  bool? mepEPValue;
  // State field(s) for mep_e_q widget.
  bool? mepEQValue;
  // State field(s) for mep_e_r widget.
  bool? mepERValue;
  // State field(s) for mep_fSwitch widget.
  bool? mepFSwitchValue;
  // State field(s) for mep_f_1Switch widget.
  bool? mepF1SwitchValue;
  // State field(s) for mep_f_1_a widget.
  bool? mepF1AValue;
  // State field(s) for mep_f_1_b widget.
  bool? mepF1BValue;
  // State field(s) for mep_f_1_c widget.
  bool? mepF1CValue;
  // State field(s) for mep_f_1_d widget.
  bool? mepF1DValue;
  // State field(s) for mep_f_1_e widget.
  bool? mepF1EValue;
  // State field(s) for mep_f_1_f widget.
  bool? mepF1FValue;
  // State field(s) for mep_f_1_g widget.
  bool? mepF1GValue;
  // State field(s) for mep_f_2Switch widget.
  bool? mepF2SwitchValue;
  // State field(s) for mep_f_2_a widget.
  bool? mepF2AValue;
  // State field(s) for mep_f_2_b widget.
  bool? mepF2BValue;
  // State field(s) for mep_f_2_c widget.
  bool? mepF2CValue;
  // State field(s) for mep_f_3Switch widget.
  bool? mepF3SwitchValue;
  // State field(s) for mep_f_3 widget.
  bool? mepF3Value;
  // State field(s) for mep_f_4Switch widget.
  bool? mepF4SwitchValue;
  // State field(s) for mep_f_4_a widget.
  bool? mepF4AValue;
  // State field(s) for mep_f_4_b widget.
  bool? mepF4BValue;
  // State field(s) for mep_f_4_c widget.
  bool? mepF4CValue;
  // State field(s) for mep_f_5Switch widget.
  bool? mepF5SwitchValue;
  // State field(s) for mep_f_5_a widget.
  bool? mepF5AValue;
  // State field(s) for mep_f_5_b widget.
  bool? mepF5BValue;
  // State field(s) for mep_f_6 widget.
  bool? mepF6Value;
  // State field(s) for mep_f_7 widget.
  bool? mepF7Value;
  // State field(s) for mep_f_8 widget.
  bool? mepF8Value;
  // State field(s) for mep_f_9 widget.
  bool? mepF9Value;
  // State field(s) for mep_f_10 widget.
  bool? mepF10Value;
  // State field(s) for mep_f_11 widget.
  bool? mepF11Value;
  // State field(s) for mep_f_12 widget.
  bool? mepF12Value;
  // State field(s) for mep_f_13 widget.
  bool? mepF13Value;
  // State field(s) for mep_f_14 widget.
  bool? mepF14Value;
  // State field(s) for mep_f_15 widget.
  bool? mepF15Value;
  // State field(s) for mep_f_16 widget.
  bool? mepF16Value;
  // State field(s) for SwitchListTile widget.
  bool? switchListTileValue9;
  // State field(s) for mep_gSwitch widget.
  bool? mepGSwitchValue;
  // State field(s) for mep_g_a widget.
  bool? mepGAValue;
  // State field(s) for mep_g_b widget.
  bool? mepGBValue;
  // State field(s) for mep_g_c widget.
  bool? mepGCValue;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
