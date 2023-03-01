import 'dart:convert';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late File _image;
  late String _uploadedFileURL;

  Future chooseFile() async {
    await ImagePicker().getImage(source: ImageSource.gallery).then((image) {
      setState(() {
        _image = File(image!.path);
      });
    });
  }

  Future uploadFile() async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference storageReference =
        FirebaseStorage.instance.ref().child('images/$fileName');
    UploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.whenComplete(() async {
      try {
        String downloadUrl = await storageReference.getDownloadURL();
        setState(() {
          _uploadedFileURL = downloadUrl;
        });
      } catch (error) {
        print("Firebase Storage Error: $error");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RACK1'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _image == null
                ? Text('No image selected.')
                : Image.file(
                    _image,
                    height: 300,
                  ),
            SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              child: Text('Select Image'),
              onPressed: chooseFile,
            ),
            SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              child: Text('Upload Image'),
              onPressed: uploadFile,
            ),
            SizedBox(
              height: 20.0,
            ),
            _uploadedFileURL != null
                ? Image.network(
                    _uploadedFileURL,
                    height: 300,
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
