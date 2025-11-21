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
import 'dart:convert';
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

Future<String?> generateStoreProposalPdfWorking(String rowJson) async {
  try {
    // 1️⃣ Decode the incoming row JSON string
    final Map<String, dynamic> rowData = jsonDecode(rowJson);

    // 2️⃣ Decode nested JSON fields from Supabase row
    final Map<String, dynamic> store =
        rowData["store"] != null && rowData["store"].toString().isNotEmpty
            ? jsonDecode(rowData["store"])
            : {};
    final Map<String, dynamic> storeAnalysis =
        rowData["store_analysis"] != null &&
                rowData["store_analysis"].toString().isNotEmpty
            ? jsonDecode(rowData["store_analysis"])
            : {};

    // 3️⃣ Map Supabase row into the same structure your PDF builder expects
    final Map<String, dynamic> data = {
      "projectInfo": {
        "title": "Store Proposal and Initial Design",
        "storeName": store["storeName"] ?? "",
        "storeLocation": rowData["addressOfSite"] ?? "",
        "totalCarpetArea": store["totalCarpetArea"] ?? "",
        "dateOfVisit": store["dateOfVisit"] ?? "",
        "submissionDate": store["submissionDate"] ?? "",
        "submittedBy": rowData["managerName"] ?? "",
        "monoAARAppleID": store["monoAARAppleID"] ?? "",
        "clientLogoUrl": rowData["clientLogo"] ?? ""
      },
      "contacts": {
        "designAgency": {
          "name": rowData["clientname"] ?? "",
          "contact": rowData["clientContactDetails"] ?? "",
          "agency": store["agency"] ?? "",
          "designation": store["designation"] ?? ""
        },
        "partner": {
          "name": rowData["partnerName"] ?? "",
          "contact": rowData["partnerContactDetails"] ?? "",
          "designation": ""
        },
        "appleSalesTeam": {
          "name": store["appleSalesName"] ?? "",
          "contact": store["appleSalesContact"] ?? "",
          "designation": store["appleSalesDesignation"] ?? "",
          "locatedAt": store["appleSalesLocation"] ?? ""
        }
      },
      "images": [
        {
          "section": "Location Plan",
          "urls": List<String>.from(
              store["lcationPlan"]?["locationPlanImage"] ?? [])
        },
        {
          "section": "Proposed Location",
          "urls": List<String>.from(
              store["proposedLocation"]?["proposedLocationImage"] ?? [])
        },
        {
          "section": "Store Analysis - Corner Shop",
          "urls": storeAnalysis["store_analysis_details"]
                      ?["Is_it_a_corner_shop"]?["if_yes_then_image"] !=
                  null
              ? [
                  storeAnalysis["store_analysis_details"]["Is_it_a_corner_shop"]
                      ["if_yes_then_image"]
                ]
              : []
        },
        {
          "section": "Store Analysis - Access to Store",
          "urls": [
            storeAnalysis["store_analysis_details"]
                ?["access_to_the_store_from_the_front"]?["easy_acces"],
            storeAnalysis["store_analysis_details"]
                ?["access_to_the_store_from_the_front"]?["moderate_access"],
            storeAnalysis["store_analysis_details"]
                ?["access_to_the_store_from_the_front"]?["difficult_access"],
          ].whereType<String>().toList()
        },
        {
          "section": "Store Analysis - Visibility",
          "urls": [
            storeAnalysis["store_analysis_details"]
                    ?["visibility_of_the_showroom_from_the_entrance"]
                ?["façade_is_visible_more_than_60%"],
          ].whereType<String>().toList()
        }
      ]
    };

    // 4️⃣ Preload all images
    for (final imgGroup in data["images"]) {
      final List<pw.ImageProvider> loadedImages = [];
      for (final url in imgGroup["urls"]) {
        final img = await tryLoadImage(url);
        if (img != null) loadedImages.add(img);
      }
      imgGroup["loadedImages"] = loadedImages;
    }

    // 5️⃣ Create PDF
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

    // Static logo
    pw.ImageProvider? staticLogoImage = await tryLoadImage(
      "https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/four-d-recce-ksbmae/assets/lbtg519qsgz6/fourD_2.png",
    );

    // Client logo
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

    // Page 1 - Project Info
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
          if (clientLogoImage != null) pw.Image(clientLogoImage, height: 350),
        ],
      ),
    );

    // Page 2 - Contacts
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
                    pw.Image(img, height: 350),
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

    // 6️⃣ Save & Upload to Supabase
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
