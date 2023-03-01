import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class ImageUploader {
  late final String _fileName;
  late final File _file;

  Future<String?> uploadFile() async {
    final storageReference =
        FirebaseStorage.instance.ref().child("images/$_fileName");

    final uploadTask = storageReference.putFile(_file);

    try {
      await uploadTask;
      final downloadUrl = await storageReference.getDownloadURL();
      return downloadUrl;
    } catch (error) {
      print("Firebase Storage Error: $error");
      return null;
    }
  }

  void setFile(File file, String fileName) {
    _file = file;
    _fileName = fileName;
  }
}
