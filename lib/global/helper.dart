import 'dart:io';
import 'dart:typed_data';

class Helper {
  // conver file to Uint8List
  static Future<Uint8List?> fileToUint8List(File file) async {
    final Uint8List uint8list = await file.readAsBytes();
    return uint8list;
  }
}
