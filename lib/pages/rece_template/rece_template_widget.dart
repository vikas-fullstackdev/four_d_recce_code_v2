// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'rece_template_model.dart';

// class ReceTemplateWidget extends StatefulWidget {
//   const ReceTemplateWidget({
//     Key? key,
//     this.projectID,
//     this.reccestageid,
//     this.stageNo,
//     this.projectName,
//   }) : super(key: key);

//   // Add static route metadata used by navigation code
//   static const String routeName = 'receTemplate';
//   static const String routePath = '/receTemplate';

//   final String? projectID;
//   // nav.dart passes this param — keep it to match generated navigation calls
//   final String? reccestageid;
//   final String? stageNo;       // <-- Add this
//   final String? projectName;   // <-- Add this

//   @override
//   _ReceTemplateWidgetState createState() => _ReceTemplateWidgetState();
// }

// class _ReceTemplateWidgetState extends State<ReceTemplateWidget> {
//   late ReceTemplateModel model;

//   @override
//   void initState() {
//     super.initState();
//     model = ReceTemplateModel();
//   }

//   @override
//   void dispose() {
//     model.dispose();
//     super.dispose();
//   }

//   Widget sectionHeader(String title) => Padding(
//         padding: const EdgeInsets.symmetric(vertical: 8.0),
//         child: Text(title,
//             style: TextStyle(
//                 color: Colors.deepOrange,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 16)),
//       );

