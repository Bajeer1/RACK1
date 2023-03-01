import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class ImageUploader {
  final FirebaseStorage _storage =
      FirebaseStorage.instanceFor(bucket: 'wallpaper');

  Future<String?> uploadImage(File file, String fileName) async {
    Reference storageRef =
        FirebaseStorage.instance.ref().child("wallpaper/$fileName");
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
}
