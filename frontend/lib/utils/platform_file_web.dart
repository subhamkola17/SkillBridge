import 'dart:typed_data';

class PlatformFile {
  final dynamic file;
  final Uint8List? bytes;
  final String name;

  PlatformFile.file(this.file)
      : bytes = null,
        name = "";

  PlatformFile.bytes(
      this.bytes, {
        required this.name,
      }) : file = null;
}