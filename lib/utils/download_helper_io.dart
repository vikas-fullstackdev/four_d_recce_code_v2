import 'dart:typed_data';

/// Non-web placeholder. webDownload should only be called when kIsWeb is true.
Future<void> webDownload(Uint8List bytes, String filename) async {
  throw UnsupportedError('webDownload is only available on web. Use native downloadFile helper on mobile.');
}