// Conditional export: uses web implementation when dart:html is available, otherwise an IO stub.
export 'download_helper_io.dart' if (dart.library.html) 'download_helper_web.dart';