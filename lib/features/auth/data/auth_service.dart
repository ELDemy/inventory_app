import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inventory_app/core/components/sign_out_alert_dialog.dart';
import 'package:inventory_app/di/injector.dart';

class AuthService {
  StreamSubscription<DocumentSnapshot>? _userDocSubscription;

  // Check if email exists in users collection
  Future<bool> checkUserInFirestore(String email) async {
    final DocumentSnapshot<Map<String, dynamic>> docSnapshot =
        await Injector.usersCollection.doc(email).get();

    return docSnapshot.exists;
  }

  // Setup real-time listener for user document
  void setupUserListener(String email, BuildContext context) {
    _userDocSubscription?.cancel();

    _userDocSubscription = Injector.usersCollection
        .doc(email)
        .snapshots()
        .listen((docSnapshot) async {
      print(
          "ELDemy:: User document has changed- docSnapshot.exists : ${docSnapshot.exists}");

      if (!docSnapshot.exists) {
        /// todo: user automatic logging out
        await signOut();
        if (context.mounted) {
          await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => const SignOutAlertDialog());
        }
      }
    });
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    _userDocSubscription?.cancel();
  }

  void dispose() {
    _userDocSubscription?.cancel();
  }
}
