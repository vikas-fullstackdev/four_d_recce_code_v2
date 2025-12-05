// import 'package:flutter/material.dart';
// import '/flutter_flow/flutter_flow_theme.dart';
// import '/flutter_flow/flutter_flow_util.dart';

// class BottomNavWidget extends StatelessWidget {
//   final int currentIndex;

//   const BottomNavWidget({
//     Key? key,
//     required this.currentIndex,
//   }) : super(key: key);

//   void _navigate(BuildContext context, int index) {
//     if (index == currentIndex) return;

//     // Close keyboard if open
//     FocusScope.of(context).unfocus();

//     switch (index) {
//       case 0:
//         context.goNamed('OpeningScreen');
//         break;
//       case 1:
//         context.goNamed('HomePage');
//         break;
//       case 2:
//         context.goNamed('receTemplate');
//         break;
//       case 3:
//         context.goNamed('qc');
//         break;
//       case 4:
//         context.goNamed('finalStage');
//         break;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 70,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: const [
//           BoxShadow(
//             blurRadius: 10,
//             offset: Offset(0, -2),
//             color: Colors.black12,
//           ),
//         ],
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           _navItem(context, Icons.home, "Home", 0),
//           _navItem(context, Icons.folder, "Projects", 1),
//           _navItem(context, Icons.camera_alt, "Recce", 2),
//           _navItem(context, Icons.check, "QC", 3),
//           _navItem(context, Icons.star, "Final", 4),
//         ],
//       ),
//     );
//   }

//   Widget _navItem(BuildContext context, IconData icon, String label, int index) {
//     final bool active = index == currentIndex;

//     return GestureDetector(
//       onTap: () => _navigate(context, index),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             icon,
//             size: 26,
//             color: active
//                 ? FlutterFlowTheme.of(context).primary
//                 : Colors.grey,
//           ),
//           Text(
//             label,
//             style: TextStyle(
//               fontSize: 12,
//               color: active
//                   ? FlutterFlowTheme.of(context).primary
//                   : Colors.grey,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
