// import '/auth/supabase_auth/auth_util.dart';
// import '/backend/api_requests/api_calls.dart';
// import '/backend/supabase/supabase.dart';
// import '/flutter_flow/flutter_flow_icon_button.dart';
// import '/flutter_flow/flutter_flow_theme.dart';
// import '/flutter_flow/flutter_flow_timer.dart';
// import '/flutter_flow/flutter_flow_util.dart';
// import '/flutter_flow/flutter_flow_widgets.dart';
// import 'dart:ui';
// import '/custom_code/actions/index.dart' as actions;
// import '/index.dart';
// import 'package:stop_watch_timer/stop_watch_timer.dart';
// import 'rece_template_widget.dart' show ReceTemplateWidget;
// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
// import 'dart:convert';

// class PhotoController {
//   final TextEditingController textController = TextEditingController();
//   String? imageUrl;
//   Map<String, dynamic> toMap() => {
//         'text': textController.text,
//         'imageUrl': imageUrl,
//       };
//   void dispose() {
//     textController.dispose();
//   }
// }

// class ReceTemplateModel extends ChangeNotifier {
//   // Form key
//   final formKey = GlobalKey<FormState>();

//   // --- A. HVAC DETAILS ---
//   // A1 Mall
//   String? a1_ahu_exists;
//   String? a1_use_ahu;
//   final PhotoController a1_ahu_location = PhotoController();
//   String? a1_chilled_tapoff_exists;
//   final PhotoController a1_chilled_tapoff_location = PhotoController();
//   final TextEditingController a1_chilled_pipe_height = TextEditingController();
//   final PhotoController a1_chilled_pipe_photo = PhotoController();
//   String? a1_hvac_drain_exists;
//   final PhotoController a1_hvac_drain_location = PhotoController();
//   final TextEditingController a1_hvac_drain_height = TextEditingController();
//   String? a1_fresh_air_provided;
//   String? a1_fresh_air_type;
//   final PhotoController a1_fresh_air_location = PhotoController();
//   final TextEditingController a1_fresh_air_height = TextEditingController();
//   String? a1_exhaust_provided;
//   String? a1_exhaust_type;
//   final PhotoController a1_exhaust_location = PhotoController();
//   final TextEditingController a1_exhaust_height = TextEditingController();

//   // A2 Hi-street
//   String? a2_ac_units_exist;
//   String? a2_use_existing_units;
//   final PhotoController a2_odu_locations = PhotoController();
//   final TextEditingController a2_odu_distance = TextEditingController();
//   final PhotoController a2_ac_drain_location = PhotoController();

//   // A3 Common
//   Map<String, String> a3_surroundings = {
//     'Below Floor': 'AC',
//     'Above Floor': 'AC',
//     'Left Side': 'AC',
//     'Right Side': 'AC',
//     'Back Side': 'AC',
//     'Front': 'AC',
//   };
//   String? a3_structural_glazing;
//   String? a3_glazing_exposed;

//   // --- B. ELECTRICAL DETAILS ---
//   String? b_power_supply_exists;
//   final PhotoController b_power_supply_location = PhotoController();
//   final PhotoController b_electrical_load_provision = PhotoController();
//   String? b_power_cable_type;
//   String? b_power_for_lift_provision;
//   String? b_power_cable_details_for_lift;

//   // B1 DG
//   String? b1_dg_exists;
//   String? b1_dg_dedicated_shared;
//   final PhotoController b1_dg_location = PhotoController();
//   final PhotoController b1_dg_load_provision = PhotoController();
//   final TextEditingController b1_dg_backup_hours = TextEditingController();
//   String? b1_dg_changeover_type;

//   // B2 Earthing
//   String? b2_earthing_dedicated;
//   final PhotoController b2_earthpit_location = PhotoController();

//   // --- C. SPRINKLER DETAILS ---
//   String? c_sprinkler_exists;
//   String? c_sprinkler_type;
//   final PhotoController c_sprinkler_tapoff_location = PhotoController();
//   final TextEditingController c_sprinkler_pipe_height = TextEditingController();
//   final PhotoController c_sprinkler_pipe_photo = PhotoController();

//   // --- D. FAS DETAILS ---
//   String? d_fas_exists;
//   String? d_smoke_detector_type;
//   final PhotoController d_fas_panel_location = PhotoController();
//   final TextEditingController d_fas_panel_make = TextEditingController();
//   String? d_fas_panel_type;

