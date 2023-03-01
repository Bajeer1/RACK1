import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ImageUploader extends StatefulWidget {
  final Function(File file) onFileSelected;
  ImageUploader({required this.onFileSelected});

  @override
  _ImageUploaderState createState() => _ImageUploaderState();
}

class _ImageUploaderState extends State<ImageUploader> {
  late File _file;
  var _imageUrl;
  final picker = ImagePicker();
  late bool _isUploading;
  late bool _showImage;

  // Initialize _image to null
  late XFile? _image;

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = pickedFile;
        _showImage = true;
      } else {
        _showImage = false;
      }
    });

    widget.onFileSelected(File(_image!.path));
  }

  Future<String?> uploadImage(File file, String fileName) async {
    Reference storageRef =
        FirebaseStorage.instance.ref().child("images/$fileName");
    UploadTask uploadTask = storageRef.putFile(file);

    try {
      await uploadTask;
      String downloadUrl = await storageRef.getDownloadURL();
      return downloadUrl;
    } catch (error) {
      print("Firebase Storage Error: $error");
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    _isUploading = false;
    _showImage = false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _showImage
            ? Image.file(File(_image!.path))
            : ElevatedButton(
                onPressed: () => getImage(),
                child: Text('Select Image'),
              ),
        ElevatedButton(
          onPressed: () async {
            setState(() {
              _isUploading = true;
            });
            String fileName = basename(_file.path);
            String downloadUrl =
                await uploadImage(_file, fileName) ?? 'Error uploading image';
            setState(() {
              _isUploading = false;
              _imageUrl = downloadUrl;
            });
          },
          child: Text('Upload Image'),
        ),
        _isUploading ? CircularProgressIndicator() : Container(),
      ],
    );
  }
}
