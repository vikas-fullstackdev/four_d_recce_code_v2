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

import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../flutter_flow/upload_data.dart';

// Safe image loader
Future<pw.ImageProvider?> tryLoadImage(String? url) async {
  try {
    if (url != null && url.isNotEmpty) {
      return await networkImage(url);
    }
  } catch (e) {
    print('Failed to load image from $url: $e');
  }
  return null;
}

Future<String?> pdfInvoiceDownloadCopy(
  String projectName,
  String clientName,
  String clientPhone,
  String clientContact,
  String siteAddress,
  String clientLogoUrl,
  String projectStatus,
  String createdAt,
  String? storeAnalysisTitle,
  String? isCornerShopImage,
  String? isCornerShopValue,
  String? neighboringOutlets,
  String? socioEconomicClass,
  String? accessImageEasy,
  String? accessImageModerate,
  String? accessImageDifficult,
  String? showroomVisibilityUrl,
) async {
  try {
    final pdf = pw.Document();

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

    // Load static logo
    pw.ImageProvider? staticLogoImage;
    try {
      final ByteData staticData =
          await rootBundle.load('assets/images/fourD_2.png');
      staticLogoImage = pw.MemoryImage(staticData.buffer.asUint8List());
    } catch (e) {
      print("Static logo load failed: $e");
    }

    // Load client logo with fallback
    pw.ImageProvider clientLogoImage = await tryLoadImage(clientLogoUrl) ??
        await networkImage('https://via.placeholder.com/150');

    // Load store analysis images
    final cornerShopImg = await tryLoadImage(isCornerShopImage);
    final accessEasyImg = await tryLoadImage(accessImageEasy);
    final accessModerateImg = await tryLoadImage(accessImageModerate);
    final accessDifficultImg = await tryLoadImage(accessImageDifficult);
    final showroomImg = await tryLoadImage(showroomVisibilityUrl);

    pw.Widget buildHeader() {
      return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.stretch,
        children: [
          pw.Container(
            padding:
                const pw.EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('Project Name: $projectName', style: subHeadingStyle),
                if (staticLogoImage != null)
                  pw.Image(staticLogoImage, height: 40),
              ],
            ),
          ),
          pw.Divider(thickness: 1, color: PdfColors.grey600),
        ],
      );
    }

    final footer = pw.Container(
      padding: const pw.EdgeInsets.all(8),
      alignment: pw.Alignment.centerRight,
      child: pw.Text(
        'Generated on ${DateTime.now().toLocal()}',
        style: pw.TextStyle(fontSize: 10, color: PdfColors.grey700),
      ),
    );

    pw.Widget buildProjectTable() {
      final cells = [
        ['Client Name', clientName],
        ['Client Phone', clientPhone],
        ['Client Contact', clientContact],
        ['Site Address', siteAddress],
        ['Project Status', projectStatus],
        ['Created At', createdAt],
      ];
      return pw.Table(
        border: pw.TableBorder.all(color: PdfColors.grey),
        columnWidths: {
          0: const pw.FlexColumnWidth(3),
          1: const pw.FlexColumnWidth(7),
        },
        children: cells
            .map((row) => pw.TableRow(
                  children: row
                      .map((text) => pw.Padding(
                            padding: const pw.EdgeInsets.all(8),
                            child: pw.Text(text, style: bodyStyle),
                          ))
                      .toList(),
                ))
            .toList(),
      );
    }

    // Page 1: Project Details
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        header: (_) => buildHeader(),
        footer: (_) => footer,
        build: (context) => [
          pw.SizedBox(height: 16),
          pw.Text('Project Details', style: headingStyle),
          pw.SizedBox(height: 12),
          buildProjectTable(),
          pw.SizedBox(height: 24),
          pw.Text('Client Logo', style: subHeadingStyle),
          pw.SizedBox(height: 10),
          pw.Image(clientLogoImage, height: 80),
          pw.SizedBox(height: 30),
          pw.Text('Key Highlights', style: subHeadingStyle),
          pw.Bullet(text: 'Professional layout with header/footer'),
          pw.Bullet(text: 'Dynamic data-driven content'),
          pw.Bullet(text: 'Includes project and client branding'),
          pw.Bullet(text: 'PDF uploaded to Supabase'),
        ],
      ),
    );

    // Page 2: Store Analysis
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        header: (_) => buildHeader(),
        footer: (_) => footer,
        build: (context) => [
          pw.Text(storeAnalysisTitle ?? 'Store Analysis Details',
              style: headingStyle),
          pw.SizedBox(height: 16),
          if (isCornerShopValue != null)
            pw.Column(children: [
              pw.Text('1. Is it a Corner Shop?', style: subHeadingStyle),
              pw.Text('Answer: $isCornerShopValue', style: bodyStyle),
              if (cornerShopImg != null) pw.Image(cornerShopImg, height: 100),
              pw.SizedBox(height: 16),
            ]),
          if (neighboringOutlets != null)
            pw.Column(children: [
              pw.Text('2. Neighboring Outlets', style: subHeadingStyle),
              pw.Text(neighboringOutlets, style: bodyStyle),
              pw.SizedBox(height: 16),
            ]),
          if (socioEconomicClass != null)
            pw.Column(children: [
              pw.Text('3. Socio-Economic Classification',
                  style: subHeadingStyle),
              pw.Text(socioEconomicClass, style: bodyStyle),
              pw.SizedBox(height: 16),
            ]),
          if (accessEasyImg != null ||
              accessModerateImg != null ||
              accessDifficultImg != null)
            pw.Column(children: [
              pw.Text('4. Access to Store from Front', style: subHeadingStyle),
              if (accessEasyImg != null) pw.Image(accessEasyImg, height: 100),
              if (accessModerateImg != null)
                pw.Image(accessModerateImg, height: 100),
              if (accessDifficultImg != null)
                pw.Image(accessDifficultImg, height: 100),
              pw.SizedBox(height: 16),
            ]),
          if (showroomImg != null)
            pw.Column(children: [
              pw.Text('5. Visibility of Showroom from Entrance',
                  style: subHeadingStyle),
              pw.Image(showroomImg, height: 100),
            ]),
        ],
      ),
    );

    // Save and Upload
    final pdfBytes = await pdf.save();
    final now = DateTime.now();
    final fileName =
        '${now.toIso8601String().replaceAll(':', '-').replaceAll('.', '-')}.pdf';
    const bucket = 'rece';
    final path = 'receReport/$fileName';

    await Supabase.instance.client.storage.from(bucket).uploadBinary(
          path,
          pdfBytes,
          fileOptions: const FileOptions(contentType: 'application/pdf'),
        );

    return Supabase.instance.client.storage.from(bucket).getPublicUrl(path);
  } catch (e) {
    print('PDF generation failed: $e');
    return 'Error: ${e.toString()}';
  }
}