//   @override
//   Widget build(BuildContext context) {
//     // Provide the model to subtree using Provider
//     return ChangeNotifierProvider<ReceTemplateModel>.value(
//       value: model,
//       child: Consumer<ReceTemplateModel>(
//         builder: (context, model, child) {
//           return Scaffold(
//             appBar: AppBar(
//               title: const Text('MEP Site Reccee Checklist'),
//               backgroundColor: Colors.deepOrange,
//             ),
//             body: Form(
//               key: model.formKey,
//               child: ListView(
//                 padding: const EdgeInsets.all(12),
//                 children: [
//                   ExpansionTile(
//                     tilePadding: const EdgeInsets.symmetric(horizontal: 12),
//                     title: const Text('A. HVAC DETAILS',
//                         style: TextStyle(fontWeight: FontWeight.bold)),
//                     children: [
//                       sectionHeader('A1. MALL PROPERTY'),
//                       YesNoRadio(
//                         label: 'Is there a existing AHU available at Site ?',
//                         value: model.a1_ahu_exists,
//                         onChanged: (v) => setState(() => model.a1_ahu_exists = v),
//                       ),
//                       YesNoRadio(
//                           label: 'Can we use the AHU unit ?',
//                           value: model.a1_use_ahu,
//                           onChanged: (v) => setState(() => model.a1_use_ahu = v)),
//                       PhotoField(
//                           controller: model.a1_ahu_location,
//                           label: 'Where is the Existing AHU Located ?'),
//                       YesNoRadio(
//                         label: 'Is there a Chilled Water Tap off provision at site ?',
//                         value: model.a1_chilled_tapoff_exists,
//                         onChanged: (v) =>
//                             setState(() => model.a1_chilled_tapoff_exists = v),
//                       ),
//                       PhotoField(
//                           controller: model.a1_chilled_tapoff_location,
//                           label:
//                               'Where is the Chilled Water Tap off point Located ?'),
//                       LabeledTextPlusPhoto(
//                         controllerText: model.a1_chilled_pipe_height,
//                         controllerPhoto: model.a1_chilled_pipe_photo,
//                         label: 'What is the Height of Chilled water pipe from Floor level ?',
//                         hint: 'Enter height (mm)',
//                       ),
//                       YesNoRadio(
//                         label: 'Is there a HVAC Drain Point provision at site ?',
//                         value: model.a1_hvac_drain_exists,
//                         onChanged: (v) =>
//                             setState(() => model.a1_hvac_drain_exists = v),
//                       ),
//                       PhotoField(
//                           controller: model.a1_hvac_drain_location,
//                           label: 'Where is the HVAC Drain Point point Located ?'),
//                       LabeledTextPlusPhoto(
//                         controllerText: model.a1_hvac_drain_height,
//                         controllerPhoto: PhotoController()
//                           ..textController.text = '', // local blank photo
//                         label: 'What is the Height of HVAC Drain Pipe from Floor level ?',
//                         hint: 'Enter height',
//                       ),
//                       YesNoRadio(
//                         label: 'Is Fresh Air supply provided by developer ?',
//                         value: model.a1_fresh_air_provided,
//                         onChanged: (v) =>
//                             setState(() => model.a1_fresh_air_provided = v),
//                       ),
//                       DropdownField(
//                         label: 'What is the type of Fresh Air supply ?',
//                         value: model.a1_fresh_air_type,
//                         items: const ['Treated Fresh Air', 'Normal Fresh Air'],
//                         onChanged: (v) => setState(() => model.a1_fresh_air_type = v),
//                       ),
//                       PhotoField(
//                           controller: model.a1_fresh_air_location,
//                           label: 'Where is the Fresh Air Duct Located ?'),
//                       LabeledTextPlusPhoto(
//                         controllerText: model.a1_fresh_air_height,
//                         controllerPhoto: PhotoController(),
//                         label: 'What is the Height of Fresh Air Duct from Floor level ?',
//                         hint: 'Enter height',
//                       ),
//                       YesNoRadio(
//                         label: 'Is there Exhaust Provision by developer ?',
//                         value: model.a1_exhaust_provided,
//                         onChanged: (v) =>
//                             setState(() => model.a1_exhaust_provided = v),
//                       ),
//                       DropdownField(
//                         label: 'What is the type of Exhaust Provision ?',
//                         value: model.a1_exhaust_type,
//                         items: const ['Centralised System', 'Dedicated', 'Others'],
//                         onChanged: (v) => setState(() => model.a1_exhaust_type = v),
//                       ),
//                       PhotoField(
//                           controller: model.a1_exhaust_location,
//                           label: 'Where is the Exhaust Duct Located ?'),
//                       LabeledTextPlusPhoto(
//                         controllerText: model.a1_exhaust_height,
//                         controllerPhoto: PhotoController(),
//                         label: 'What is the Height of Exhaust Duct from Floor level ?',
//                         hint: 'Enter height',
//                       ),
//                       const Divider(),
//                       sectionHeader('A2. HI-STREET PROPERTY / HYBRID / COMPLEX'),
//                       YesNoRadio(
//                         label: 'Area there existing AC units available at site ?',
//                         value: model.a2_ac_units_exist,
//                         onChanged: (v) => setState(() => model.a2_ac_units_exist = v),
//                       ),
//                       YesNoRadio(
//                         label: 'Can we use the Existing Units ?',
//                         value: model.a2_use_existing_units,
//                         onChanged: (v) =>
//                             setState(() => model.a2_use_existing_units = v),
//                       ),
//                       PhotoField(controller: model.a2_odu_locations, label: 'Where is the ODU placement locations ?'),
//                       TextFormField(
//                         controller: model.a2_odu_distance,
//                         decoration: const InputDecoration(labelText: 'What is the distance of ODU from store ? (m)'),
//                         validator: model.validateNumber,
//                       ),
//                       PhotoField(controller: model.a2_ac_drain_location, label: 'Where is the AC Drain Point point Located ?'),
//                       const Divider(),
//                       sectionHeader('A3. COMMON POINTS'),
//                       const Padding(
//                         padding: EdgeInsets.symmetric(vertical: 6.0),
//                         child: Text('What is the Store Surrounding Air Condition Details? (Select for each side)', style: TextStyle(fontWeight: FontWeight.bold)),
//                       ),
//                       ...model.a3_surroundings.keys.map((side) {
//                         return DropdownField(
//                           label: side,
//                           value: model.a3_surroundings[side],
//                           items: const ['AC', 'Non AC', 'Exposed to Sun'],
//                           onChanged: (v) => setState(() => model.a3_surroundings[side] = v ?? 'AC'),
//                         );
//                       }).toList(),
//                       YesNoRadio(
//                         label: 'Is there Existing Structural Glazing at site ?',
//                         value: model.a3_structural_glazing,
//                         onChanged: (v) => setState(() => model.a3_structural_glazing = v),
//                       ),
//                       YesNoRadio(
//                         label: 'Is the Glazing exposed to Sun ?',
//                         value: model.a3_glazing_exposed,
//                         onChanged: (v) => setState(() => model.a3_glazing_exposed = v),
//                       ),
//                     ],
//                   ),

