import 'package:firebase_auth/firebase_auth.dart';

class AdminService {
  final List<String> _adminUids = [];  // List to store admin UIDs
  final int _maxAdmins = 6;  // Maximum number of admins
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Method to add an admin
  void addAdmin(String uid) {
    if (_adminUids.length >= _maxAdmins) {
      throw Exception("Cannot add more than $_maxAdmins admins.");
    }
    if (!_adminUids.contains(uid)) {
      _adminUids.add(uid);
      _logAction("Admin added: $uid");
    } else {
      throw Exception("User is already an admin.");
    }
  }

  // Method to remove an admin
  void removeAdmin(String uid) {
    if (_adminUids.contains(uid)) {
      _adminUids.remove(uid);
      _logAction("Admin removed: $uid");
    } else {
      throw Exception("User is not an admin.");
    }
  }

  // Method to check if a user is an admin
  bool isAdmin(String uid) {
    return _adminUids.contains(uid);
  }

  // Method to log admin actions
  void _logAction(String action) {
    // Here you could add code to log actions to a file, a database, etc.
    print("Admin Action Log: $action");
  }
}