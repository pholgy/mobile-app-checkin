import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  final CollectionReference users = FirebaseService.firestore.collection('users');

  // Create a new user
  Future<void> createUser(String userId, Map<String, dynamic> userData) async {
    await users.doc(userId).set(userData);
  }

  // Get a user by ID
  Future<DocumentSnapshot> getUser(String userId) async {
    return await users.doc(userId).get();
  }

  // Update user data
  Future<void> updateUser(String userId, Map<String, dynamic> updatedData) async {
    await users.doc(userId).update(updatedData);
  }

  // Delete a user
  Future<void> deleteUser(String userId) async {
    await users.doc(userId).delete();
  }
}
