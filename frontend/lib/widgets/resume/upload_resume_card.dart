import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class UploadResumeCard extends StatelessWidget {
  final PlatformFile? selectedFile;
  final ValueChanged<PlatformFile> onFileSelected;

  const UploadResumeCard({
    super.key,
    required this.selectedFile,
    required this.onFileSelected,
  });

  Future<void> _pickFile(BuildContext context) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
        withData: true,
      );

      if (result != null) {
        onFileSelected(result.files.first);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to pick file: $e"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF1F2937),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.blueAccent.withOpacity(.4),
          width: 1.2,
        ),
      ),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 34,
            backgroundColor: Color(0xFF2563EB),
            child: Icon(
              Icons.picture_as_pdf_rounded,
              color: Colors.white,
              size: 34,
            ),
          ),

          const SizedBox(height: 18),

          Text(
            "Upload Resume",
            style: theme.textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            "Upload your resume in PDF format\n(Max 5 MB)",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey.shade400,
              height: 1.4,
            ),
          ),

          const SizedBox(height: 24),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => _pickFile(context),
              icon: const Icon(Icons.upload_file_rounded),
              label: const Text("Choose PDF"),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2563EB),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: selectedFile == null
                ? Text(
              "No file selected",
              key: const ValueKey("empty"),
              style: TextStyle(
                color: Colors.grey.shade500,
              ),
            )
                : Container(
              key: const ValueKey("selected"),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(.12),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      selectedFile!.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}