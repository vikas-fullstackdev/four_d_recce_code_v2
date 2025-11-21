// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

//f
import 'package:flutter/services.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../flutter_flow/upload_data.dart';

Future<String?> pdfInvoiceDownload(String? title, String? body) async {
  try {
    final pdf = pw.Document();

    // Styles
    final headingStyle = pw.TextStyle(
      fontSize: 24,
      fontWeight: pw.FontWeight.bold,
      color: PdfColors.indigo800,
    );
    final subHeadingStyle = pw.TextStyle(
      fontSize: 14,
      fontWeight: pw.FontWeight.bold,
      color: PdfColors.indigo600,
    );
    final bodyStyle = pw.TextStyle(
      fontSize: 12,
      color: PdfColors.black,
    );
    final img = await networkImage(
      'https://wcpvtwboxkammhqpcpow.supabase.co/storage/v1/object/public/rece/projectLogo/1753158192170000.jpeg',
    );
    final imageBytes = img.buffer.asUint8List();
    pw.Image image1 = pw.Image(pw.MemoryImage(imageBytes));

    // Load logo from assets
    pw.MemoryImage? logoImage;
    try {
      // Load asset image as bytes
      final ByteData imageData =
          await rootBundle.load('assets/images/fourD_2.png');
      final Uint8List imageBytes = imageData.buffer.asUint8List();
      final pw.ImageProvider logoImage = pw.MemoryImage(imageBytes);
    } catch (e) {
      print("Logo image load failed: $e");
    }

    // Header widget
    pw.Widget buildHeader() {
      return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.stretch,
        children: [
          pw.Container(
            padding:
                const pw.EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                // Left: Project name
                pw.Text('Project Name: ${title ?? 'N/A'}',
                    style: subHeadingStyle),
                // Right: Logo
                if (logoImage != null)
                  pw.Image(logoImage, height: 40)
                else
                  pw.Image(image1 as pw.ImageProvider, height: 40),
              ],
            ),
          ),
          pw.Divider(thickness: 1, color: PdfColors.grey600),
        ],
      );
    }

    // Footer widget
    final footer = pw.Container(
      padding: const pw.EdgeInsets.all(8),
      alignment: pw.Alignment.centerRight,
      child: pw.Text(
        'Generated on ${DateTime.now().toLocal()}',
        style: pw.TextStyle(fontSize: 10, color: PdfColors.grey700),
      ),
    );

    // First Page
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        header: (_) => buildHeader(),
        footer: (_) => footer,
        build: (context) => [
          pw.SizedBox(height: 16),
          pw.Text('Report Summary', style: headingStyle),
          pw.SizedBox(height: 12),
          pw.Container(
            padding: const pw.EdgeInsets.all(12),
            decoration: pw.BoxDecoration(
              color: PdfColors.grey200,
              borderRadius: pw.BorderRadius.circular(8),
            ),
            child: pw.Text(
              body ?? 'No content provided.',
              style: bodyStyle,
              textAlign: pw.TextAlign.justify,
            ),
          ),
          pw.SizedBox(height: 30),
          pw.Text('Key Highlights', style: subHeadingStyle),
          pw.Bullet(text: 'Modern layout with header/footer'),
          pw.Bullet(text: 'Dynamic project name and logo'),
          pw.Bullet(text: 'Supports multi-page export'),
        ],
      ),
    );

    // Optional Second Page
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        header: (_) => buildHeader(),
        footer: (_) => footer,
        build: (context) => [
          pw.Text('Appendix', style: headingStyle),
          pw.SizedBox(height: 16),
          pw.Text(
            'This section may contain additional data, charts, or notes.',
            style: bodyStyle,
          ),
          pw.SizedBox(height: 20),
          pw.Container(
            padding: const pw.EdgeInsets.all(12),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(color: PdfColors.grey),
              borderRadius: pw.BorderRadius.circular(6),
            ),
            child: pw.Text(
              'Sample reference or notes...',
              style: pw.TextStyle(font: pw.Font.courier(), fontSize: 12),
            ),
          ),
        ],
      ),
    );

    // Save PDF bytes
    final Uint8List pdfBytes = await pdf.save();

    // Unique filename
    final now = DateTime.now();
    final formattedDateTime =
        '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}_${now.hour.toString().padLeft(2, '0')}-${now.minute.toString().padLeft(2, '0')}-${now.second.toString().padLeft(2, '0')}';
    final fileName = '$formattedDateTime.pdf';

    // Upload to Supabase
    const bucketName = 'rece';
    final storagePath = 'receReport/$fileName';
    final uploadResponse =
        await Supabase.instance.client.storage.from(bucketName).uploadBinary(
              storagePath,
              pdfBytes,
              fileOptions: const FileOptions(contentType: 'application/pdf'),
            );

    // Return public URL
    final publicUrl = Supabase.instance.client.storage
        .from(bucketName)
        .getPublicUrl(storagePath);

    return publicUrl;
  } catch (e) {
    print('Error generating or uploading PDF: $e');
    return 'Error: ${e.toString()}';
  }
}

extension on pw.ImageProvider {
  get buffer => null;
}
