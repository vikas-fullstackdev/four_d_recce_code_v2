// import 'dart:ui' as ui;
// import 'dart:typed_data';
// import 'dart:math' as math;
// import 'dart:io' as io;

// import 'package:flutter/material.dart';
// import 'package:flutter/foundation.dart' show kIsWeb;
// import 'package:flutter/rendering.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';

// // ignore: avoid_web_libraries_in_flutter
// import 'dart:html' as html;



 
// class ImageAnnotatorPage extends StatefulWidget {
//   const ImageAnnotatorPage({super.key});

//   @override
//   State<ImageAnnotatorPage> createState() => _ImageAnnotatorPageState();
// }

// enum AnnotationMode { draw, text, arrow, rectangle }

// class _ImageAnnotatorPageState extends State<ImageAnnotatorPage> {
//   final GlobalKey _repaintKey = GlobalKey();
//   final ImagePicker _picker = ImagePicker();

//   AnnotationMode _mode = AnnotationMode.draw;

//   /// MULTIPLE IMAGES
//   final List<Uint8List> _images = [];
//   int _currentImageIndex = 0;

//   /// ANNOTATIONS PER IMAGE
//   final Map<int, List<_Annotation>> _annotationsMap = {};

//   final List<Offset> _currentPoints = [];
//   Offset? _arrowStart;
//   Offset? _rectStart;
//   Offset? _rectEnd;

//   List<_Annotation> get _annotations =>
//       _annotationsMap[_currentImageIndex] ?? [];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Image Annotator"),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.photo_library),
//             onPressed: _pickMultipleImages,
//           ),
//           IconButton(
//             icon: const Icon(Icons.camera_alt),
//             onPressed: _captureImage,
//           ),
//           IconButton(
//             icon: const Icon(Icons.undo),
//             onPressed: _undoLast,
//           ),
//           IconButton(
//             icon: const Icon(Icons.download),
//             onPressed: _downloadImage,
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Expanded(child: _buildCanvas()),
//           _buildImageSwitcher(),
//           _buildToolbar(),
//           const SizedBox(height: 10),
//         ],
//       ),
//     );
//   }

//   // ================= IMAGE PICKERS =================

//   Future<void> _pickMultipleImages() async {
//     final images = await _picker.pickMultiImage();
//     if (images.isNotEmpty) {
//       for (final img in images) {
//         final bytes = await img.readAsBytes();
//         _images.add(bytes);
//         _annotationsMap[_images.length - 1] = [];
//       }
//       setState(() {});
//     }
//   }

//   Future<void> _captureImage() async {
//     final image = await _picker.pickImage(source: ImageSource.camera);
//     if (image != null) {
//       final bytes = await image.readAsBytes();
//       _images.add(bytes);
//       _annotationsMap[_images.length - 1] = [];
//       setState(() {});
//     }
//   }

//   // ================= CANVAS =================

//   Widget _buildCanvas() {
//     if (_images.isEmpty) {
//       return const Center(
//         child: Text("Upload or capture an image to start"),
//       );
//     }

//     return RepaintBoundary(
//       key: _repaintKey,
//       child: Stack(
//         children: [
//           Center(
//             child: Image.memory(
//               _images[_currentImageIndex],
//               fit: BoxFit.contain,
//             ),
//           ),
//           GestureDetector(
//             onPanStart: _onPanStart,
//             onPanUpdate: _onPanUpdate,
//             onPanEnd: _onPanEnd,
//             onTapUp: _onTapUp,
//             child: CustomPaint(
//               size: Size.infinite,
//               painter: _AnnotationPainter(
//                 annotations: _annotations,
//                 currentPoints: _currentPoints,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildImageSwitcher() {
//     if (_images.length <= 1) return const SizedBox.shrink();

//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         IconButton(
//           icon: const Icon(Icons.chevron_left),
//           onPressed: _currentImageIndex > 0
//               ? () => setState(() => _currentImageIndex--)
//               : null,
//         ),
//         Text("Image ${_currentImageIndex + 1} / ${_images.length}"),
//         IconButton(
//           icon: const Icon(Icons.chevron_right),
//           onPressed: _currentImageIndex < _images.length - 1
//               ? () => setState(() => _currentImageIndex++)
//               : null,
//         ),
//       ],
//     );
//   }

//   // ================= TOOLBAR =================

//   Widget _buildToolbar() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         _toolButton(Icons.brush, AnnotationMode.draw),
//         _toolButton(Icons.text_fields, AnnotationMode.text),
//         _toolButton(Icons.arrow_right_alt, AnnotationMode.arrow),
//         _toolButton(Icons.crop_square, AnnotationMode.rectangle),
//       ],
//     );
//   }

//   Widget _toolButton(IconData icon, AnnotationMode mode) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 6),
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           shape: const CircleBorder(),
//           backgroundColor: _mode == mode ? Colors.blue : Colors.grey,
//         ),
//         onPressed: () => setState(() => _mode = mode),
//         child: Icon(icon, color: Colors.white),
//       ),
//     );
//   }

//   // ================= GESTURES =================

