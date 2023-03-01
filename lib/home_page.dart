import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'image_uploader.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ImagePicker _picker = ImagePicker();
  final ImageUploader _uploader = ImageUploader();
  File? _imageFile;
  bool _isUploading = false;

  Future<void> _pickImage() async {
    PickedFile? pickedFile =
        await _picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadImage() async {
    if (_imageFile != null) {
      setState(() {
        _isUploading = true;
      });
      String? downloadUrl = await _uploader.uploadImage(
          _imageFile!, _imageFile!.path.split('/').last);
      setState(() {
        _isUploading = false;
        _imageFile = null;
      });
      if (downloadUrl != null) {
        // Handle successful upload here
      } else {
        // Handle failed upload here
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Upload'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: _isUploading
              ? CircularProgressIndicator()
              : _imageFile == null
                  ? TextButton(
                      onPressed: _pickImage,
                      child: Text('Select Image'),
                    )
                  : Column(
                      children: [
                        Image.file(_imageFile!),
                        TextButton(
                          onPressed: _uploadImage,
                          child: Text('Upload Image'),
                        ),
                      ],
                    ),
        ),
      ),
    );
  }
}
