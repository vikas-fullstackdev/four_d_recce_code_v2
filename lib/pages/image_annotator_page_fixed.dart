import 'package:flutter/material.dart';

/// Simple, safe ImageAnnotatorPage used as a lightweight annotator.
class ImageAnnotatorPage extends StatelessWidget {
  static const String routeName = 'imageAnnotator';
  static const String routePath = '/imageAnnotator';
  final String imageUrl;
  const ImageAnnotatorPage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Annotator'),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      body: Center(
        child: InteractiveViewer(
          child: imageUrl.startsWith('http')
              ? Image.network(imageUrl, fit: BoxFit.contain)
              : Image.asset(imageUrl, fit: BoxFit.contain),
        ),
      ),
    );
  }
}