//   // --- E. PLUMBING & DRAINAGE ---
//   String? e_plumbing_exists;
//   final PhotoController e_plumbing_location = PhotoController();
//   String? e_toilet_exists;
//   final PhotoController e_proposed_toilet_locations = PhotoController();
//   String? e_core_cuts_allowed;
//   String? e_dedicated_water_tank;

//   // --- F. FIRE HYDRANT DETAILS ---
//   String? f_fire_hydrant_exists;
//   final PhotoController f_fire_hydrant_locations = PhotoController();

//   // small runtime flag used when building JSON payloads
//   bool isDeviceOnlineTimer = true;

//   ReceTemplateModel();

//   String? validateNotEmpty(String? v) {
//     if (v == null || v.trim().isEmpty) return 'Required';
//     return null;
//   }

//   String? validateNumber(String? v) {
//     if (v == null || v.trim().isEmpty) return 'Required';
//     final n = num.tryParse(v.trim());
//     if (n == null) return 'Enter a valid number';
//     return null;
//   }

//   Map<String, dynamic> getFormJson() {
//     return {
//       'A_HVAC': {
//         'A1_MALL_PROPERTY': {
//           'AHU_exists': a1_ahu_exists,
//           'Can_use_AHU': a1_use_ahu,
//           'AHU_location': a1_ahu_location.toMap(),
//           'Chilled_tapoff_exists': a1_chilled_tapoff_exists,
//           'Chilled_tapoff_location': a1_chilled_tapoff_location.toMap(),
//           'Chilled_water_pipe_height': {
//             'height': a1_chilled_pipe_height.text,
//             'photo': a1_chilled_pipe_photo.toMap(),
//           },
//           'HVAC_drain_exists': a1_hvac_drain_exists,
//           'HVAC_drain_location': a1_hvac_drain_location.toMap(),
//           'HVAC_drain_height': a1_hvac_drain_height.text,
//           'Fresh_air_provided': a1_fresh_air_provided,
//           'Fresh_air_type': a1_fresh_air_type,
//           'Fresh_air_location': a1_fresh_air_location.toMap(),
//           'Fresh_air_height': a1_fresh_air_height.text,
//           'Exhaust_provided': a1_exhaust_provided,
//           'Exhaust_type': a1_exhaust_type,
//           'Exhaust_location': a1_exhaust_location.toMap(),
//           'Exhaust_height': a1_exhaust_height.text,
//         },
//         'A2_HI_STREET': {
//           'AC_units_exist': a2_ac_units_exist,
//           'Can_use_existing_units': a2_use_existing_units,
//           'ODU_locations': a2_odu_locations.toMap(),
//           'ODU_distance': a2_odu_distance.text,
//           'AC_drain_location': a2_ac_drain_location.toMap(),
//         },
//         'A3_COMMON_POINTS': {
//           'Store_Surroundings': a3_surroundings,
//           'Structural_glazing': a3_structural_glazing,
//           'Glazing_exposed_to_sun': a3_glazing_exposed,
//         }
//       },
//       'B_ELECTRICAL': {
//         'Power_supply_exists': b_power_supply_exists,
//         'Power_supply_location': b_power_supply_location.toMap(),
//         'Electrical_load_provision': b_electrical_load_provision.toMap(),
//         'Power_cable_type': b_power_cable_type,
//         'Power_for_lift_provision': b_power_for_lift_provision,
//         'Power_cable_details_for_lift': b_power_cable_details_for_lift,
//         'DG_SUPPLY': {
//           'DG_exists': b1_dg_exists,
//           'DG_dedicated_shared': b1_dg_dedicated_shared,
//           'DG_location': b1_dg_location.toMap(),
//           'DG_load_provision': b1_dg_load_provision.toMap(),
//           'DG_backup_hours': b1_dg_backup_hours.text,
//           'DG_changeover_type': b1_dg_changeover_type,
//         },
//         'EARTHING': {
//           'Dedicated_earthing': b2_earthing_dedicated,
//           'Earthpit_location': b2_earthpit_location.toMap(),
//         }
//       },
//       'C_SPRINKLER': {
//         'Sprinkler_exists': c_sprinkler_exists,
//         'Sprinkler_type': c_sprinkler_type,
//         'Sprinkler_tapoff_location': c_sprinkler_tapoff_location.toMap(),
//         'Sprinkler_pipe_height': {
//           'height': c_sprinkler_pipe_height.text,
//           'photo': c_sprinkler_pipe_photo.toMap(),
//         }
//       },
//       'D_FAS': {
//         'FAS_exists': d_fas_exists,
//         'Smoke_detector_type': d_smoke_detector_type,
//         'FAS_panel_location': d_fas_panel_location.toMap(),
//         'FAS_panel_make': d_fas_panel_make.text,
//         'FAS_panel_type': d_fas_panel_type,
//       },
//       'E_PLUMBING_DRAINAGE': {
//         'Plumbing_exists': e_plumbing_exists,
//         'Plumbing_location': e_plumbing_location.toMap(),
//         'Toilet_exists': e_toilet_exists,
//         'Proposed_toilet_locations': e_proposed_toilet_locations.toMap(),
//         'Core_cuts_allowed': e_core_cuts_allowed,
//         'Dedicated_water_tank': e_dedicated_water_tank,
//       },
//       'F_FIRE_HYDRANT': {
//         'Fire_hydrant_exists': f_fire_hydrant_exists,
//         'Fire_hydrant_locations': f_fire_hydrant_locations.toMap(),
//       },
//       'meta': {
//         'savedAt': DateTime.now().toIso8601String(),
//         'offline': !isDeviceOnlineTimer,
//       }
//     };
//   }

