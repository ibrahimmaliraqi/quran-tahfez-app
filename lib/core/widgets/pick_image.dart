import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PickImage extends StatefulWidget {
  final ValueChanged<File?> onFileChanged;

  const PickImage({
    super.key,
    required this.onFileChanged,
  });

  @override
  State<PickImage> createState() => _PickImageState();
}

class _PickImageState extends State<PickImage> {
  File? image;

  Future<void> _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImage == null || !mounted) return;

    final file = File(pickedImage.path);

    setState(() => image = file);
    widget.onFileChanged(file);
  }

  void _deleteImage() {
    setState(() => image = null);
    widget.onFileChanged(null);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _pickImage,
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: const Color(0xFFDDF0E9),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: image == null
                ? const Icon(
                    Icons.add_a_photo_outlined,
                    size: 32,
                    color: Color(0xFF1E6553),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(
                      image!,
                      fit: BoxFit.cover,
                    ),
                  ),
          ),
          if (image != null)
            Positioned(
              top: 0,
              right: 0,
              child: GestureDetector(
                onTap: _deleteImage,
                child: const CircleAvatar(
                  radius: 12,
                  backgroundColor: Colors.red,
                  child: Icon(
                    Icons.close,
                    size: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