//                   ExpansionTile(
//                     title: const Text('B. ELECTRICAL DETAILS', style: TextStyle(fontWeight: FontWeight.bold)),
//                     children: [
//                       YesNoRadio(
//                           label: 'Is there a existing Power Supply availbale at site ?',
//                           value: model.b_power_supply_exists,
//                           onChanged: (v) => setState(() => model.b_power_supply_exists = v)),
//                       PhotoField(controller: model.b_power_supply_location, label: 'Where is the Power Supply source located ?'),
//                       PhotoField(controller: model.b_electrical_load_provision, label: 'What is the Electrical Load provision ?'),
//                       DropdownField(label: 'Power cable details ? (Cable type & size)', value: model.b_power_cable_type, items: const ['Copper', 'Aluminum', 'Others'], onChanged: (v) => setState(() => model.b_power_cable_type = v)),
//                       YesNoRadio(label: 'Is there Power Cable provison for Lift / Escalators ?', value: model.b_power_for_lift_provision, onChanged: (v) => setState(() => model.b_power_for_lift_provision = v)),
//                       DropdownField(label: 'What is the Power cable details ? (for Lift)', value: model.b_power_cable_details_for_lift, items: const ['Copper', 'Aluminum', 'Others'], onChanged: (v) => setState(() => model.b_power_cable_details_for_lift = v)),
//                       const Divider(),
//                       sectionHeader('B1. DG SUPPLY'),
//                       YesNoRadio(label: 'Is there a existing DG Backup availbale at site ?', value: model.b1_dg_exists, onChanged: (v) => setState(() => model.b1_dg_exists = v)),
//                       RadioGroupField(label: 'Is the DG Backup deicated / shared with other tenants ?', value: model.b1_dg_dedicated_shared, items: const ['Dedicated', 'Shared'], onChanged: (v) => setState(() => model.b1_dg_dedicated_shared = v)),
//                       PhotoField(controller: model.b1_dg_location, label: 'Where is the DG located at site ?'),
//                       PhotoField(controller: model.b1_dg_load_provision, label: 'What is the Load Provision of DG ?'),
//                       TextFormField(controller: model.b1_dg_backup_hours, decoration: const InputDecoration(labelText: 'DG backup provision for how many hours ?'), validator: model.validateNumber),
//                       DropdownField(label: 'What is the DG change over type ?', value: model.b1_dg_changeover_type, items: const ['Automatic', 'Manual'], onChanged: (v) => setState(() => model.b1_dg_changeover_type = v)),
//                       const Divider(),
//                       sectionHeader('B2. EARTHING DETAILS'),
//                       YesNoRadio(label: 'Is there Dedicated Earthing provision give at site ?', value: model.b2_earthing_dedicated, onChanged: (v) => setState(() => model.b2_earthing_dedicated = v)),
//                       PhotoField(controller: model.b2_earthpit_location, label: 'Where is the Earthpit located at site ?'),
//                     ],
//                   ),

//                   ExpansionTile(
//                     title: const Text('C. SPRINKLER DETAILS', style: TextStyle(fontWeight: FontWeight.bold)),
//                     children: [
//                       YesNoRadio(label: 'Is there an existing Sprinkler System provided at site ?', value: model.c_sprinkler_exists, onChanged: (v) => setState(() => model.c_sprinkler_exists = v)),
//                       DropdownField(label: 'What type of Sprinkler System available at site ?', value: model.c_sprinkler_type, items: const ['Uprights', 'Pendants', 'Others'], onChanged: (v) => setState(() => model.c_sprinkler_type = v)),
//                       PhotoField(controller: model.c_sprinkler_tapoff_location, label: 'Where is the Sprinkler Tap off point located ?'),
//                       LabeledTextPlusPhoto(controllerText: model.c_sprinkler_pipe_height, controllerPhoto: model.c_sprinkler_pipe_photo, label: 'What is the Height of Sprinkler Pipe from Floor level ?', hint: 'Enter height'),
//                     ],
//                   ),

//                   ExpansionTile(
//                     title: const Text('D. FAS DETAILS', style: TextStyle(fontWeight: FontWeight.bold)),
//                     children: [
//                       YesNoRadio(label: 'Is there an existing Smoke Detectors System avaibale at site ?', value: model.d_fas_exists, onChanged: (v) => setState(() => model.d_fas_exists = v)),
//                       DropdownField(label: 'What type of Smoke Detectors available at site ?', value: model.d_smoke_detector_type, items: const ['Above Ceiling', 'Below Ceiling', 'Others'], onChanged: (v) => setState(() => model.d_smoke_detector_type = v)),
//                       PhotoField(controller: model.d_fas_panel_location, label: 'Where is the FAS Panel located at site ?'),
//                       TextFormField(controller: model.d_fas_panel_make, decoration: const InputDecoration(labelText: 'What is the Make of Developer FAS Panel ?'), validator: model.validateNotEmpty),
//                       DropdownField(label: 'What is the Type of FAS Panel ?', value: model.d_fas_panel_type, items: const ['Addressable', 'Conventional'], onChanged: (v) => setState(() => model.d_fas_panel_type = v)),
//                     ],
//                   ),

//                   ExpansionTile(
//                     title: const Text('E. PLUMBING & DRAINAGE DETAILS', style: TextStyle(fontWeight: FontWeight.bold)),
//                     children: [
//                       YesNoRadio(label: 'Is there an existing Plumbing / Drain Provision available at site ?', value: model.e_plumbing_exists, onChanged: (v) => setState(() => model.e_plumbing_exists = v)),
//                       PhotoField(controller: model.e_plumbing_location, label: 'Where is the Plumbing / Drain points located at site ?'),
//                       YesNoRadio(label: 'Is there an existing Toilet available at site ?', value: model.e_toilet_exists, onChanged: (v) => setState(() => model.e_toilet_exists = v)),
//                       PhotoField(controller: model.e_proposed_toilet_locations, label: 'Mark the Location of proposed Toilet locations at site.'),
//                       YesNoRadio(label: 'Are Core Cuts allowed for new drain points ?', value: model.e_core_cuts_allowed, onChanged: (v) => setState(() => model.e_core_cuts_allowed = v)),
//                       DropdownField(label: 'Is there a Dedicated Water Supply Tank for the store ?', value: model.e_dedicated_water_tank, items: const ['Yes', 'No', 'NA'], onChanged: (v) => setState(() => model.e_dedicated_water_tank = v)),
//                     ],
//                   ),