//   Future<String> saveForm() async {
//     final state = formKey.currentState;
//     if (state == null) throw Exception('Form not mounted');
//     if (!state.validate()) throw Exception('Validation failed');
//     final Map<String, dynamic> map = getFormJson();
//     final jsonString = jsonEncode(map);
//     // placeholder: send to backend or store locally
//     await Future.delayed(const Duration(milliseconds: 200));
//     notifyListeners();
//     return jsonString;
//   }

//   @override
//   void dispose() {
//     // dispose all controllers
//     a1_ahu_location.dispose();
//     a1_chilled_tapoff_location.dispose();
//     a1_chilled_pipe_height.dispose();
//     a1_chilled_pipe_photo.dispose();
//     a1_hvac_drain_location.dispose();
//     a1_hvac_drain_height.dispose();
//     a1_fresh_air_location.dispose();
//     a1_fresh_air_height.dispose();
//     a1_exhaust_location.dispose();
//     a1_exhaust_height.dispose();

//     a2_odu_locations.dispose();
//     a2_odu_distance.dispose();
//     a2_ac_drain_location.dispose();

//     c_sprinkler_tapoff_location.dispose();
//     c_sprinkler_pipe_height.dispose();
//     c_sprinkler_pipe_photo.dispose();

//     d_fas_panel_location.dispose();
//     d_fas_panel_make.dispose();

//     e_plumbing_location.dispose();
//     e_proposed_toilet_locations.dispose();

//     b_power_supply_location.dispose();
//     b_electrical_load_provision.dispose();
//     b1_dg_location.dispose();
//     b1_dg_load_provision.dispose();
//     b1_dg_backup_hours.dispose();
//     b2_earthpit_location.dispose();
//     f_fire_hydrant_locations.dispose();

//     super.dispose();
//   }
// // }

// import '/auth/supabase_auth/auth_util.dart';
// import '/backend/api_requests/api_calls.dart';
// import '/backend/supabase/supabase.dart';
// import '/flutter_flow/flutter_flow_icon_button.dart';
// import '/flutter_flow/flutter_flow_theme.dart';
// import '/flutter_flow/flutter_flow_timer.dart';
// import '/flutter_flow/flutter_flow_util.dart';
// import '/flutter_flow/flutter_flow_widgets.dart';
// import 'dart:ui';
// import '/custom_code/actions/index.dart' as actions;
// import '/index.dart';
// import 'package:stop_watch_timer/stop_watch_timer.dart';
// import 'rece_template_widget.dart' show ReceTemplateWidget;
// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
// import 'dart:convert';
// import 'dart:async';

// class PhotoController {
//   final TextEditingController textController = TextEditingController();
//   String? imageUrl;
//   Map<String, dynamic> toMap() => {
//         'text': textController.text,
//         'imageUrl': imageUrl,
//       };
//   void dispose() {
//     textController.dispose();
//   }
// }

// class ReceTemplateModel extends ChangeNotifier {
//   // Form key
//   final formKey = GlobalKey<FormState>();

