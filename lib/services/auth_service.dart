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
}
