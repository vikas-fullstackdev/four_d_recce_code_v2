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
import 'package:supabase_flutter/supabase_flutter.dart';

/// 🔧 Convert String/List/null to List<String>
List<String> _normalizeToList(dynamic value) {
  if (value == null) return [];
  if (value is List) return value.whereType<String>().toList();
  if (value is String && value.trim().isNotEmpty) return [value];
  return [];
}

/// ✅ Safe JSON decode
Map<String, dynamic> _safeDecode(dynamic value) {
  if (value == null) return {};
  try {
    if (value is String && value.trim().isNotEmpty) {
      return jsonDecode(value) as Map<String, dynamic>;
    } else if (value is Map<String, dynamic>) {
      return value;
    }
  } catch (e) {
    print("JSON decode error: $e");
  }
  return {};
}

/// ✅ Download, resize, and compress image for PDF
Future<pw.ImageProvider?> tryLoadImage(
  String? url, {
  int maxWidth = 1024,
  int quality = 80,
}) async {
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

/// ✅ Build the PDF bytes (Option A layout)
Future<Uint8List> generatePdfBytes(
  Map<String, dynamic> projectInfo,
  Map<String, dynamic> contacts,
  List<dynamic> imagesList,
  Map<String, dynamic> recceResponses, {
  required int quality,
  required int maxWidth,
}) async {
  // Preload images (original + annotated)
  for (final imgGroup in imagesList) {
    final List<pw.ImageProvider> originals = [];
    final List<pw.ImageProvider> annotated = [];

    for (final url in (imgGroup["urls"] as List<String>)) {
      final imgProv =
          await tryLoadImage(url, quality: quality, maxWidth: maxWidth);
      if (imgProv != null) originals.add(imgProv);
    }

    for (final url in (imgGroup["annotatedUrls"] as List<String>)) {
      final imgProv =
          await tryLoadImage(url, quality: quality, maxWidth: maxWidth);
      if (imgProv != null) annotated.add(imgProv);
    }

    imgGroup["loadedOriginals"] = originals;
    imgGroup["loadedAnnotated"] = annotated;
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

  // ✅ Static Logo
  final staticLogoImage = await tryLoadImage(
    "https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/four-d-recce-ksbmae/assets/oh8m44tsfya2/New4Dlogo.png",
    quality: quality,
    maxWidth: maxWidth,
  );

  // ✅ Header with static logo
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

  // ✅ Footer
  final footer = pw.Container(
    alignment: pw.Alignment.centerRight,
    padding: const pw.EdgeInsets.all(8),
    child: pw.Text(
      'Generated on ${DateTime.now().toLocal()}',
      style: pw.TextStyle(fontSize: 10, color: PdfColors.grey700),
    ),
  );

  // ✅ Table helper
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

  // ✅ Page 1 - Project Info
  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4.landscape,
      header: (_) => buildHeader(),
      footer: (_) => footer,
      margin: const pw.EdgeInsets.all(20),
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
        }),
      ],
    ),
  );

  // ✅ Page 2 - Contacts
  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4.landscape,
      header: (_) => buildHeader(),
      footer: (_) => footer,
      margin: const pw.EdgeInsets.all(20),
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
      ],
    ),
  );

  // ✅ Pages 3+ - Original vs Annotated
  for (final imgGroup in imagesList) {
    final section = imgGroup["section"] as String? ?? "Image Section";
    final originals =
        imgGroup["loadedOriginals"] as List<pw.ImageProvider>? ?? [];
    final annotated =
        imgGroup["loadedAnnotated"] as List<pw.ImageProvider>? ?? [];

    final maxCount = originals.length > annotated.length
        ? originals.length
        : annotated.length;

    for (int i = 0; i < maxCount; i++) {
      final origImg = i < originals.length ? originals[i] : null;
      final annoImg = i < annotated.length ? annotated[i] : null;

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4.landscape,
          margin: const pw.EdgeInsets.all(20),
          build: (context) => pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(section, style: subHeadingStyle),
              pw.SizedBox(height: 10),
              pw.Expanded(
                child: pw.Row(
                  children: [
                    pw.Expanded(
                      child: pw.Column(
                        children: [
                          pw.Container(
                            height: 300,
                            alignment: pw.Alignment.center,
                            child: origImg != null
                                ? pw.Image(origImg, fit: pw.BoxFit.contain)
                                : pw.Text("No Original Image",
                                    style: bodyStyle),
                          ),
                          pw.SizedBox(height: 5),
                          pw.Text("Original", style: bodyStyle),
                        ],
                      ),
                    ),
                    pw.SizedBox(width: 12),
                    pw.Expanded(
                      child: pw.Column(
                        children: [
                          pw.Container(
                            height: 300,
                            alignment: pw.Alignment.center,
                            child: annoImg != null
                                ? pw.Image(annoImg, fit: pw.BoxFit.contain)
                                : pw.Text("No Annotated Image",
                                    style: bodyStyle),
                          ),
                          pw.SizedBox(height: 5),
                          pw.Text("Annotated", style: bodyStyle),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  // ✅ Recce Responses
  if (recceResponses.isNotEmpty) {
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4.landscape,
        header: (_) => buildHeader(),
        footer: (_) => footer,
        margin: const pw.EdgeInsets.all(20),
        build: (context) {
          final widgets = <pw.Widget>[];
          widgets.add(pw.Text("Recce Responses", style: headingStyle));
          widgets.add(pw.SizedBox(height: 10));

          recceResponses.forEach((mainKey, mainVal) {
            widgets.add(pw.Text(mainKey, style: subHeadingStyle));
            widgets.add(pw.SizedBox(height: 6));

            if (mainVal is Map<String, dynamic>) {
              mainVal.forEach((subKey, subVal) {
                widgets.add(pw.Text("• $subKey", style: bodyStyle));

                if (subVal is Map<String, dynamic>) {
                  final rows = subVal.entries
                      .where((e) =>
                          e.value != null &&
                          e.value.toString().trim().isNotEmpty)
                      .map((e) => pw.TableRow(
                            children: [
                              pw.Padding(
                                padding: const pw.EdgeInsets.all(6),
                                child: pw.Text(e.key, style: bodyStyle),
                              ),
                              pw.Padding(
                                padding: const pw.EdgeInsets.all(6),
                                child: pw.Text(e.value.toString(),
                                    style: bodyStyle),
                              ),
                            ],
                          ))
                      .toList();

                  if (rows.isNotEmpty) {
                    widgets.add(
                      pw.Table(
                        border: pw.TableBorder.all(color: PdfColors.grey),
                        columnWidths: {
                          0: const pw.FlexColumnWidth(4),
                          1: const pw.FlexColumnWidth(6),
                        },
                        children: rows,
                      ),
                    );
                  }
                }
                widgets.add(pw.SizedBox(height: 12));
              });
            }
            widgets.add(pw.SizedBox(height: 20));
          });

          return widgets;
        },
      ),
    );
  }

  return await pdf.save();
}

/// ✅ Fetch row, build data, generate PDF, upload to Supabase Storage
Future<String?> storePdfDatabase(String projectId) async {
  try {
    // Require an authenticated user for storage uploads.
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) {
      print('PDF generation failed: unauthenticated user. Sign in required.');
      return 'Error: Unauthenticated. Please sign in before generating/downloading the PDF.';
    }

    final res = await Supabase.instance.client
        .from('projects')
        .select()
        .eq('projectid', projectId)
        .limit(1);

    if (res == null || res.isEmpty) throw Exception("No project found");

    final rowData = res.first;
    final Map<String, dynamic> store = _safeDecode(rowData["store"]);
    final Map<String, dynamic> storeAnalysis =
        _safeDecode(rowData["store_analysis"]);
    final Map<String, dynamic> annotated =
        _safeDecode(rowData["annotated_images"]);

    final recceRes = await Supabase.instance.client
        .from('recceresponses')
        .select()
        .eq('projectid', projectId)
        // DB column is "stageno" (lowercase) — use exact column name
        .eq('stageno', 2)
        .limit(1);

    final Map<String, dynamic> recceResponses =
        recceRes.isNotEmpty ? _safeDecode(recceRes.first["formjson"]) : {};

    List<Map<String, dynamic>> imagesList = [];

    void addImageGroup(
        String section, List<String> originalUrls, List<String> annotatedUrls) {
      imagesList.add({
        "section": section,
        "urls": _normalizeToList(originalUrls),
        "annotatedUrls": _normalizeToList(annotatedUrls),
      });
    }

    // Flatten images
    addImageGroup(
      "Location Plan",
      _normalizeToList(store["lcationPlan"]?["lcationPlan"]),
      _normalizeToList(annotated["store"]?["lcationPlan"]),
    );

    addImageGroup(
      "Proposed Location",
      _normalizeToList(store["proposedLocation"]?["proposedLocation"]),
      _normalizeToList(annotated["store"]?["proposedLocation"]),
    );

    addImageGroup(
      "Store Analysis - Corner Shop",
      _normalizeToList(storeAnalysis["store_analysis_details"]
          ?["Is_it_a_corner_shop"]?["if_yes_then_image"]),
      _normalizeToList(annotated["store_analysis_details"]
          ?["Is_it_a_corner_shop"]?["if_yes_then_image"]),
    );

    final accessKeys = ["easy_acces", "moderate_access", "difficult_access"];
    for (final key in accessKeys) {
      addImageGroup(
        "Store Analysis - Access to Store → ${key.replaceAll('_', ' ').capitalize()}",
        _normalizeToList(storeAnalysis["store_analysis_details"]
            ?["access_to_the_store_from_the_front"]?[key]),
        _normalizeToList(annotated["store_analysis_details"]
            ?["access_to_the_store_from_the_front"]?[key]),
      );
    }

    final visibilityKeys = [
      "façade_is_visible_40_percentage",
      "façade_is_visible_between_40_60_percentage",
      "façade_is_visible_more_than_60_percentage"
    ];
    for (final key in visibilityKeys) {
      addImageGroup(
        "Store Analysis - Visibility → ${key.replaceAll('_', ' ').capitalize()}",
        _normalizeToList(storeAnalysis["store_analysis_details"]
            ?["visibility_of_the_showroom_from_the_entrance"]?[key]),
        _normalizeToList(annotated["store_analysis_details"]
            ?["visibility_of_the_showroom_from_the_entrance"]?[key]),
      );
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
      "images": imagesList
    };

    // Auto-reduce quality/resolution until < 50MB
    final qualitySteps = [80, 60, 40];
    final resolutionSteps = [1024, 800, 600];
    Uint8List? finalPdfBytes;

    for (final resStep in resolutionSteps) {
      for (final quality in qualitySteps) {
        final pdfBytes = await generatePdfBytes(
          data["projectInfo"] as Map<String, dynamic>,
          data["contacts"] as Map<String, dynamic>,
          List<Map<String, dynamic>>.from(data["images"] as List),
          recceResponses,
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

    final now = DateTime.now();
    final fileName =
        '${now.toIso8601String().replaceAll(':', '-').replaceAll('.', '-')}.pdf';
    // Use your actual Supabase storage bucket name
    const bucket = 'project_uploads';
    final path = 'pdf/$fileName';
    try {
      await Supabase.instance.client.storage.from(bucket).uploadBinary(
            path,
            finalPdfBytes,
            fileOptions: const FileOptions(contentType: 'application/pdf'),
          );
    } on StorageException catch (se) {
      print('Storage upload failed: ${se.message} (status: ${se.statusCode})');
      return 'Error: Storage upload failed: ${se.message}';
    } catch (se) {
      print('Storage upload unknown error: $se');
      return 'Error: Storage upload failed: ${se.toString()}';
    }

    // Try to return a public URL. If the bucket is private this URL may not be accessible;
    // for private buckets create a signed URL instead.
    final publicUrl =
        Supabase.instance.client.storage.from(bucket).getPublicUrl(path);
    // If bucket is private, create a signed URL (valid for 1 hour) and return it.
    // createSignedUrl may throw if not allowed; handle safely.
    if (publicUrl == null ||
        publicUrl.isEmpty ||
        !publicUrl.contains('/')) {
      try {
        final signed = await Supabase.instance.client.storage
            .from(bucket)
            .createSignedUrl(path, 60 * 60); // expires in 1 hour
        return signed;
      } catch (e) {
        print('Failed to create signed URL: $e');
        return 'Error: Uploaded but failed to generate URL: ${e.toString()}';
      }
    }
    return publicUrl;
  } catch (e) {
    print('PDF generation failed: $e');
    return 'Error: ${e.toString()}';
  }
}

/// Helper extension to capitalize words
extension StringCasingExtension on String {
  String capitalize() {
    return this
        .split(' ')
        .map((str) =>
            str.isNotEmpty ? '${str[0].toUpperCase()}${str.substring(1)}' : '')
        .join(' ');
  }
}
