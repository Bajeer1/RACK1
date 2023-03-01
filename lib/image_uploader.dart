import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class ImageUploader {
  final FirebaseStorage _storage =
      FirebaseStorage.instanceFor(bucket: 'wallpaper');

  Future<String?> uploadImage(File file, String filename) async {
    try {
      TaskSnapshot snapshot =
          await _storage.ref().child('images/$filename').putFile(file);

      final String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }
}
