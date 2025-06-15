<<<<<<< HEAD
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_profile.dart';

class AuthService {
  // Singleton pattern
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _usersCollection = FirebaseFirestore.instance
      .collection('users');

  // Validate user credentials
  Future<bool> validateUser(String email, String password) async {
    try {
      final QuerySnapshot result =
          await _usersCollection
              .where('email', isEqualTo: email)
              .where('password', isEqualTo: password)
              .limit(1)
              .get();

      if (result.docs.isNotEmpty) {
        // Update UserProfile with the found user's data
        final userData = result.docs.first.data() as Map<String, dynamic>;
        UserProfile.name = userData['name'] ?? '';
        UserProfile.email = userData['email'] ?? '';
        UserProfile.password = userData['password'] ?? '';
        UserProfile.phone = userData['phone'] ?? '';
        UserProfile.address = userData['address'] ?? '';
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('Error validating user: $e');
      return false;
    }
  }

  // Register new user
  Future<bool> registerUser({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String address,
  }) async {
    try {
      // Check if email already exists
      final QuerySnapshot result =
          await _usersCollection
              .where('email', isEqualTo: email)
              .limit(1)
              .get();

      if (result.docs.isNotEmpty) {
        throw Exception('Email already exists');
      }

      // Validate email format
      if (!isValidEmail(email)) {
        throw Exception('Invalid email format');
      }

      // Validate password strength
      if (!isStrongPassword(password)) {
        throw Exception('Password is not strong enough');
      }

      // Create new user document
      await _usersCollection.add({
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
        'address': address,
        'createdAt': FieldValue.serverTimestamp(),
      });

      return true;
    } catch (e) {
      debugPrint('Error registering user: $e');
      rethrow;
    }
  }

  // Validate email format
  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
    return emailRegex.hasMatch(email);
  }

  // Validate password strength
  bool isStrongPassword(String password) {
    // Password should be at least 8 characters long
    if (password.length < 8) return false;

    // Password should contain at least one uppercase letter
    if (!password.contains(RegExp(r'[A-Z]'))) return false;

    // Password should contain at least one lowercase letter
    if (!password.contains(RegExp(r'[a-z]'))) return false;

    // Password should contain at least one number
    if (!password.contains(RegExp(r'[0-9]'))) return false;

    return true;
  }

  // Get password requirements message
  String getPasswordRequirementsMessage() {
    return 'Password must be at least 8 characters long and contain:\n'
        '• At least one uppercase letter\n'
        '• At least one lowercase letter\n'
        '• At least one number';
  }
=======
import 'package:firebase_auth/firebase_auth.dart' as fb;

import '../models/user.dart';
import 'user_service.dart';

class AuthService {
  final fb.FirebaseAuth _auth = fb.FirebaseAuth.instance;
  final UserService _userService = UserService();

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final uid = credential.user?.uid;
      if (uid != null) {
        final user = User(
          id: uid,
          name: name,
          email: email,
          password: password,
          phone: '',
          address: '',
        );
        await _userService.createUser(user);
      }
    } catch (e) {
      rethrow;
    }
  }
>>>>>>> b2e54a01041a7778b2270b24967b6589f023a913
}
