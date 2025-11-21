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
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../../flutter_flow/upload_data.dart';

// ✅ Download, resize, and compress image for PDF
Future<pw.ImageProvider?> tryLoadImage(String? url,
    {int maxWidth = 1024, int quality = 80}) async {
  try {
    if (url != null && url.isNotEmpty) {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode != 200) {
        print("⚠️ Failed to download image: $url");
        return null;
      }

      final Uint8List bytes = response.bodyBytes;
      final img.Image? decodedImage = img.decodeImage(bytes);
      if (decodedImage == null) {
        print("⚠️ Could not decode image from $url");
        return null;
      }

      img.Image resized = decodedImage;
      if (decodedImage.width > maxWidth) {
        resized = img.copyResize(decodedImage, width: maxWidth);
      }

      final Uint8List compressedBytes =
          Uint8List.fromList(img.encodeJpg(resized, quality: quality));

      return pw.MemoryImage(compressedBytes);
    }
  } catch (e) {
    print('❌ Failed to load image from $url: $e');
  }
  return null;
}

// ✅ Recursive widget builder for nested JSON
List<pw.Widget> buildNestedWidgets(Map<String, dynamic> json,
    {String? sectionName,
    pw.TextStyle? headingStyle,
    pw.TextStyle? subHeadingStyle,
    required pw.TextStyle bodyStyle}) {
  final widgets = <pw.Widget>[];

  if (sectionName != null) {
    widgets.add(pw.Text(sectionName, style: headingStyle));
    widgets.add(pw.SizedBox(height: 6));
  }

  // Separate maps vs primitive fields
  final simpleFields = <String, dynamic>{};
  final nestedFields = <String, Map<String, dynamic>>{};

  json.forEach((key, value) {
    if (value is Map<String, dynamic>) {
      nestedFields[key] = value;
    } else {
      simpleFields[key] = value;
    }
  });

  // Render table for simple key:value pairs
  if (simpleFields.isNotEmpty) {
    widgets.add(pw.Table(
      border: pw.TableBorder.all(color: PdfColors.grey),
      columnWidths: {
        0: const pw.FlexColumnWidth(4),
        1: const pw.FlexColumnWidth(6),
      },
      children: simpleFields.entries.map((entry) {
        return pw.TableRow(
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
    ));
    widgets.add(pw.SizedBox(height: 10));
  }

  // Recursively render nested maps
  nestedFields.forEach((key, nestedMap) {
    widgets.addAll(buildNestedWidgets(nestedMap,
        sectionName: key,
        headingStyle: subHeadingStyle,
        subHeadingStyle: subHeadingStyle,
        bodyStyle: bodyStyle));
  });

  return widgets;
}

// ✅ Builds PDF bytes dynamically based on selected stages
Future<Uint8List> generatePdfBytes(
  Map<String, dynamic> projectInfo,
  Map<String, dynamic> contacts,
  List<dynamic> imagesList,
  List<Map<String, dynamic>> stage2Responses,
  List<String> selectedStages, {
  required int quality,
  required int maxWidth,
}) async {
  // Preload and compress images
  for (final imgGroup in imagesList) {
    final List<pw.ImageProvider> loadedImages = [];
    for (final url in (imgGroup["urls"] as List)) {
      final imgProv =
          await tryLoadImage(url, quality: quality, maxWidth: maxWidth);
      if (imgProv != null) loadedImages.add(imgProv);
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

  // Logos
  pw.ImageProvider? staticLogoImage = await tryLoadImage(
    "https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/four-d-recce-ksbmae/assets/lbtg519qsgz6/fourD_2.png",
    quality: quality,
    maxWidth: maxWidth,
  );
  pw.ImageProvider? clientLogoImage = await tryLoadImage(
      projectInfo["clientLogoUrl"],
      quality: quality,
      maxWidth: maxWidth);

  // Header
  pw.Widget buildHeader() {
    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(projectInfo["title"] ?? "", style: subHeadingStyle),
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

  // -----------------------------
  // ✅ Stage1 Content
  // -----------------------------
  if (selectedStages.contains("stage1")) {
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
            "Store Name": projectInfo["storeName"],
            "Store Location": projectInfo["storeLocation"],
            "Total Carpet Area": projectInfo["totalCarpetArea"],
            "Date of Visit": projectInfo["dateOfVisit"],
            "Submission Date": projectInfo["submissionDate"],
            "Submitted By": projectInfo["submittedBy"],
            "Mono AAR - Apple ID": projectInfo["monoAARAppleID"],
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
          buildKeyValueTable(
              (contacts["designAgency"] as Map<String, dynamic>?) ?? {}),
          pw.SizedBox(height: 15),
          pw.Text("Partner Details", style: subHeadingStyle),
          buildKeyValueTable(
              (contacts["partner"] as Map<String, dynamic>?) ?? {}),
          pw.SizedBox(height: 15),
          pw.Text("Apple Sales Team", style: subHeadingStyle),
          buildKeyValueTable(
              (contacts["appleSalesTeam"] as Map<String, dynamic>?) ?? {}),
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
          ...imagesList.map((imgGroup) {
            final section = imgGroup["section"] as String? ?? "Image Section";
            final loadedImages =
                imgGroup["loadedImages"] as List<pw.ImageProvider>? ?? [];
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(section, style: subHeadingStyle),
                pw.SizedBox(height: 8),
                ...loadedImages.map((img) {
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
  }

  // -----------------------------
  // ✅ Stage2 Content (Dynamic JSON -> Headings + Tables)
  // -----------------------------
  if (selectedStages.contains("stage2") && stage2Responses.isNotEmpty) {
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        header: (_) => buildHeader(),
        footer: (_) => footer,
        build: (context) {
          final widgets = <pw.Widget>[
            pw.Text("Stage 2 Responses", style: headingStyle),
            pw.SizedBox(height: 10),
          ];

          for (final response in stage2Responses) {
            final formJson = _safeDecode(response["formjson"]);
            widgets.add(pw.Text("Response ID: ${response['id'] ?? ''}",
                style: subHeadingStyle));
            widgets.add(pw.SizedBox(height: 6));

            widgets.addAll(buildNestedWidgets(formJson,
                sectionName: "inte",
                headingStyle: subHeadingStyle,
                subHeadingStyle: subHeadingStyle,
                bodyStyle: bodyStyle));

            widgets.add(pw.SizedBox(height: 20));
          }

          return widgets;
        },
      ),
    );
  }

  // -----------------------------
  // ✅ Stage3–Stage5 Placeholders
  // -----------------------------
  if (selectedStages.contains("stage3")) {
    pdf.addPage(
      pw.MultiPage(
        build: (context) => [
          pw.Text("Stage 3 content goes here", style: headingStyle),
        ],
      ),
    );
  }

  if (selectedStages.contains("stage4")) {
    pdf.addPage(
      pw.MultiPage(
        build: (context) => [
          pw.Text("Stage 4 content goes here", style: headingStyle),
        ],
      ),
    );
  }

  if (selectedStages.contains("stage5")) {
    pdf.addPage(
      pw.MultiPage(
        build: (context) => [
          pw.Text("Stage 5 content goes here", style: headingStyle),
        ],
      ),
    );
  }

  return await pdf.save();
}

// ✅ Store PDF in Supabase
Future<String?> storeFinalPdfDatabase(
    String projectId, List<String> selectedStages) async {
  try {
    // Fetch project row (Stage1)
    final res = await Supabase.instance.client
        .from('projects')
        .select()
        .eq('projectid', projectId)
        .limit(1);

    if (res.isEmpty) throw Exception("No project found for ID: $projectId");
    final rowData = res.first;

    final Map<String, dynamic> store = _safeDecode(rowData["store"]);
    final Map<String, dynamic> storeAnalysis =
        _safeDecode(rowData["store_analysis"]);

    // Fetch Stage2 responses
    List<Map<String, dynamic>> stage2Responses = [];
    if (selectedStages.contains("stage2")) {
      final resp = await Supabase.instance.client
          .from('recceresponses')
          .select()
          .eq('projectid', projectId)
          .eq('stageNo', 2);
      stage2Responses = List<Map<String, dynamic>>.from(resp);
    }

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

    // Auto-reduce quality/resolution until < 50MB
    final qualitySteps = [80, 60, 40];
    final resolutionSteps = [1024, 800, 600];
    Uint8List? finalPdfBytes;

    for (final resStep in resolutionSteps) {
      for (final quality in qualitySteps) {
        final pdfBytes = await generatePdfBytes(
          data["projectInfo"],
          data["contacts"],
          List<Map<String, dynamic>>.from(data["images"]),
          stage2Responses, // ✅ pass Stage2 responses
          selectedStages,
          quality: quality,
          maxWidth: resStep,
        );

        final pdfSizeMB = pdfBytes.lengthInBytes / (1024 * 1024);
        print(
            "📄 PDF Size (Q$quality, W$resStep): ${pdfSizeMB.toStringAsFixed(2)} MB");

        if (pdfSizeMB <= 50) {
          finalPdfBytes = pdfBytes;
          break;
        }
      }
      if (finalPdfBytes != null) break;
    }

    if (finalPdfBytes == null)
      throw Exception("Unable to reduce PDF under 50MB");

    // Upload
    final now = DateTime.now();
    final fileName =
        '${now.toIso8601String().replaceAll(':', '-').replaceAll('.', '-')}.pdf';
    const bucket = 'rece';
    final path = 'receReport/$fileName';

    await Supabase.instance.client.storage.from(bucket).uploadBinary(
          path,
          finalPdfBytes,
          fileOptions: const FileOptions(contentType: 'application/pdf'),
        );

    return Supabase.instance.client.storage.from(bucket).getPublicUrl(path);
  } catch (e) {
    print('PDF generation failed: $e');
    return 'Error: ${e.toString()}';
  }
}

// ✅ Safe JSON decode
Map<String, dynamic> _safeDecode(dynamic value) {
  if (value == null) return {};
  try {
    if (value is String && value.trim().isNotEmpty) {
      return jsonDecode(value);
    } else if (value is Map<String, dynamic>) {
      return value;
    }
  } catch (e) {
    print("JSON decode error: $e");
  }
  return {};
}
