import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inventory_app/core/components/sign_out_alert_dialog.dart';
import 'package:inventory_app/di/injector.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  StreamSubscription<DocumentSnapshot>? _userDocSubscription;

  // Check if email exists in users collection
  Future<bool> checkUserInFirestore(String email) async {
    final DocumentSnapshot<Map<String, dynamic>> docSnapshot =
        await Injector.usersCollection.doc(email).get();

    if (docSnapshot.exists) {
      Injector.userDoc = Injector.usersCollection.doc(email);
      Injector.userData = docSnapshot.data();
    }
    return docSnapshot.exists;
  }

  // Setup real-time listener for user document
  void setupUserListener(String email, BuildContext context) {
    _userDocSubscription?.cancel();

    _userDocSubscription = Injector.usersCollection
        .doc(email)
        .snapshots()
        .listen((docSnapshot) async {
      print("ELDemt:: Document changed : ${docSnapshot.exists}");
      Injector.userData = docSnapshot.data();
      if (!docSnapshot.exists) {
        await logout();
        if (context.mounted) {
          await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => const SignOutAlertDialog());
        }
      }
    });
  }

  Future<void> logout() async {
    await _auth.signOut();
    _userDocSubscription?.cancel();
  }

  void dispose() {
    _userDocSubscription?.cancel();
  }
}
