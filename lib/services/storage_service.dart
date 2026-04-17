import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Upload a file to Firebase Storage
  Future<String> uploadFile(String path, File file) async {
    try {
      await _storage.ref(path).putFile(file);
      return await _storage.ref(path).getDownloadURL();
    } catch (e) {
      print('Error uploading file: $e');
      throw e;
    }
  }

  // Download a file from Firebase Storage
  Future<File> downloadFile(String url, String localPath) async {
    try {
      File file = File(localPath);
      // Assuming the file already exists at localPath, you can download like this:
      await _storage.refFromURL(url).writeToFile(file);
      return file;
    } catch (e) {
      print('Error downloading file: $e');
      throw e;
    }
  }
}