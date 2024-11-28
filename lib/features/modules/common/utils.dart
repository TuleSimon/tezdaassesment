import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

void copyToClipboard(String text) {
  Clipboard.setData(ClipboardData(text: text));
}

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

Future<String> compressImage(String filePath) async {
  if (filePath.isEmpty) return "";
  final file = File(filePath);
  // Get the directory to save compressed images
  final dir =
      await getTemporaryDirectory(); // or use getApplicationDocumentsDirectory()
  final extension = filePath.split(".").lastOrNull;
  final targetPath =
      p.join(dir.path, '${DateTime.now().millisecondsSinceEpoch}.jpg');

  // Compress the image
  var result = await FlutterImageCompress.compressAndGetFile(
    file.absolute.path,
    targetPath,
    quality: 50, // Adjust quality
    format: CompressFormat.jpeg, // Choose format as needed
  );

  return result?.path ?? filePath;
}