//                   ExpansionTile(
//                     title: const Text('F. FIRE HYDRANT DETAILS', style: TextStyle(fontWeight: FontWeight.bold)),
//                     children: [
//                       YesNoRadio(label: 'Is there a Fire Hydrant provided by developer ?', value: model.f_fire_hydrant_exists, onChanged: (v) => setState(() => model.f_fire_hydrant_exists = v)),
//                       PhotoField(controller: model.f_fire_hydrant_locations, label: 'Where is the Fire Hydrant Points located at site ?'),
//                     ],
//                   ),

//                   const SizedBox(height: 16),
//                   ElevatedButton.icon(
//                     icon: const Icon(Icons.check),
//                     label: const Text('Submit'),
//                     style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange, padding: const EdgeInsets.symmetric(vertical: 14)),
//                     onPressed: () async {
//                       try {
//                         final jsonString = await model.saveForm();
//                         if (!mounted) return;
//                         showDialog(
//                           context: context,
//                           builder: (_) => AlertDialog(
//                             title: const Text('Form JSON'),
//                             content: SingleChildScrollView(child: Text(jsonString)),
//                             actions: [
//                               TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close'))
//                             ],
//                           ),
//                         );
//                       } catch (e) {
//                         if (!mounted) return;
//                         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: ${e}'), backgroundColor: Colors.red));
//                       }
//                     },
//                   ),
//                   const SizedBox(height: 24),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// // Helper widgets below

// class YesNoRadio extends StatelessWidget {
//   final String label;
//   final String? value;
//   final ValueChanged<String?> onChanged;
//   const YesNoRadio({required this.label, required this.value, required this.onChanged, Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6.0),
//       child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//         Text(label),
//         Row(children: [
//           Expanded(
//             child: RadioListTile<String>(
//               title: const Text('Yes'),
//               value: 'Yes',
//               groupValue: value,
//               onChanged: onChanged,
//               dense: true,
//             ),
//           ),
//           Expanded(
//             child: RadioListTile<String>(
//               title: const Text('No'),
//               value: 'No',
//               groupValue: value,
//               onChanged: onChanged,
//               dense: true,
//             ),
//           ),
//         ]),
//       ]),
//     );
//   }
// }

// class DropdownField extends StatelessWidget {
//   final String label;
//   final String? value;
//   final List<String> items;
//   final ValueChanged<String?> onChanged;
//   const DropdownField({required this.label, required this.value, required this.items, required this.onChanged, Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6.0),
//       child: InputDecorator(
//         decoration: InputDecoration(labelText: label, filled: true, fillColor: Colors.grey[100], border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none)),
//         child: DropdownButtonHideUnderline(
//           child: DropdownButton<String>(
//             isExpanded: true,
//             value: value,
//             hint: const Text('Select'),
//             items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
//             onChanged: onChanged,
//           ),
//         ),
//       ),
//     );
//   }
// }

// class RadioGroupField extends StatelessWidget {
//   final String label;
//   final String? value;
//   final List<String> items;
//   final ValueChanged<String?> onChanged;
//   const RadioGroupField({required this.label, required this.value, required this.items, required this.onChanged, Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Padding(padding: const EdgeInsets.symmetric(vertical: 6.0), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//       Text(label),
//       Wrap(spacing: 8, children: items.map((item) => ChoiceChip(label: Text(item), selected: value == item, onSelected: (_) => onChanged(item), selectedColor: Colors.deepOrange.shade100)).toList())
//     ]));
//   }
// }

// class PhotoField extends StatefulWidget {
//   final PhotoController controller;
//   final String label;
//   const PhotoField({required this.controller, required this.label, Key? key}) : super(key: key);
//   @override
//   _PhotoFieldState createState() => _PhotoFieldState();
// }

