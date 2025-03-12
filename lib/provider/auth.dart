import 'dart:async';
import 'dart:convert';

import 'package:e_shop_app/models/http_exception.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;
  Timer? _authTimer; // Make the timer nullable

  bool get isAuth {
    return token != null;
  }

  String? get token {
    if (_expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  String? get userId {
    return _userId;
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get user => _auth.currentUser;

  String getErrorMessage(String errorCode) {
    switch (errorCode) {
      case "ERROR_EMAIL_ALREADY_IN_USE":
      case "account-exists-with-different-credential":
      case "email-already-in-use":
        return "Email already used. Go to login page.";
      case "ERROR_WRONG_PASSWORD":
      case "wrong-password":
      case "invalid-password":
      case "invalid-password-hash":
        return "Wrong email/password combination.";
      case "ERROR_USER_NOT_FOUND":
      case "user-not-found":
        return "No user found with this email.";
      case "ERROR_USER_DISABLED":
      case "user-disabled":
        return "User disabled.";
      case "ERROR_TOO_MANY_REQUESTS":
      case "too-many-requests":
        return "Too many requests to log into this account.";
      case "ERROR_OPERATION_NOT_ALLOWED":
      case "operation-not-allowed":
        return "Server error, please try again later.";
      case "ERROR_INVALID_EMAIL":
      case "invalid-email":
        return "Email address is invalid.";
      default:
        return "Authentication failed. Please try again.";
    }
  }

  Future<void> createUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      _token = await userCredential.user!.getIdToken();
      _userId = userCredential.user!.uid;
      _expiryDate = DateTime.now().add(
        Duration(seconds: 3600),
      ); // Firebase tokens expire in 1 hour
      autoLogout(); // Set up the auto logout timer
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': _token,
        'userId': _userId,
        'expiryDate': _expiryDate?.toIso8601String(),
      });
      prefs.setString('userData', userData);
    } on FirebaseAuthException catch (error) {
      throw HttpException(getErrorMessage(error.code));
    } catch (error) {
      throw HttpException('An unexpected error occurred');
    }
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _token = await userCredential.user!.getIdToken();
      _userId = userCredential.user!.uid;
      _expiryDate = DateTime.now().add(
        Duration(seconds: 3600),
      ); // Firebase tokens expire in 1 hour
      autoLogout(); // Set up the auto logout timer
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': _token,
        'userId': _userId,
        'expiryDate': _expiryDate?.toIso8601String(),
      });
      prefs.setString('userData', userData);
    } on FirebaseAuthException catch (error) {
      throw HttpException(getErrorMessage(error.code));
    } catch (error) {
      throw HttpException('An unexpected error occurred');
    }
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString('userData') ?? '') as Map<String, dynamic>;
    final expiryDate = DateTime.parse(
      extractedUserData['expiryDate'] as String,
    );
    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    _token = extractedUserData['token'] as String?;
    _userId = extractedUserData['userId'] as String?;
    _expiryDate = expiryDate;
    notifyListeners();
    autoLogout();
    return true;
  }

  Future<void> logout() async {
    _token = null;
    _userId = null;
    _expiryDate = null;
    if (_authTimer != null) {
      _authTimer!.cancel();
      _authTimer = null;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  void autoLogout() {
    if (_authTimer != null) {
      _authTimer!.cancel();
    }
    final timeToExpiry = _expiryDate?.difference(DateTime.now()).inSeconds ?? 0;
    if (timeToExpiry > 0) {
      _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
    } else {
      logout();
    }
  }
}
