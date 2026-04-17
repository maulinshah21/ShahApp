import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Function to add a travel idea
  Future<void> addTravelIdea(String title, String description, String userId) async {
    await _firestore.collection('travel_ideas').add({
      'title': title,
      'description': description,
      'userId': userId,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  // Function to get all travel ideas
  Stream<List<Map<String, dynamic>>> getTravelIdeas() {
    return _firestore.collection('travel_ideas').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return {
          'id': doc.id,
          ...doc.data() as Map<String, dynamic>,
        };
      }).toList();
    });
  }

  // Function to add a rental
  Future<void> addRental(String title, String location, String userId) async {
    await _firestore.collection('rentals').add({
      'title': title,
      'location': location,
      'userId': userId,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  // Function to get all rentals
  Stream<List<Map<String, dynamic>>> getRentals() {
    return _firestore.collection('rentals').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return {
          'id': doc.id,
          ...doc.data() as Map<String, dynamic>,
        };
      }).toList();
    });
  }

  // Function to add a story
  Future<void> addStory(String title, String content, String userId) async {
    await _firestore.collection('stories').add({
      'title': title,
      'content': content,
      'userId': userId,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  // Function to get all stories
  Stream<List<Map<String, dynamic>>> getStories() {
    return _firestore.collection('stories').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return {
          'id': doc.id,
          ...doc.data() as Map<String, dynamic>,
        };
      }).toList();
    });
  }

  // Function to add a photo
  Future<void> addPhoto(String url, String description, String userId) async {
    await _firestore.collection('photos').add({
      'url': url,
      'description': description,
      'userId': userId,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  // Function to get all photos
  Stream<List<Map<String, dynamic>>> getPhotos() {
    return _firestore.collection('photos').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return {
          'id': doc.id,
          ...doc.data() as Map<String, dynamic>,
        };
      }).toList();
    });
  }
}