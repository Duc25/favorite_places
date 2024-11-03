import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key, required this.onChoseImage});
  final void Function(File imagePicked) onChoseImage;
  @override
  State<StatefulWidget> createState() {
    return _ImageInputState();
  }
}

class _ImageInputState extends State<ImageInput> {
  File? _selectedImage;
  void _takePhoto() async {
    Navigator.of(context).pop();
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
      widget.onChoseImage(File(pickedImage.path));
    }
  }

  void _selectPhoto() async {
    Navigator.of(context).pop();
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 600,
    );
    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
      widget.onChoseImage(File(pickedImage.path));
    }
  }

  void _choseImageOption() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(8),
        ),
      ),
      constraints: const BoxConstraints(minWidth: double.infinity),
      backgroundColor: Theme.of(context).colorScheme.surface,
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton.icon(
              onPressed: _takePhoto,
              label: const Text('Take Picture'),
              icon: const Icon(Icons.camera),
            ),
            const SizedBox(
              height: 12,
            ),
            TextButton.icon(
              onPressed: _selectPhoto,
              label: const Text('Select Image in Library'),
              icon: const Icon(Icons.photo_library),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
      onPressed: _choseImageOption,
      icon: const Icon(Icons.camera),
      label: const Text('Take Photo'),
    );
    if (_selectedImage != null) {
      content = GestureDetector(
        onTap: _choseImageOption,
        child: Image.file(
          _selectedImage!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      );
    }
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.white,
          width: 1,
        ),
      ),
      width: double.infinity,
      height: 250,
      child: content,
    );
  }
}