//   // --- A. HVAC DETAILS ---
//   String? a1_ahu_exists;
//   String? a1_use_ahu;
//   final PhotoController a1_ahu_location = PhotoController();
//   String? a1_chilled_tapoff_exists;
//   final PhotoController a1_chilled_tapoff_location = PhotoController();
//   final TextEditingController a1_chilled_pipe_height = TextEditingController();
//   final PhotoController a1_chilled_pipe_photo = PhotoController();
//   String? a1_hvac_drain_exists;
//   final PhotoController a1_hvac_drain_location = PhotoController();
//   final TextEditingController a1_hvac_drain_height = TextEditingController();
//   String? a1_fresh_air_provided;
//   String? a1_fresh_air_type;
//   final PhotoController a1_fresh_air_location = PhotoController();
//   final TextEditingController a1_fresh_air_height = TextEditingController();
//   String? a1_exhaust_provided;
//   String? a1_exhaust_type;
//   final PhotoController a1_exhaust_location = PhotoController();
//   final TextEditingController a1_exhaust_height = TextEditingController();

//   // A2 Hi-street
//   String? a2_ac_units_exist;
//   String? a2_use_existing_units;
//   final PhotoController a2_odu_locations = PhotoController();
//   final TextEditingController a2_odu_distance = TextEditingController();
//   final PhotoController a2_ac_drain_location = PhotoController();

//   // A3 Common
//   Map<String, String> a3_surroundings = {
//     'Below Floor': 'AC',
//     'Above Floor': 'AC',
//     'Left Side': 'AC',
//     'Right Side': 'AC',
//     'Back Side': 'AC',
//     'Front': 'AC',
//   };
//   String? a3_structural_glazing;
//   String? a3_glazing_exposed;

//   // --- B. ELECTRICAL DETAILS ---
//   String? b_power_supply_exists;
//   final PhotoController b_power_supply_location = PhotoController();
//   final PhotoController b_electrical_load_provision = PhotoController();
//   String? b_power_cable_type;
//   String? b_power_for_lift_provision;
//   String? b_power_cable_details_for_lift;

//   // B1 DG
//   String? b1_dg_exists;
//   String? b1_dg_dedicated_shared;
//   final PhotoController b1_dg_location = PhotoController();
//   final PhotoController b1_dg_load_provision = PhotoController();
//   final TextEditingController b1_dg_backup_hours = TextEditingController();
//   String? b1_dg_changeover_type;

//   // B2 Earthing
//   String? b2_earthing_dedicated;
//   final PhotoController b2_earthpit_location = PhotoController();

//   // --- C. SPRINKLER DETAILS ---
//   String? c_sprinkler_exists;
//   String? c_sprinkler_type;
//   final PhotoController c_sprinkler_tapoff_location = PhotoController();
//   final TextEditingController c_sprinkler_pipe_height = TextEditingController();
//   final PhotoController c_sprinkler_pipe_photo = PhotoController();

//   // --- D. FAS DETAILS ---
//   String? d_fas_exists;
//   String? d_smoke_detector_type;
//   final PhotoController d_fas_panel_location = PhotoController();
//   final TextEditingController d_fas_panel_make = TextEditingController();
//   String? d_fas_panel_type;

//   // --- E. PLUMBING & DRAINAGE ---
//   String? e_plumbing_exists;
//   final PhotoController e_plumbing_location = PhotoController();
//   String? e_toilet_exists;
//   final PhotoController e_proposed_toilet_locations = PhotoController();
//   String? e_core_cuts_allowed;
//   String? e_dedicated_water_tank;

//   // --- F. FIRE HYDRANT DETAILS ---
//   String? f_fire_hydrant_exists;
//   final PhotoController f_fire_hydrant_locations = PhotoController();

//   // --- TIMER & ONLINE STATUS ---
//   bool isDeviceOnlineTImer = true;
//   Timer? _timer;
//   int _seconds = 0;
//   String get timerValue {
//     final minutes = (_seconds ~/ 60).toString().padLeft(2, '0');
//     final seconds = (_seconds % 60).toString().padLeft(2, '0');
//     return '$minutes:$seconds';
//   }

//   ReceTemplateModel() {
//     startTimer();
//     checkDeviceOnline();
//   }

//   void startTimer() {
//     _timer?.cancel();
//     _timer = Timer.periodic(const Duration(seconds: 1), (_) {
//       _seconds++;
//       notifyListeners();
//     });
//   }

//   void stopTimer() {
//     _timer?.cancel();
//   }

//   void checkDeviceOnline() {
//     // Replace with real online check
//     isDeviceOnlineTImer = !isDeviceOnlineTImer;
//     notifyListeners();
//   }