// class _PhotoFieldState extends State<PhotoField> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6.0),
//       child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//         Text(widget.label),
//         const SizedBox(height: 6),
//         Row(children: [
//           Expanded(
//             child: TextFormField(
//               controller: widget.controller.textController,
//               decoration: InputDecoration(labelText: 'Detail (text)', filled: true, fillColor: Colors.grey[100], border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8)), borderSide: BorderSide.none)),
//               validator: (v) => null,
//             ),
//           ),
//           const SizedBox(width: 8),
//           ElevatedButton.icon(
//             icon: const Icon(Icons.photo_camera),
//             label: const Text('Upload Photo'),
//             style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange),
//             onPressed: () async {
//               final url = await _showImageUrlDialog(context, widget.controller.imageUrl);
//               if (url != null) {
//                 setState(() {
//                   widget.controller.imageUrl = url;
//                 });
//               }
//             },
//           ),
//         ]),
//         if (widget.controller.imageUrl != null && widget.controller.imageUrl!.isNotEmpty)
//           Padding(
//             padding: const EdgeInsets.only(top: 8.0),
//             child: SizedBox(height: 120, child: ClipRRect(borderRadius: BorderRadius.circular(8), child: Image.network(widget.controller.imageUrl!, fit: BoxFit.cover, errorBuilder: (_, __, ___) => Container(color: Colors.grey[200], alignment: Alignment.center, child: const Text('Invalid image URL'))))),
//           ),
//       ]),
//     );
//   }

//   Future<String?> _showImageUrlDialog(BuildContext context, String? current) {
//     final c = TextEditingController(text: current);
//     return showDialog<String?>(
//       context: context,
//       builder: (ctx) => AlertDialog(
//         title: const Text('Upload Photo (paste image URL)'),
//         content: TextField(controller: c, decoration: const InputDecoration(hintText: 'https://...jpg')),
//         actions: [
//           TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
//           TextButton(onPressed: () => Navigator.pop(ctx, c.text.trim()), child: const Text('OK')),
//         ],
//       ),
//     );
//   }
// }

// class LabeledTextPlusPhoto extends StatelessWidget {
//   final TextEditingController controllerText;
//   final PhotoController controllerPhoto;
//   final String label;
//   final String hint;
//   const LabeledTextPlusPhoto({required this.controllerText, required this.controllerPhoto, required this.label, this.hint = '', Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6.0),
//       child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//         Text(label),
//         const SizedBox(height: 6),
//         Row(children: [
//           Expanded(child: TextFormField(controller: controllerText, decoration: InputDecoration(labelText: hint, filled: true, fillColor: Colors.grey[100], border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none)), validator: (v) => null)),
//           const SizedBox(width: 8),
//           ElevatedButton.icon(icon: const Icon(Icons.photo), label: const Text('Upload Photo'), style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange), onPressed: () async {
//             final url = await _showImageUrlDialog(context, controllerPhoto.imageUrl);
//             if (url != null) {
//               controllerPhoto.imageUrl = url;
//             }
//           }),
//         ]),
//         if (controllerPhoto.imageUrl != null && controllerPhoto.imageUrl!.isNotEmpty)
//           Padding(
//             padding: const EdgeInsets.only(top: 8.0),
//             child: SizedBox(height: 120, child: ClipRRect(borderRadius: BorderRadius.circular(8), child: Image.network(controllerPhoto.imageUrl!, fit: BoxFit.cover, errorBuilder: (_, __, ___) => Container(color: Colors.grey[200], alignment: Alignment.center, child: const Text('Invalid image URL'))))),
//           ),
//       ]),
//     );
//   }

//   Future<String?> _showImageUrlDialog(BuildContext context, String? current) {
//     final c = TextEditingController(text: current);
//     return showDialog<String?>(
//       context: context,
//       builder: (ctx) => AlertDialog(
//         title: const Text('Upload Photo (paste image URL)'),
//         content: TextField(controller: c, decoration: const InputDecoration(hintText: 'https://...jpg')),
//         actions: [
//           TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
//           TextButton(onPressed: () => Navigator.pop(ctx, c.text.trim()), child: const Text('OK')),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'rece_template_model.dart';

// class ReceTemplateWidget extends StatefulWidget {
//   const ReceTemplateWidget({
//     Key? key,
//     this.projectID,
//     this.reccestageid,
//     this.stageNo,
//     this.projectName,
//   }) : super(key: key);

//   static const String routeName = 'receTemplate';
//   static const String routePath = '/receTemplate';


//   final String? projectID;
//   final String? reccestageid;
//   final String? stageNo;
//   final String? projectName;

//   @override
//   _ReceTemplateWidgetState createState() => _ReceTemplateWidgetState();
// }

// class _ReceTemplateWidgetState extends State<ReceTemplateWidget> {
//   late ReceTemplateModel model;

//   @override
//   void initState() {
//     super.initState();
//     model = ReceTemplateModel();
//     model.startTimer(); // start timer on init
//   }

//   @override
//   void dispose() {
//     model.dispose();
//     super.dispose();
//   }

