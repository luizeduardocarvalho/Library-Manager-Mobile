import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class BookImagePicker extends StatefulWidget {

  final Function(File pickedImage) onImagePick;

  BookImagePicker(this.onImagePick);

  @override
  _BookImagePickerState createState() => _BookImagePickerState();
}

class _BookImagePickerState extends State<BookImagePicker> {

  File _pickedImageFile;

  final picker = ImagePicker();

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(
      source: ImageSource.camera
    );

    setState(() {
      _pickedImageFile = File(pickedImage.path);
    });

    widget.onImagePick(_pickedImageFile);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            CircleAvatar(
              radius: 40.0,
              backgroundColor: Color(0xFFFFFFFF),
              backgroundImage: _pickedImageFile != null ? FileImage(_pickedImageFile) : null,
            ),
            FlatButton.icon(
              onPressed: _pickImage,
              icon: Icon(
                Icons.image,
                color: Colors.black,
              ),
              label: Text(
                'Add image',
                style: TextStyle(
                  color: Colors.black
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