//   String? validateNotEmpty(String? v) {
//     if (v == null || v.trim().isEmpty) return 'Required';
//     return null;
//   }

//   String? validateNumber(String? v) {
//     if (v == null || v.trim().isEmpty) return 'Required';
//     final n = num.tryParse(v.trim());
//     if (n == null) return 'Enter a valid number';
//     return null;
//   }

//   Map<String, dynamic> getFormJson() {
//     return {
//       'A_HVAC': {
//         'A1_MALL_PROPERTY': {
//           'AHU_exists': a1_ahu_exists,
//           'Can_use_AHU': a1_use_ahu,
//           'AHU_location': a1_ahu_location.toMap(),
//           'Chilled_tapoff_exists': a1_chilled_tapoff_exists,
//           'Chilled_tapoff_location': a1_chilled_tapoff_location.toMap(),
//           'Chilled_water_pipe_height': {
//             'height': a1_chilled_pipe_height.text,
//             'photo': a1_chilled_pipe_photo.toMap(),
//           },
//           'HVAC_drain_exists': a1_hvac_drain_exists,
//           'HVAC_drain_location': a1_hvac_drain_location.toMap(),
//           'HVAC_drain_height': a1_hvac_drain_height.text,
//           'Fresh_air_provided': a1_fresh_air_provided,
//           'Fresh_air_type': a1_fresh_air_type,
//           'Fresh_air_location': a1_fresh_air_location.toMap(),
//           'Fresh_air_height': a1_fresh_air_height.text,
//           'Exhaust_provided': a1_exhaust_provided,
//           'Exhaust_type': a1_exhaust_type,
//           'Exhaust_location': a1_exhaust_location.toMap(),
//           'Exhaust_height': a1_exhaust_height.text,
//         },
//         'A2_HI_STREET': {
//           'AC_units_exist': a2_ac_units_exist,
//           'Can_use_existing_units': a2_use_existing_units,
//           'ODU_locations': a2_odu_locations.toMap(),
//           'ODU_distance': a2_odu_distance.text,
//           'AC_drain_location': a2_ac_drain_location.toMap(),
//         },
//         'A3_COMMON_POINTS': {
//           'Store_Surroundings': a3_surroundings,
//           'Structural_glazing': a3_structural_glazing,
//           'Glazing_exposed_to_sun': a3_glazing_exposed,
//         }
//       },
//       // ... Keep your B, C, D, E, F sections as-is
//       'meta': {
//         'savedAt': DateTime.now().toIso8601String(),
//         'offline': !isDeviceOnlineTImer,
//       }
//     };
//   }

//   Future<String> saveForm() async {
//     final state = formKey.currentState;
//     if (state == null) throw Exception('Form not mounted');
//     if (!state.validate()) throw Exception('Validation failed');
//     final Map<String, dynamic> map = getFormJson();
//     final jsonString = jsonEncode(map);
//     await Future.delayed(const Duration(milliseconds: 200));
//     notifyListeners();
//     return jsonString;
//   }

//   @override
//   void dispose() {
//     a1_ahu_location.dispose();
//     a1_chilled_tapoff_location.dispose();
//     a1_chilled_pipe_height.dispose();
//     a1_chilled_pipe_photo.dispose();
//     a1_hvac_drain_location.dispose();
//     a1_hvac_drain_height.dispose();
//     a1_fresh_air_location.dispose();
//     a1_fresh_air_height.dispose();
//     a1_exhaust_location.dispose();
//     a1_exhaust_height.dispose();

//     a2_odu_locations.dispose();
//     a2_odu_distance.dispose();
//     a2_ac_drain_location.dispose();

//     c_sprinkler_tapoff_location.dispose();
//     c_sprinkler_pipe_height.dispose();
//     c_sprinkler_pipe_photo.dispose();

//     d_fas_panel_location.dispose();
//     d_fas_panel_make.dispose();

//     e_plumbing_location.dispose();
//     e_proposed_toilet_locations.dispose();

//     b_power_supply_location.dispose();
//     b_electrical_load_provision.dispose();
//     b1_dg_location.dispose();
//     b1_dg_load_provision.dispose();
//     b1_dg_backup_hours.dispose();
//     b2_earthpit_location.dispose();
//     f_fire_hydrant_locations.dispose();

//     _timer?.cancel();

//     super.dispose();
//   }
// }




import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_timer.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'rece_template_widget.dart' show ReceTemplateWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'dart:async';
import 'package:file_picker/file_picker.dart';

