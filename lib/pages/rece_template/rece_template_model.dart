import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_timer.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'dart:io';
import 'dart:typed_data';
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
import 'package:supabase_flutter/supabase_flutter.dart';

// ensure a supabase client variable is available in this file
final SupabaseClient supabase = Supabase.instance.client;

class PhotoController {
  final TextEditingController textController = TextEditingController();
  // Support multiple uploaded image URLs. Keep `imageUrl` as the first (if any)
  // for backward compatibility in UI places that expect a single URL.
  List<String> imageUrls = [];
  String? get imageUrl => imageUrls.isNotEmpty ? imageUrls.first : null;

  Map<String, dynamic> toMap() => {
        'text': textController.text,
        // expose all uploaded urls as a list for form json
        'imageUrls': imageUrls,
      };

  void dispose() {
    textController.dispose();
  }

  Future<void> pickImage() async {
    try {
      print('🔍 pickImage: Starting file picker...');
      // Allow multiple image selection
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: true,
      );
      print('🔍 pickImage: FilePicker result = $result');

      if (result != null && result.files.isNotEmpty) {
        // Clear previous urls (user is picking new set)
        imageUrls = [];

        // Iterate over each selected file and upload
        for (final file in result.files) {
          final filePath = file.path;
          print('🔍 pickImage: filePath = $filePath');

          if (filePath == null) {
            print('❌ pickImage: One of selected file paths is null, skipping');
            continue;
          }

          // Read file bytes
          print('🔍 pickImage: Reading file bytes for ${file.name}...');
          final fileBytes = await _readFileBytes(filePath);
          print('🔍 pickImage: File bytes read: ${fileBytes.length} bytes');

          // Upload to Supabase storage under recce/ folder
          final fileName =
              '${DateTime.now().millisecondsSinceEpoch}_${file.name}';
          final uploadPath = 'recce/$fileName';
          print('🔍 pickImage: uploadPath = $uploadPath');

          print('🔍 pickImage: Uploading to Supabase storage...');
          await supabase.storage.from('project_uploads').uploadBinary(
                uploadPath,
                fileBytes,
                fileOptions: FileOptions(upsert: false),
              );
          print('✅ pickImage: Upload completed for ${file.name}');

          // Get public URL
          final publicUrl =
              supabase.storage.from('project_uploads').getPublicUrl(uploadPath);
          print('🔍 pickImage: publicUrl = $publicUrl');

          if (publicUrl != null) {
            imageUrls.add(publicUrl);
            print('✅ pickImage: Image uploaded successfully: $publicUrl');
          }
        }
      } else {
        print('🔍 pickImage: No file selected');
      }
    } catch (e, st) {
      print('❌ pickImage: Error = $e');
      print('❌ pickImage: Stack trace = $st');
      rethrow;
    }
  }

  Future<Uint8List> _readFileBytes(String filePath) async {
    try {
      final file = File(filePath);
      final exists = await file.exists();
      if (!exists) {
        throw Exception('File does not exist at path: $filePath');
      }
      final bytes = await file.readAsBytes();
      return bytes;
    } catch (e) {
      // ignore: avoid_print
      print('Error reading file bytes: $e');
      rethrow;
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
  final TextEditingController a1_chilled_tapoff_exists =
      TextEditingController();
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
  final TextEditingController b_power_for_lift_provision =
      TextEditingController();
  final TextEditingController b_power_cable_details_for_lift =
      TextEditingController();

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

  Future<void> submitFormToSupabase({
    required String? projectID,
    required String? reccestageid,
    required int? stageno,
  }) async {
    final state = formKey.currentState;
    if (state == null) throw Exception('Form not mounted');
    if (!state.validate()) throw Exception('Validation failed');

    final formJson = getFormJson();

    try {
      // Await the insert (with select to request returning rows). Different SDK
      // versions expose different builder types; awaiting the call directly
      // returns a response object in most versions.
      final response = await supabase.from('recceresponses').insert({
        'projectid': projectID,
        'reccestageid': reccestageid,
        'stageno': stageno,
        'formjson': formJson,
        'submittedby': supabase.auth.currentUser?.id,
        'submittedat': DateTime.now().toIso8601String(),
      }).select();

      // `response` shape depends on SDK version. Try to read error safely.
      // If it's a PostgrestResponse-like object:
      try {
        if ((response as dynamic).error != null) {
          throw Exception(
              (response as dynamic).error?.message ?? 'Insert failed');
        }
      } catch (_) {
        // If response is raw data (map/list), treat as success.
      }
    } catch (e) {
      // Re-throw with clearer message for caller
      throw Exception('Supabase insert failed: ${e.toString()}');
    }
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
