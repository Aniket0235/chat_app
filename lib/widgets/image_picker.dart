import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UImagePicker extends StatefulWidget {
  UImagePicker(this.imageD);
  final void Function(File pickedImage) imageD;

  @override
  _UImagePickerState createState() => _UImagePickerState();
}

class _UImagePickerState extends State<UImagePicker> {
  File? _pickedImage;
  Future<File?> picker() async {
    final XFile? image = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 50);
    final File? pickedfile = File(image!.path);
    setState(() {
      _pickedImage = pickedfile;
    });
    widget.imageD(pickedfile!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 46,
          backgroundColor: Colors.grey[400],
          backgroundImage:
              _pickedImage != null ? FileImage(_pickedImage!) : null,
        ),
        const SizedBox(
          height: 10,
        ),
        TextButton.icon(
            onPressed: picker,
            icon: const Icon(Icons.image),
            label: const Text("Add image")),
      ],
    );
  }
}