class PhotoController {
  final TextEditingController textController = TextEditingController();
  String? imageUrl;

  Map<String, dynamic> toMap() => {
        'text': textController.text,
        'imageUrl': imageUrl,
      };

  void dispose() {
    textController.dispose();
  }

  Future<void> pickImage() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null && result.files.isNotEmpty) {
      imageUrl = result.files.single.path;
    }
  }
}

class ReceTemplateModel extends ChangeNotifier {
  // Form key
  final formKey = GlobalKey<FormState>();

  // --- A. HVAC DETAILS ---
  final TextEditingController a1_ahu_exists = TextEditingController();
  final TextEditingController a1_use_ahu = TextEditingController();
  final PhotoController a1_ahu_location = PhotoController();
  final TextEditingController a1_chilled_tapoff_exists = TextEditingController();
  final PhotoController a1_chilled_tapoff_location = PhotoController();
  final TextEditingController a1_chilled_pipe_height = TextEditingController();
  final PhotoController a1_chilled_pipe_photo = PhotoController();
  final TextEditingController a1_hvac_drain_exists = TextEditingController();
  final PhotoController a1_hvac_drain_location = PhotoController();
  final TextEditingController a1_hvac_drain_height = TextEditingController();
  final TextEditingController a1_fresh_air_provided = TextEditingController();
  final TextEditingController a1_fresh_air_type = TextEditingController();
  final PhotoController a1_fresh_air_location = PhotoController();
  final TextEditingController a1_fresh_air_height = TextEditingController();
  final TextEditingController a1_exhaust_provided = TextEditingController();
  final TextEditingController a1_exhaust_type = TextEditingController();
  final PhotoController a1_exhaust_location = PhotoController();
  final TextEditingController a1_exhaust_height = TextEditingController();

  // A2 Hi-street
  final TextEditingController a2_ac_units_exist = TextEditingController();
  final TextEditingController a2_use_existing_units = TextEditingController();
  final PhotoController a2_odu_locations = PhotoController();
  final TextEditingController a2_odu_distance = TextEditingController();
  final PhotoController a2_ac_drain_location = PhotoController();

  // A3 Common
  Map<String, String> a3_surroundings = {
    'Below Floor': 'AC',
    'Above Floor': 'AC',
    'Left Side': 'AC',
    'Right Side': 'AC',
    'Back Side': 'AC',
    'Front': 'AC',
  };
  final TextEditingController a3_structural_glazing = TextEditingController();
  final TextEditingController a3_glazing_exposed = TextEditingController();

  // --- B. ELECTRICAL DETAILS ---
  final TextEditingController b_power_supply_exists = TextEditingController();
  final PhotoController b_power_supply_location = PhotoController();
  final PhotoController b_electrical_load_provision = PhotoController();
  final TextEditingController b_power_cable_type = TextEditingController();
  final TextEditingController b_power_for_lift_provision = TextEditingController();
  final TextEditingController b_power_cable_details_for_lift = TextEditingController();

  // B1 DG
  final TextEditingController b1_dg_exists = TextEditingController();
  final TextEditingController b1_dg_dedicated_shared = TextEditingController();
  final PhotoController b1_dg_location = PhotoController();
  final PhotoController b1_dg_load_provision = PhotoController();
  final TextEditingController b1_dg_backup_hours = TextEditingController();
  final TextEditingController b1_dg_changeover_type = TextEditingController();

  // B2 Earthing
  final TextEditingController b2_earthing_dedicated = TextEditingController();
  final PhotoController b2_earthpit_location = PhotoController();

  // --- C. SPRINKLER DETAILS ---
  final TextEditingController c_sprinkler_exists = TextEditingController();
  final TextEditingController c_sprinkler_type = TextEditingController();
  final PhotoController c_sprinkler_tapoff_location = PhotoController();
  final TextEditingController c_sprinkler_pipe_height = TextEditingController();
  final PhotoController c_sprinkler_pipe_photo = PhotoController();

  // --- D. FAS DETAILS ---
  final TextEditingController d_fas_exists = TextEditingController();
  final TextEditingController d_smoke_detector_type = TextEditingController();
  final PhotoController d_fas_panel_location = PhotoController();
  final TextEditingController d_fas_panel_make = TextEditingController();
  final TextEditingController d_fas_panel_type = TextEditingController();

