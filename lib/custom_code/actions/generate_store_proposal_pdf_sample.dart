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

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
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

Future<String?> generateStoreProposalPdfSample() async {
  try {
    // 1️⃣ Test image URL
    const testImageUrl =
        "https://wcpvtwboxkammhqpcpow.supabase.co/storage/v1/object/public/rece/qc/1754631361197000_0.jpeg";

    // 2️⃣ Hardcoded sample data
    final Map<String, dynamic> data = {
      "projectInfo": {
        "title": "Store Proposal and Initial Design",
        "storeName": "Udupi @ Home",
        "storeLocation": "Ramamurthy nagar, Banaswadi Extension, Bengaluru",
        "totalCarpetArea": "120 m²",
        "dateOfVisit": "25-07-2025",
        "submissionDate": "28-07-2025",
        "submittedBy": "Vikas",
        "monoAARAppleID": "12345",
        "clientLogoUrl": testImageUrl
      },
      "contacts": {
        "designAgency": {
          "name": "Vikas",
          "contact": "99988776655",
          "agency": "4D",
          "designation": "Project Manager"
        },
        "partner": {
          "name": "Om",
          "contact": "9988776655",
          "designation": "Partner"
        },
        "appleSalesTeam": {
          "name": "veer",
          "contact": "998776655",
          "designation": "ASM",
          "locatedAt": "Ramamurthy nagar, Bengaluru"
        }
      },
      "images": [
        {
          "section": "Location Plan",
          "urls": [testImageUrl]
        },
        {
          "section": "Store Front",
          "urls": [testImageUrl, testImageUrl]
        }
      ]
    };

    // 3️⃣ Preload all images
    for (final imgGroup in data["images"]) {
      final List<pw.ImageProvider> loadedImages = [];
      for (final url in imgGroup["urls"]) {
        final img = await tryLoadImage(url);
        if (img != null) loadedImages.add(img);
      }
      imgGroup["loadedImages"] = loadedImages;
    }

    final pdf = pw.Document();
    final primaryColor = PdfColor.fromHex("#002060");
    final secondaryColor = PdfColors.grey300;

    final headingStyle = pw.TextStyle(
      fontSize: 20,
      fontWeight: pw.FontWeight.bold,
      color: primaryColor,
    );
    final subHeadingStyle = pw.TextStyle(
      fontSize: 14,
      fontWeight: pw.FontWeight.bold,
      color: primaryColor,
    );
    final bodyStyle = pw.TextStyle(fontSize: 12, color: PdfColors.black);

    // ✅ Static logo from URL (header)
    pw.ImageProvider? staticLogoImage = await tryLoadImage(
      "https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/four-d-recce-ksbmae/assets/lbtg519qsgz6/fourD_2.png",
    );

    // ✅ Client logo
    pw.ImageProvider? clientLogoImage =
        await tryLoadImage(data["projectInfo"]?["clientLogoUrl"]);

    // Header
    pw.Widget buildHeader() {
      return pw.Container(
        padding: const pw.EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text(data["projectInfo"]?["title"] ?? "",
                style: subHeadingStyle),
            if (staticLogoImage != null) pw.Image(staticLogoImage, height: 40),
          ],
        ),
      );
    }

    // Footer
    final footer = pw.Container(
      alignment: pw.Alignment.centerRight,
      padding: const pw.EdgeInsets.all(8),
      child: pw.Text(
        'Generated on ${DateTime.now().toLocal()}',
        style: pw.TextStyle(fontSize: 10, color: PdfColors.grey700),
      ),
    );

    // Table builder
    pw.Widget buildKeyValueTable(Map<String, dynamic> map) {
      return pw.Table(
        border: pw.TableBorder.all(color: PdfColors.grey),
        columnWidths: {
          0: const pw.FlexColumnWidth(4),
          1: const pw.FlexColumnWidth(6),
        },
        children: map.entries.map((entry) {
          return pw.TableRow(
            decoration: pw.BoxDecoration(color: secondaryColor),
            children: [
              pw.Padding(
                padding: const pw.EdgeInsets.all(6),
                child: pw.Text(entry.key, style: bodyStyle),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.all(6),
                child: pw.Text(entry.value?.toString() ?? "", style: bodyStyle),
              ),
            ],
          );
        }).toList(),
      );
    }

    // Page 1
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        header: (_) => buildHeader(),
        footer: (_) => footer,
        build: (context) => [
          pw.Text("Project Information", style: headingStyle),
          pw.SizedBox(height: 8),
          buildKeyValueTable({
            "Store Name": data["projectInfo"]?["storeName"],
            "Store Location": data["projectInfo"]?["storeLocation"],
            "Total Carpet Area": data["projectInfo"]?["totalCarpetArea"],
            "Date of Visit": data["projectInfo"]?["dateOfVisit"],
            "Submission Date": data["projectInfo"]?["submissionDate"],
            "Submitted By": data["projectInfo"]?["submittedBy"],
            "Mono AAR - Apple ID": data["projectInfo"]?["monoAARAppleID"],
          }),
          pw.SizedBox(height: 60),
          pw.Text("Store Image", style: subHeadingStyle),
          pw.SizedBox(height: 10),
          if (clientLogoImage != null)
            pw.Image(clientLogoImage, height: 350), // ⬆️ Increased size
        ],
      ),
    );

    // Page 2
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        header: (_) => buildHeader(),
        footer: (_) => footer,
        build: (context) => [
          pw.Text("Contact Details", style: headingStyle),
          pw.SizedBox(height: 10),
          pw.Text("Design Agency", style: subHeadingStyle),
          buildKeyValueTable(data["contacts"]?["designAgency"] ?? {}),
          pw.SizedBox(height: 15),
          pw.Text("Partner Details", style: subHeadingStyle),
          buildKeyValueTable(data["contacts"]?["partner"] ?? {}),
          pw.SizedBox(height: 15),
          pw.Text("Apple Sales Team", style: subHeadingStyle),
          buildKeyValueTable(data["contacts"]?["appleSalesTeam"] ?? {}),
        ],
      ),
    );

    // Page 3 - Images
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        header: (_) => buildHeader(),
        footer: (_) => footer,
        build: (context) => [
          pw.Text("Images", style: headingStyle),
          pw.SizedBox(height: 10),
          ...(data["images"] as List<dynamic>? ?? []).map((imgGroup) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(imgGroup["section"] ?? "Image Section",
                    style: subHeadingStyle),
                pw.SizedBox(height: 8),
                ...(imgGroup["loadedImages"] as List<pw.ImageProvider>? ?? [])
                    .map((img) {
                  return pw.Column(children: [
                    pw.Image(img, height: 350), // Half page height
                    pw.SizedBox(height: 10),
                  ]);
                }),
                pw.SizedBox(height: 15),
              ],
            );
          }),
        ],
      ),
    );

    // Save & upload
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
