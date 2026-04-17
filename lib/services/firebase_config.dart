import 'package:firebase_core/firebase_core.dart';

class FirebaseConfig {
  static Future<FirebaseApp> initializeFirebase() async {
    return await Firebase.initializeApp();
  }
}