// ignore_for_file: unused_field

import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _usersCollection = FirebaseFirestore.instance.collection('users');

  Future<void> createUser(User user) async {
    try {
      await _usersCollection.doc(user.id).set(user.toMap());
    } catch (e) {
      print('Error creating user: $e');
      rethrow;
    }
  }

  Future<User?> getUserByEmail(String email) async {
    try {
      QuerySnapshot snapshot = await _usersCollection.where('email', isEqualTo: email).limit(1).get();
      if (snapshot.docs.isNotEmpty) {
        final doc = snapshot.docs.first;
        return User.fromMap(doc.id, doc.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      print('Error getting user by email: $e');
      rethrow;
    }
  }

  Future<User?> getUserById(String id) async {
    try {
      DocumentSnapshot doc = await _usersCollection.doc(id).get();
      if (doc.exists) {
        return User.fromMap(doc.id, doc.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      print('Error getting user by id: $e');
      rethrow;
    }
  }

  Future<List<User>> getUsers() async {
    try {
      QuerySnapshot snapshot = await _usersCollection.get();
      return snapshot.docs
          .map((doc) => User.fromMap(doc.id, doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error getting users: $e');
      rethrow;
    }
  }

  Future<void> updateUser(String id, User user) async {
    try {
      await _usersCollection.doc(id).update(user.toMap());
    } catch (e) {
      print('Error updating user: $e');
      rethrow;
    }
  }

  Future<void> deleteUser(String id) async {
    try {
      await _usersCollection.doc(id).delete();
    } catch (e) {
      print('Error deleting user: $e');
      rethrow;
    }
  }
}