//   Widget sectionHeader(String title) => Padding(
//         padding: const EdgeInsets.symmetric(vertical: 8.0),
//         child: Text(
//           title,
//           style: const TextStyle(
//               color: Colors.deepOrange, fontWeight: FontWeight.bold, fontSize: 16),
//         ),
//       );

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider<ReceTemplateModel>.value(
//       value: model,
//       child: Consumer<ReceTemplateModel>(
//         builder: (context, model, child) {
//           return Scaffold(
//             appBar: AppBar(
//               backgroundColor: Colors.white,
//               automaticallyImplyLeading: false,
//               title: Row(
//                 children: [
//                   Image.asset(
//                     'assets/images/New4Dlogo.png',
//                     width: 42.0,
//                     height: 42.0,
//                     fit: BoxFit.contain,
//                   ),
//                   const SizedBox(width: 12),
//                   const Text(
//                     'Home',
//                     style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
//                   ),
//                 ],
//               ),
//               actions: [
//                 Row(
//                   children: [
//                     // Online/offline indicator
//                     IconButton(
//                       icon: Icon(
//                         model.isDeviceOnlineTImer ? Icons.online_prediction : Icons.cloud_off,
//                         color: model.isDeviceOnlineTImer ? Colors.green : Colors.red,
//                       ),
//                       onPressed: () async {
//                         model.checkDeviceOnline();
//                       },
//                     ),
//                     // Timer display
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                       child: Text(
//                         model.timerValue,
//                         style: const TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                     IconButton(
//                       icon: const Icon(Icons.person, color: Colors.black),
//                       onPressed: () {
//                         Navigator.pushNamed(context, '/profile');
//                       },
//                     ),
//                   ],
//                 ),
//               ],
//               centerTitle: false,
//               elevation: 0,
//             ),
//             body: Form(
//               key: model.formKey,
//               child: ListView(
//                 padding: const EdgeInsets.all(12),
//                 children: [
//                   // Example: HVAC section
//                   ExpansionTile(
//                     title: const Text('A. HVAC DETAILS',
//                         style: TextStyle(fontWeight: FontWeight.bold)),
//                     children: [
//                       sectionHeader('A1. MALL PROPERTY'),
//                       YesNoRadio(
//                         label: 'Is there a existing AHU available at Site?',
//                         value: model.a1_ahu_exists,
//                         onChanged: (v) => setState(() => model.a1_ahu_exists = v),
//                       ),
//                       // Add other fields here...
//                     ],
//                   ),
//                   // Add other ExpansionTiles (B, C, D, E, F) as in your original code
//                   const SizedBox(height: 16),
//                   ElevatedButton.icon(
//                     icon: const Icon(Icons.check),
//                     label: const Text('Submit'),
//                     style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.deepOrange,
//                         padding: const EdgeInsets.symmetric(vertical: 14)),
//                     onPressed: () async {
//                       try {
//                         final jsonString = await model.saveForm();
//                         if (!mounted) return;
//                         showDialog(
//                           context: context,
//                           builder: (_) => AlertDialog(
//                             title: const Text('Form JSON'),
//                             content: SingleChildScrollView(child: Text(jsonString)),
//                             actions: [
//                               TextButton(
//                                   onPressed: () => Navigator.pop(context),
//                                   child: const Text('Close'))
//                             ],
//                           ),
//                         );
//                       } catch (e) {
//                         if (!mounted) return;
//                         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                           content: Text('Error: $e'),
//                           backgroundColor: Colors.red,
//                         ));
//                       }
//                     },
//                   ),
//                   const SizedBox(height: 24),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// /// --- Helper widgets ---

// class YesNoRadio extends StatelessWidget {
//   final String label;
//   final String? value;
//   final ValueChanged<String?> onChanged;
//   const YesNoRadio(
//       {required this.label, required this.value, required this.onChanged, Key? key})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6.0),
//       child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//         Text(label),
//         Row(
//           children: [
//             Expanded(
//               child: RadioListTile<String>(
//                 title: const Text('Yes'),
//                 value: 'Yes',
//                 groupValue: value,
//                 onChanged: onChanged,
//                 dense: true,
//               ),
//             ),
//             Expanded(
//               child: RadioListTile<String>(
//                 title: const Text('No'),
//                 value: 'No',
//                 groupValue: value,
//                 onChanged: onChanged,
//                 dense: true,
//               ),
//             ),
//           ],
//         ),
//       ]),
//     );
//   }
// }



// rece_template_widget.dart

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'rece_template_model.dart';

// class ReceTemplateWidget extends StatefulWidget {
//   const ReceTemplateWidget({
//     Key? key,
//     this.projectID,
//     this.reccestageid,
//     this.stageNo,
//     this.projectName,
//   }) : super(key: key);

//   static const String routeName = 'receTemplate';
//   static const String routePath = '/receTemplate';

//   final String? projectID;
//   final String? reccestageid;
//   final String? stageNo;
//   final String? projectName;

//   @override
//   _ReceTemplateWidgetState createState() => _ReceTemplateWidgetState();
// }

// class _ReceTemplateWidgetState extends State<ReceTemplateWidget> {
//   late ReceTemplateModel model;

//   @override
//   void initState() {
//     super.initState();
//     model = ReceTemplateModel();
//   }

//   @override
//   void dispose() {
//     model.dispose();
//     super.dispose();
//   }

//   Widget sectionHeader(String title) => Padding(
//         padding: const EdgeInsets.symmetric(vertical: 8.0),
//         child: Text(
//           title,
//           style: const TextStyle(
//               color: Colors.deepOrange, fontWeight: FontWeight.bold, fontSize: 16),
//         ),
//       );

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider<ReceTemplateModel>.value(
//       value: model,
//       child: Consumer<ReceTemplateModel>(
//         builder: (context, model, child) {
//           return Scaffold(
//             appBar: AppBar(
//               backgroundColor: Colors.white,
//               automaticallyImplyLeading: false,
//               title: Row(
//                 children: [
//                   Image.asset(
//                     'assets/images/New4Dlogo.png',
//                     width: 42.0,
//                     height: 42.0,
//                     fit: BoxFit.contain,
//                   ),
//                   const SizedBox(width: 12),
//                   const Text(
//                     'Home',
//                     style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
//                   ),
//                 ],
//               ),
//               actions: [
//                 Row(
//                   children: [
//                     IconButton(
//                       icon: Icon(
//                         model.isDeviceOnlineTImer ? Icons.online_prediction : Icons.cloud_off,
//                         color: model.isDeviceOnlineTImer ? Colors.green : Colors.red,
//                       ),
//                       onPressed: () async {
//                         model.checkDeviceOnline();
//                       },
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                       child: Text(
//                         model.timerValue,
//                         style: const TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                     IconButton(
//                       icon: const Icon(Icons.person, color: Colors.black),
//                       onPressed: () {
//                         Navigator.pushNamed(context, '/profile');
//                       },
//                     ),
//                   ],
//                 ),
//               ],
//               centerTitle: false,
//               elevation: 0,
//             ),
//             body: Form(
//               key: model.formKey,
//               child: ListView(
//                 padding: const EdgeInsets.all(12),
//                 children: [
//                   ExpansionTile(
//                     title: const Text('A. HVAC DETAILS',
//                         style: TextStyle(fontWeight: FontWeight.bold)),
//                     children: [
//                       sectionHeader('A1. MALL PROPERTY'),
//                       YesNoRadio(
//                         label: 'Is there a existing AHU available at Site?',
//                         value: model.a1_ahu_exists,
//                         onChanged: (v) => setState(() => model.a1_ahu_exists = v),
//                       ),
//                       // Add all other fields similarly
//                     ],
//                   ),
//                   const SizedBox(height: 16),
//                   ElevatedButton.icon(
//                     icon: const Icon(Icons.check),
//                     label: const Text('Submit'),
//                     style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.deepOrange,
//                         padding: const EdgeInsets.symmetric(vertical: 14)),
//                     onPressed: () async {
//                       try {
//                         final jsonString = await model.saveForm();
//                         if (!mounted) return;
//                         showDialog(
//                           context: context,
//                           builder: (_) => AlertDialog(
//                             title: const Text('Form JSON'),
//                             content: SingleChildScrollView(child: Text(jsonString)),
//                             actions: [
//                               TextButton(
//                                   onPressed: () => Navigator.pop(context),
//                                   child: const Text('Close'))
//                             ],
//                           ),
//                         );
//                       } catch (e) {
//                         if (!mounted) return;
//                         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                           content: Text('Error: $e'),
//                           backgroundColor: Colors.red,
//                         ));
//                       }
//                     },
//                   ),
//                   const SizedBox(height: 24),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// /// --- Helper Widget ---
// class YesNoRadio extends StatelessWidget {
//   final String label;
//   final String? value;
//   final ValueChanged<String?> onChanged;
//   const YesNoRadio(
//       {required this.label, required this.value, required this.onChanged, Key? key})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6.0),
//       child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//         Text(label),
//         Row(
//           children: [
//             Expanded(
//               child: RadioListTile<String>(
//                 title: const Text('Yes'),
//                 value: 'Yes',
//                 groupValue: value,
//                 onChanged: onChanged,
//                 dense: true,
//               ),
//             ),
//             Expanded(
//               child: RadioListTile<String>(
//                 title: const Text('No'),
//                 value: 'No',
//                 groupValue: value,
//                 onChanged: onChanged,
//                 dense: true,
//               ),
//             ),
//           ],
//         ),
//       ]),
//     );
//   }
// }








import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'rece_template_model.dart';
import 'package:file_picker/file_picker.dart';

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
              color: Colors.deepOrange, fontWeight: FontWeight.bold, fontSize: 16),
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
                  label: const Text('Pick Image'),
                  onPressed: () async {
                    await controller.pickImage();
                    setState(() {});
                  },
                ),
                const SizedBox(width: 12),
                if (controller.imageUrl != null)
                  Expanded(
                    child: Text(
                      controller.imageUrl!,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
              ],
            ),
          ],
        ),
      );

  Widget yesNoRadio(String label, TextEditingController controller) =>
      Padding(
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
                children: [
                  Image.asset(
                    'assets/images/New4Dlogo.png',
                    width: 42.0,
                    height: 42.0,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Home',
                    style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
                  ),
                ],
              ),
              actions: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        model.isDeviceOnlineTImer ? Icons.online_prediction : Icons.cloud_off,
                        color: model.isDeviceOnlineTImer ? Colors.green : Colors.red,
                      ),
                      onPressed: () async {
                        model.checkDeviceOnline();
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        model.timerValue,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.person, color: Colors.black),
                      onPressed: () {
                        Navigator.pushNamed(context, '/profile');
                      },
                    ),
                  ],
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
                    title: const Text('A. HVAC DETAILS',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    children: [
                      sectionHeader('A1. MALL PROPERTY'),
                      yesNoRadio('Is there a existing AHU?', model.a1_ahu_exists),
                      textField('Can use AHU', model.a1_use_ahu),
                      photoField('AHU Location', model.a1_ahu_location),
                      yesNoRadio('Chilled Tapoff exists?', model.a1_chilled_tapoff_exists),
                      photoField('Chilled Tapoff Location', model.a1_chilled_tapoff_location),
                      textField('Chilled Pipe Height', model.a1_chilled_pipe_height,
                          keyboardType: TextInputType.number),
                      photoField('Chilled Pipe Photo', model.a1_chilled_pipe_photo),
                      yesNoRadio('HVAC Drain exists?', model.a1_hvac_drain_exists),
                      photoField('HVAC Drain Location', model.a1_hvac_drain_location),
                      textField('HVAC Drain Height', model.a1_hvac_drain_height,
                          keyboardType: TextInputType.number),
                      yesNoRadio('Fresh Air Provided?', model.a1_fresh_air_provided),
                      textField('Fresh Air Type', model.a1_fresh_air_type),
                      photoField('Fresh Air Location', model.a1_fresh_air_location),
                      textField('Fresh Air Height', model.a1_fresh_air_height,
                          keyboardType: TextInputType.number),
                      yesNoRadio('Exhaust Provided?', model.a1_exhaust_provided),
                      textField('Exhaust Type', model.a1_exhaust_type),
                      photoField('Exhaust Location', model.a1_exhaust_location),
                      textField('Exhaust Height', model.a1_exhaust_height,
                          keyboardType: TextInputType.number),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ExpansionTile(
                    title: const Text('B. ELECTRICAL DETAILS',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    children: [
                      yesNoRadio('Power Supply Exists?', model.b_power_supply_exists),
                      photoField('Power Supply Location', model.b_power_supply_location),
                      photoField('Electrical Load Provision', model.b_electrical_load_provision),
                      textField('Power Cable Type', model.b_power_cable_type),
                      textField('Power for Lift Provision', model.b_power_for_lift_provision),
                      textField('Power Cable Details for Lift', model.b_power_cable_details_for_lift),
                      sectionHeader('B1. DG'),
                      yesNoRadio('DG Exists?', model.b1_dg_exists),
                      textField('DG Dedicated/Shared', model.b1_dg_dedicated_shared),
                      photoField('DG Location', model.b1_dg_location),
                      photoField('DG Load Provision', model.b1_dg_load_provision),
                      textField('DG Backup Hours', model.b1_dg_backup_hours),
                      textField('DG Changeover Type', model.b1_dg_changeover_type),
                      sectionHeader('B2. Earthing'),
                      textField('Earthing Dedicated', model.b2_earthing_dedicated),
                      photoField('Earthpit Location', model.b2_earthpit_location),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ExpansionTile(
                    title: const Text('C. SPRINKLER DETAILS',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    children: [
                      yesNoRadio('Sprinkler Exists?', model.c_sprinkler_exists),
                      textField('Sprinkler Type', model.c_sprinkler_type),
                      photoField('Tapoff Location', model.c_sprinkler_tapoff_location),
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
                      textField('Smoke Detector Type', model.d_smoke_detector_type),
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
                      photoField('Plumbing Location', model.e_plumbing_location),
                      yesNoRadio('Toilet Exists?', model.e_toilet_exists),
                      photoField('Proposed Toilet Locations', model.e_proposed_toilet_locations),
                      textField('Core Cuts Allowed', model.e_core_cuts_allowed),
                      textField('Dedicated Water Tank', model.e_dedicated_water_tank),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ExpansionTile(
                    title: const Text('F. FIRE HYDRANT DETAILS',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    children: [
                      yesNoRadio('Fire Hydrant Exists?', model.f_fire_hydrant_exists),
                      photoField('Fire Hydrant Locations', model.f_fire_hydrant_locations),
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
                        final jsonString = await model.saveForm();
                        if (!mounted) return;
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: const Text('Form JSON'),
                            content: SingleChildScrollView(child: Text(jsonString)),
                            actions: [
                              TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Close'))
                            ],
                          ),
                        );
                      } catch (e) {
                        if (!mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Error: $e'),
                          backgroundColor: Colors.red,
                        ));
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
