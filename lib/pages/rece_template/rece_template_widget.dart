import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'rece_template_model.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:convert';
import '/notification_service.dart';
import 'package:go_router/go_router.dart';
import '../image_annotator_page_fixed.dart';
import '../emailjs.dart';


class ReceTemplateWidget extends StatefulWidget {
  const ReceTemplateWidget({
    Key? key,
    this.projectID,
    this.reccestageid,
    this.stageNo,
    this.projectName,
  }) : super(key: key);

  static const String routeName = 'receTemplate';
  static const String routePath = '/receTemplate';

  final String? projectID;
  final String? reccestageid;
  final String? stageNo;
  final String? projectName;

  @override
  _ReceTemplateWidgetState createState() => _ReceTemplateWidgetState();
}

class _ReceTemplateWidgetState extends State<ReceTemplateWidget> {
  late ReceTemplateModel model;

  @override
  void initState() {
    super.initState();
    model = ReceTemplateModel();
  }

  @override
  void dispose() {
    model.dispose();
    super.dispose();
  }

  Widget sectionHeader(String title) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text(
          title,
          style: const TextStyle(
              color: Colors.deepOrange,
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
      );

  Widget textField(String label, TextEditingController controller,
          {TextInputType keyboardType = TextInputType.text}) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            labelText: label,
            border: const OutlineInputBorder(),
          ),
          validator: (v) => model.validateNotEmpty(v),
        ),
      );

  Widget photoField(String label, PhotoController controller) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label),
            const SizedBox(height: 4),
            Row(
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.image),
                  label: const Text('Pick Images'),
                  onPressed: () async {
                    try {
                      await controller.pickImage();
                      if (mounted) {
                        setState(() {});
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Image uploaded successfully'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    } catch (e) {
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Error uploading image: $e'),
                            backgroundColor: Colors.red,
                            duration: const Duration(seconds: 3),
                          ),
                        );
                      }
                    }
                  },
                ),
                const SizedBox(width: 12),
                if (controller.imageUrl != null)
                  Expanded(
                    child: Text(
                      controller.imageUrls.length > 1
                          ? '${controller.imageUrls.length} images - ${controller.imageUrl}'
                          : controller.imageUrl!,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.green, fontSize: 12),
                    ),
                  )
              ],
            ),
          ],
        ),
      );

  Widget yesNoRadio(String label, TextEditingController controller) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(label),
          Row(
            children: [
              Expanded(
                child: RadioListTile<String>(
                  title: const Text('Yes'),
                  value: 'Yes',
                  groupValue: controller.text,
                  onChanged: (v) => setState(() => controller.text = v ?? ''),
                  dense: true,
                ),
              ),
              Expanded(
                child: RadioListTile<String>(
                  title: const Text('No'),
                  value: 'No',
                  groupValue: controller.text,
                  onChanged: (v) => setState(() => controller.text = v ?? ''),
                  dense: true,
                ),
              ),
            ],
          ),
        ]),
      );

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ReceTemplateModel>.value(
      value: model,
      child: Consumer<ReceTemplateModel>(
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              title: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    width: 42.0,
                    height: 42.0,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'SDR Screen',
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, color: Colors.black),
                  ),
                ],
              ),
              actions: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      // Online/offline indicator
                      IconButton(
                        icon: Icon(
                          model.isDeviceOnlineTImer ? Icons.online_prediction : Icons.cloud_off,
                          color: model.isDeviceOnlineTImer ? Colors.green : Colors.red,
                        ),
                        onPressed: () async {
                          model.checkDeviceOnline();
                        },
                      ),

                      // Timer value
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          model.timerValue,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),

                

                      // Profile
                      IconButton(
                        icon: const Icon(Icons.person, color: Colors.black),
                        onPressed: () {
                          Navigator.pushNamed(context, '/profile');
                        },
                      ),

                      // Receipt / template (shown on wider screens)
                      if (MediaQuery.of(context).size.width > 700)
                        IconButton(
                          icon: const Icon(Icons.draw, color: Colors.black),
                          onPressed: () async {
                            // Open image annotator. Pass a placeholder image if none available.
                            final placeholder = 'https://via.placeholder.com/1024x768.png?text=Annotate+Image';
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ImageAnnotatorPage(imageUrl: placeholder),
                              ),
                            );
                          },
                        ),
                    ],
                  ),
                ),
              ],
              centerTitle: false,
              elevation: 0,
            ),
            body: Form(
              key: model.formKey,
              child: ListView(
                padding: const EdgeInsets.all(12),
                children: [
                  ExpansionTile(
                    title: const Text('A1. HVAC DETAILS',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    children: [
                      sectionHeader('A1. MALL PROPERTY'),
                      yesNoRadio(
                          'Is there a existing AHU?', model.a1_ahu_exists),
                      textField('Can use AHU', model.a1_use_ahu),
                      photoField('AHU Location', model.a1_ahu_location),
                      yesNoRadio('Chilled Tapoff exists?',
                          model.a1_chilled_tapoff_exists),
                      photoField('Chilled Tapoff Location',
                          model.a1_chilled_tapoff_location),
                      textField(
                          'Chilled Pipe Height', model.a1_chilled_pipe_height,
                          keyboardType: TextInputType.number),
                      photoField(
                          'Chilled Pipe Photo', model.a1_chilled_pipe_photo),
                      yesNoRadio(
                          'HVAC Drain exists?', model.a1_hvac_drain_exists),
                      photoField(
                          'HVAC Drain Location', model.a1_hvac_drain_location),
                      textField('HVAC Drain Height', model.a1_hvac_drain_height,
                          keyboardType: TextInputType.number),
                      yesNoRadio(
                          'Fresh Air Provided?', model.a1_fresh_air_provided),
                      textField('Fresh Air Type', model.a1_fresh_air_type),
                      photoField(
                          'Fresh Air Location', model.a1_fresh_air_location),
                      textField('Fresh Air Height', model.a1_fresh_air_height,
                          keyboardType: TextInputType.number),
                      yesNoRadio(
                          'Exhaust Provided?', model.a1_exhaust_provided),
                      textField('Exhaust Type', model.a1_exhaust_type),
                      photoField('Exhaust Location', model.a1_exhaust_location),
                      textField('Exhaust Height', model.a1_exhaust_height,
                          keyboardType: TextInputType.number),
                    ],
                  ),

                  // A2 Hi-street / Hybrid / Complex
                  ExpansionTile(
                    title: const Text('A2. HI-STREET PROPERTY / HYBRID / COMPLEX',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    children: [
                      sectionHeader('A2. HI-STREET PROPERTY / HYBRID / COMPLEX'),
                      // "Area there existing AC units available at site ? Yes / No"
                      yesNoRadio(
                        'Are there existing AC units available at site?',
                        model.a2_ac_units_exist,
                      ),

                      // "Can we use the Existing Units ? Yes / No"
                      yesNoRadio(
                        'Can we use the existing AC units?',
                        model.a2_use_existing_units,
                      ),

                      // "Where is the ODU placement locations ?"
                      photoField(
                        'Where is the ODU placement location? (Upload photo / mark on plan)',
                        model.a2_odu_locations,
                      ),

                      // "What is the distance of ODU from store ? Calculate approx distance as per site."
                      textField(
                        'Approx distance of ODU from store (e.g., 3m)',
                        model.a2_odu_distance,
                        keyboardType: TextInputType.text,
                      ),

                      // "Where is the AC Drain Point point Located ? Upload Photo (Site Photo & location marked on plan)"
                      photoField(
                        'AC drain point location (Upload site photo & plan mark)',
                        model.a2_ac_drain_location,
                      ),
                    ],
                  ),

                  // A3 COMMON POINTS
                  ExpansionTile(
                    title: const Text('A3. COMMON POINTS',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    children: [
                      sectionHeader('A3. COMMON POINTS'),

                      // Surrounding details dropdowns
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: model.a3_surroundings.keys.map<Widget>((side) {
                            final current = model.a3_surroundings[side] ?? 'AC';
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                children: [
                                  Expanded(flex: 2, child: Text(side)),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    flex: 3,
                                    child: DropdownButtonFormField<String>(
                                      value: current,
                                      items: const [
                                        DropdownMenuItem(value: 'AC', child: Text('AC')),
                                        DropdownMenuItem(value: 'Non AC', child: Text('Non AC')),
                                        DropdownMenuItem(value: 'Exposed to Sun', child: Text('Exposed to Sun')),
                                      ],
                                      onChanged: (val) {
                                        model.a3_surroundings[side] = val ?? 'AC';
                                        model.notifyListeners();
                                      },
                                      decoration: InputDecoration(
                                        isDense: true,
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),

                      // Structural glazing yes/no
                      yesNoRadio(
                        'Is there existing structural glazing at site?',
                        model.a3_structural_glazing,
                      ),

                      // Glazing exposed to sun yes/no
                      yesNoRadio(
                        'Is the glazing exposed to sun?',
                        model.a3_glazing_exposed,
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),
                  ExpansionTile(
                    title: const Text('B. ELECTRICAL DETAILS',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    children: [
                      yesNoRadio(
                          'Power Supply Exists?', model.b_power_supply_exists),
                      photoField('Power Supply Location',
                          model.b_power_supply_location),
                      photoField('Electrical Load Provision',
                          model.b_electrical_load_provision),
                      textField('Power Cable Type', model.b_power_cable_type),
                      textField('Power for Lift Provision',
                          model.b_power_for_lift_provision),
                      textField('Power Cable Details for Lift',
                          model.b_power_cable_details_for_lift),
                      sectionHeader('B1. DG'),
                      yesNoRadio('DG Exists?', model.b1_dg_exists),
                      textField(
                          'DG Dedicated/Shared', model.b1_dg_dedicated_shared),
                      photoField('DG Location', model.b1_dg_location),
                      photoField(
                          'DG Load Provision', model.b1_dg_load_provision),
                      textField('DG Backup Hours', model.b1_dg_backup_hours),
                      textField(
                          'DG Changeover Type', model.b1_dg_changeover_type),
                      sectionHeader('B2. Earthing'),
                      textField(
                          'Earthing Dedicated', model.b2_earthing_dedicated),
                      photoField(
                          'Earthpit Location', model.b2_earthpit_location),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ExpansionTile(
                    title: const Text('C. SPRINKLER DETAILS',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    children: [
                      yesNoRadio('Sprinkler Exists?', model.c_sprinkler_exists),
                      textField('Sprinkler Type', model.c_sprinkler_type),
                      photoField(
                          'Tapoff Location', model.c_sprinkler_tapoff_location),
                      textField('Pipe Height', model.c_sprinkler_pipe_height),
                      photoField('Pipe Photo', model.c_sprinkler_pipe_photo),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ExpansionTile(
                    title: const Text('D. FAS DETAILS',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    children: [
                      yesNoRadio('FAS Exists?', model.d_fas_exists),
                      textField(
                          'Smoke Detector Type', model.d_smoke_detector_type),
                      photoField('Panel Location', model.d_fas_panel_location),
                      textField('Panel Make', model.d_fas_panel_make),
                      textField('Panel Type', model.d_fas_panel_type),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ExpansionTile(
                    title: const Text('E. PLUMBING & DRAINAGE',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    children: [
                      yesNoRadio('Plumbing Exists?', model.e_plumbing_exists),
                      photoField(
                          'Plumbing Location', model.e_plumbing_location),
                      yesNoRadio('Toilet Exists?', model.e_toilet_exists),
                      photoField('Proposed Toilet Locations',
                          model.e_proposed_toilet_locations),
                      textField('Core Cuts Allowed', model.e_core_cuts_allowed),
                      textField(
                          'Dedicated Water Tank', model.e_dedicated_water_tank),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ExpansionTile(
                    title: const Text('F. FIRE HYDRANT DETAILS',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    children: [
                      yesNoRadio(
                          'Fire Hydrant Exists?', model.f_fire_hydrant_exists),
                      photoField('Fire Hydrant Locations',
                          model.f_fire_hydrant_locations),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.check),
                    label: const Text('Submit'),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrange,
                        padding: const EdgeInsets.symmetric(vertical: 14)),
                    onPressed: () async {
                      try {
                        // Validate form
                        final state = model.formKey.currentState;
                        if (state == null || !state.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Please fix validation errors')),
                          );
                          return;
                        }

                        // Build JSON locally (for preview and upload)
                        final formJson = model.getFormJson();
                        final prettyJson = const JsonEncoder.withIndent('  ')
                            .convert(formJson);

                        // Convert stageNo to int if available
                        final stageno = widget.stageNo != null
                            ? int.tryParse(widget.stageNo!)
                            : null;

                        // Submit to Supabase
                        await model.submitFormToSupabase(
                          projectID: widget.projectID,
                          reccestageid: widget.reccestageid,
                          stageno: stageno,
                        );

                        if (!mounted) return;
                        // Show success + JSON preview
                        // showDialog(
                        //   context: context,
                        //   builder: (_) => AlertDialog(
                        //     title: const Text('Submitted'),
                        //     content: SingleChildScrollView(child: Text(prettyJson)),
                        //     actions: [
                        //       TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close'))
                        //     ],
                        //   ),
                        // );
                        // showDialog(
                        //     context: context,
                        //     builder: (_) => AlertDialog(
                        //       title: const Text('Submitted'),
                        //       content: const Text('Your recce form is submitted'),
                        //       actions: [
                        //         TextButton(
                        //           onPressed: () => Navigator.pop(context),
                        //           child: const Text('Close'),
                        //         ),
                        //       ],
                        //     ),
                        //   );
                        // showDialog(
                        //   context: context,
                        //   builder: (_) => AlertDialog(
                        //     title: const Text('Submitted'),
                        //     content: const Text('Your recce form is submitted'),
                        //     actions: [
                        //       TextButton(
                        //         onPressed: () {
                        //           // Navigator.pop(context); // close the dialog
                        //           Navigator.pop(
                        //               context); // navigate back to previous screen
                        //         },
                        //         child: const Text('Close'),
                        //       ),
                        //     ],
                        //   ),
                        // );
                        NotificationService.showNotification(
                              title: "Form Submitted",
                              body: "Your Recce Form form has been successfully submitted",
                            );
                        await sendTestEmail();
                        // showDialog(
                        //   context: context,
                        //   builder: (_) => AlertDialog(
                        //     title: const Text('Submitted'),
                        //     content: const Text('Your recce form is submitted'),
                        //     actions: [
                        //       TextButton(
                        //         onPressed: () {
                        //           Navigator.of(context, rootNavigator: true).pop();
                        //         },
                        //         // onPressed: () {
                        //         //         Navigator.pop(dialogContext); // close dialog
                        //         //         Navigator.goNamed('sdrDetailPage');      // go back screen
                        //         //       },
                        //         child: const Text('Close'),
                        //       ),
                        //     ],
                        //   ),
                        // );
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (dialogContext) {
                            Future.delayed(const Duration(seconds: 2), () {
                              Navigator.of(dialogContext).pop();
                              context.goNamed('sdrDetailPage');
                            });

                            return const AlertDialog(
                              title: Text('Submitted'),
                              content: Text('Your recce form is submitted'),
                            );
                          },
                        );
                      } catch (e, st) {
                        print('submitForm error: $e\n$st');
                        if (!mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  'Error submitting form: ${e.toString()}'),
                              backgroundColor: Colors.red),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
