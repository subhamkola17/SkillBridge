import 'dart:io';
import 'dart:typed_data';

class PlatformFile {
  final File? file;
  final Uint8List? bytes;
  final String name;

  PlatformFile.file(this.file)
      : bytes = null,
        name = file!.path.split('/').last;

  PlatformFile.bytes(this.bytes, {required this.name});
}