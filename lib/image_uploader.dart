import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageUploader extends StatefulWidget {
  final Function(File) onImageSelected;

  const ImageUploader({required this.onImageSelected});

  @override
  _ImageUploaderState createState() => _ImageUploaderState();
}

class _ImageUploaderState extends State<ImageUploader> {
  final ImagePicker _picker = ImagePicker();
  late File _image;

  Future<void> _getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      widget.onImageSelected(_image);
    }
  }

  Future<void> _uploadImage() async {
    if (_image != null) {
      // implement your image upload logic here
      print('Uploading image...');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.photo_camera),
          onPressed: _getImage,
        ),
        ElevatedButton(
          child: Text('Upload Image'),
          onPressed: _uploadImage,
        ),
      ],
    );
  }
}