  // --- E. PLUMBING & DRAINAGE ---
  final TextEditingController e_plumbing_exists = TextEditingController();
  final PhotoController e_plumbing_location = PhotoController();
  final TextEditingController e_toilet_exists = TextEditingController();
  final PhotoController e_proposed_toilet_locations = PhotoController();
  final TextEditingController e_core_cuts_allowed = TextEditingController();
  final TextEditingController e_dedicated_water_tank = TextEditingController();

  // --- F. FIRE HYDRANT DETAILS ---
  final TextEditingController f_fire_hydrant_exists = TextEditingController();
  final PhotoController f_fire_hydrant_locations = PhotoController();

  // --- TIMER & ONLINE STATUS ---
  bool isDeviceOnlineTImer = true;
  Timer? _timer;
  int _seconds = 0;
  String get timerValue {
    final minutes = (_seconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (_seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  ReceTemplateModel() {
    startTimer();
    checkDeviceOnline();
  }

  void startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _seconds++;
      notifyListeners();
    });
  }

  void stopTimer() {
    _timer?.cancel();
  }

  void checkDeviceOnline() {
    isDeviceOnlineTImer = !isDeviceOnlineTImer;
    notifyListeners();
  }

  String? validateNotEmpty(String? v) {
    if (v == null || v.trim().isEmpty) return 'Required';
    return null;
  }

  String? validateNumber(String? v) {
    if (v == null || v.trim().isEmpty) return 'Required';
    final n = num.tryParse(v.trim());
    if (n == null) return 'Enter a valid number';
    return null;
  }

  Map<String, dynamic> getFormJson() {
    return {
      'A_HVAC': {
        'A1_MALL_PROPERTY': {
          'AHU_exists': a1_ahu_exists.text,
          'Can_use_AHU': a1_use_ahu.text,
          'AHU_location': a1_ahu_location.toMap(),
          'Chilled_tapoff_exists': a1_chilled_tapoff_exists.text,
          'Chilled_tapoff_location': a1_chilled_tapoff_location.toMap(),
          'Chilled_water_pipe_height': {
            'height': a1_chilled_pipe_height.text,
            'photo': a1_chilled_pipe_photo.toMap(),
          },
          'HVAC_drain_exists': a1_hvac_drain_exists.text,
          'HVAC_drain_location': a1_hvac_drain_location.toMap(),
          'HVAC_drain_height': a1_hvac_drain_height.text,
          'Fresh_air_provided': a1_fresh_air_provided.text,
          'Fresh_air_type': a1_fresh_air_type.text,
          'Fresh_air_location': a1_fresh_air_location.toMap(),
          'Fresh_air_height': a1_fresh_air_height.text,
          'Exhaust_provided': a1_exhaust_provided.text,
          'Exhaust_type': a1_exhaust_type.text,
          'Exhaust_location': a1_exhaust_location.toMap(),
          'Exhaust_height': a1_exhaust_height.text,
        },
        'A2_HI_STREET': {
          'AC_units_exist': a2_ac_units_exist.text,
          'Can_use_existing_units': a2_use_existing_units.text,
          'ODU_locations': a2_odu_locations.toMap(),
          'ODU_distance': a2_odu_distance.text,
          'AC_drain_location': a2_ac_drain_location.toMap(),
        },
        'A3_COMMON_POINTS': {
          'Store_Surroundings': a3_surroundings,
          'Structural_glazing': a3_structural_glazing.text,
          'Glazing_exposed_to_sun': a3_glazing_exposed.text,
        }
      },
      'B_ELECTRICAL': {
        'Power_supply_exists': b_power_supply_exists.text,
        'Power_supply_location': b_power_supply_location.toMap(),
        'Electrical_load_provision': b_electrical_load_provision.toMap(),
        'Power_cable_type': b_power_cable_type.text,
        'Power_for_lift_provision': b_power_for_lift_provision.text,
        'Power_cable_details_for_lift': b_power_cable_details_for_lift.text,
        'B1_DG': {
          'DG_exists': b1_dg_exists.text,
          'DG_dedicated_shared': b1_dg_dedicated_shared.text,
          'DG_location': b1_dg_location.toMap(),
          'DG_load_provision': b1_dg_load_provision.toMap(),
          'DG_backup_hours': b1_dg_backup_hours.text,
          'DG_changeover_type': b1_dg_changeover_type.text,
        },
        'B2_EARTHING': {
          'Earthing_dedicated': b2_earthing_dedicated.text,
          'Earthpit_location': b2_earthpit_location.toMap(),
        }
      },
      'C_SPRINKLER': {
        'Sprinkler_exists': c_sprinkler_exists.text,
        'Sprinkler_type': c_sprinkler_type.text,
        'Tapoff_location': c_sprinkler_tapoff_location.toMap(),
        'Pipe_height': c_sprinkler_pipe_height.text,
        'Pipe_photo': c_sprinkler_pipe_photo.toMap(),
      },
      'D_FAS': {
        'FAS_exists': d_fas_exists.text,
        'Smoke_detector_type': d_smoke_detector_type.text,
        'Panel_location': d_fas_panel_location.toMap(),
        'Panel_make': d_fas_panel_make.text,
        'Panel_type': d_fas_panel_type.text,
      },
      'E_PLUMBING': {
        'Plumbing_exists': e_plumbing_exists.text,
        'Plumbing_location': e_plumbing_location.toMap(),
        'Toilet_exists': e_toilet_exists.text,
        'Proposed_toilet_locations': e_proposed_toilet_locations.toMap(),
        'Core_cuts_allowed': e_core_cuts_allowed.text,
        'Dedicated_water_tank': e_dedicated_water_tank.text,
      },
      'F_FIRE_HYDRANT': {
        'Fire_hydrant_exists': f_fire_hydrant_exists.text,
        'Locations': f_fire_hydrant_locations.toMap(),
      },
      'meta': {
        'savedAt': DateTime.now().toIso8601String(),
        'offline': !isDeviceOnlineTImer,
      }
    };
  }