//   void _onPanStart(DragStartDetails d) {
//     if (_mode == AnnotationMode.draw) {
//       _currentPoints.clear();
//       _currentPoints.add(d.localPosition);
//     } else if (_mode == AnnotationMode.arrow) {
//       _arrowStart = d.localPosition;
//     } else if (_mode == AnnotationMode.rectangle) {
//       _rectStart = d.localPosition;
//     }
//   }

//   void _onPanUpdate(DragUpdateDetails d) {
//     setState(() {
//       if (_mode == AnnotationMode.draw) {
//         _currentPoints.add(d.localPosition);
//       } else if (_mode == AnnotationMode.rectangle) {
//         _rectEnd = d.localPosition;
//       }
//     });
//   }

//   void _onPanEnd(DragEndDetails d) {
//     final list = _annotationsMap[_currentImageIndex]!;
//     setState(() {
//       if (_mode == AnnotationMode.draw && _currentPoints.isNotEmpty) {
//         list.add(_Annotation.draw(List.from(_currentPoints)));
//         _currentPoints.clear();
//       } else if (_mode == AnnotationMode.arrow && _arrowStart != null) {
//         list.add(_Annotation.arrow(_arrowStart!, d.velocity.pixelsPerSecond));
//         _arrowStart = null;
//       } else if (_mode == AnnotationMode.rectangle &&
//           _rectStart != null &&
//           _rectEnd != null) {
//         list.add(_Annotation.rectangle(_rectStart!, _rectEnd!));
//         _rectStart = _rectEnd = null;
//       }
//     });
//   }

//   void _onTapUp(TapUpDetails d) async {
//     if (_mode != AnnotationMode.text) return;

//     final controller = TextEditingController();
//     final text = await showDialog<String>(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: const Text("Enter text"),
//         content: TextField(controller: controller),
//         actions: [
//           TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
//           TextButton(onPressed: () => Navigator.pop(context, controller.text), child: const Text("OK")),
//         ],
//       ),
//     );

//     if (text != null && text.trim().isNotEmpty) {
//       _annotationsMap[_currentImageIndex]!
//           .add(_Annotation.text(d.localPosition, text));
//       setState(() {});
//     }
//   }

//   // ================= ACTIONS =================

//   void _undoLast() {
//     final list = _annotationsMap[_currentImageIndex]!;
//     if (list.isNotEmpty) {
//       setState(() => list.removeLast());
//     }
//   }

//   Future<void> _downloadImage() async {
//     final boundary =
//         _repaintKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
//     final image = await boundary.toImage(pixelRatio: 3);
//     final bytes =
//         (await image.toByteData(format: ui.ImageByteFormat.png))!
//             .buffer
//             .asUint8List();

//     if (kIsWeb) {
//       final blob = html.Blob([bytes]);
//       final url = html.Url.createObjectUrl(blob);
//       html.AnchorElement(href: url)
//         ..download = "annotated_${_currentImageIndex + 1}.png"
//         ..click();
//       html.Url.revokeObjectUrl(url);
//     } else {
//       final dir = await getTemporaryDirectory();
//       final file = await io.File(
//         "${dir.path}/annotated_${_currentImageIndex + 1}.png",
//       ).writeAsBytes(bytes);

//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text("Saved to ${file.path}")));
//     }
//   }
// }

// // ================= MODELS =================

// class _Annotation {
//   final AnnotationMode type;
//   final List<Offset>? points;
//   final Offset? start;
//   final Offset? end;
//   final Offset? position;
//   final String? text;

//   _Annotation.draw(this.points)
//       : type = AnnotationMode.draw,
//         start = null,
//         end = null,
//         position = null,
//         text = null;

//   _Annotation.arrow(this.start, this.end)
//       : type = AnnotationMode.arrow,
//         points = null,
//         position = null,
//         text = null;

//   _Annotation.rectangle(this.start, this.end)
//       : type = AnnotationMode.rectangle,
//         points = null,
//         position = null,
//         text = null;

//   _Annotation.text(this.position, this.text)
//       : type = AnnotationMode.text,
//         points = null,
//         start = null,
//         end = null;
// }

// // ================= PAINTER =================

// class _AnnotationPainter extends CustomPainter {
//   final List<_Annotation> annotations;
//   final List<Offset> currentPoints;

//   _AnnotationPainter({
//     required this.annotations,
//     required this.currentPoints,
//   });

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = Colors.red
//       ..strokeWidth = 3
//       ..style = PaintingStyle.stroke;

//     for (final ann in annotations) {
//       if (ann.type == AnnotationMode.draw && ann.points != null) {
//         for (int i = 0; i < ann.points!.length - 1; i++) {
//           canvas.drawLine(ann.points![i], ann.points![i + 1], paint);
//         }
//       } else if (ann.type == AnnotationMode.text &&
//           ann.position != null &&
//           ann.text != null) {
//         final tp = TextPainter(
//           text: TextSpan(
//             text: ann.text!,
//             style: const TextStyle(color: Colors.red, fontSize: 18),
//           ),
//           textDirection: ui.TextDirection.ltr,
//         )..layout();
//         tp.paint(canvas, ann.position!);
//       }
//     }
//   }
//   @override
//   bool shouldRepaint(_) => true;
// }