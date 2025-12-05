import 'dart:html' as html;
import 'dart:typed_data';

/// Web-only: trigger browser download for bytes
Future<void> webDownload(Uint8List bytes, String filename) async {
  final blob = html.Blob([bytes], 'application/pdf');
  final objectUrl = html.Url.createObjectUrlFromBlob(blob);
  final anchor = html.document.createElement('a') as html.AnchorElement
    ..href = objectUrl
    ..download = filename;
  html.document.body!.append(anchor);
  anchor.click();
  anchor.remove();
  html.Url.revokeObjectUrl(objectUrl);
}