  Future<String> saveForm() async {
    final state = formKey.currentState;
    if (state == null) throw Exception('Form not mounted');
    if (!state.validate()) throw Exception('Validation failed');
    final Map<String, dynamic> map = getFormJson();
    final jsonString = jsonEncode(map);
    await Future.delayed(const Duration(milliseconds: 200));
    notifyListeners();
    return jsonString;
  }

  @override
  void dispose() {
    // Dispose all controllers
    a1_ahu_exists.dispose();
    a1_use_ahu.dispose();
    a1_ahu_location.dispose();
    a1_chilled_tapoff_exists.dispose();
    a1_chilled_tapoff_location.dispose();
    a1_chilled_pipe_height.dispose();
    a1_chilled_pipe_photo.dispose();
    a1_hvac_drain_exists.dispose();
    a1_hvac_drain_location.dispose();
    a1_hvac_drain_height.dispose();
    a1_fresh_air_provided.dispose();
    a1_fresh_air_type.dispose();
    a1_fresh_air_location.dispose();
    a1_fresh_air_height.dispose();
    a1_exhaust_provided.dispose();
    a1_exhaust_type.dispose();
    a1_exhaust_location.dispose();
    a1_exhaust_height.dispose();

    a2_ac_units_exist.dispose();
    a2_use_existing_units.dispose();
    a2_odu_locations.dispose();
    a2_odu_distance.dispose();
    a2_ac_drain_location.dispose();

    a3_structural_glazing.dispose();
    a3_glazing_exposed.dispose();

    b_power_supply_exists.dispose();
    b_power_supply_location.dispose();
    b_electrical_load_provision.dispose();
    b_power_cable_type.dispose();
    b_power_for_lift_provision.dispose();
    b_power_cable_details_for_lift.dispose();

    b1_dg_exists.dispose();
    b1_dg_dedicated_shared.dispose();
    b1_dg_location.dispose();
    b1_dg_load_provision.dispose();
    b1_dg_backup_hours.dispose();
    b1_dg_changeover_type.dispose();

    b2_earthing_dedicated.dispose();
    b2_earthpit_location.dispose();

    c_sprinkler_exists.dispose();
    c_sprinkler_type.dispose();
    c_sprinkler_tapoff_location.dispose();
    c_sprinkler_pipe_height.dispose();
    c_sprinkler_pipe_photo.dispose();

    d_fas_exists.dispose();
    d_smoke_detector_type.dispose();
    d_fas_panel_location.dispose();
    d_fas_panel_make.dispose();
    d_fas_panel_type.dispose();

    e_plumbing_exists.dispose();
    e_plumbing_location.dispose();
    e_toilet_exists.dispose();
    e_proposed_toilet_locations.dispose();
    e_core_cuts_allowed.dispose();
    e_dedicated_water_tank.dispose();

    f_fire_hydrant_exists.dispose();
    f_fire_hydrant_locations.dispose();

    _timer?.cancel();

    super.dispose();
  }
}
