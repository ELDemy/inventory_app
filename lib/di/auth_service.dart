import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inventory_app/di/injector.dart';
import 'package:inventory_app/features/auth/presentation/sign_out_alert_dialog.dart';
import 'package:inventory_app/features/user_management/data/user_model.dart';

class AuthService {
  StreamSubscription<DocumentSnapshot>? _userDocSubscription;

  // Check if email exists in users collection
  Future<bool> checkUserInFirestore(String email) async {
    final DocumentSnapshot<Map<String, dynamic>> docSnapshot =
        await Injector.usersCollection.doc(email).get();

    Injector.userModel = UserModel.fromFirestore(docSnapshot.data());

    return docSnapshot.exists;
  }

  // Setup real-time listener for user document
  void setupUserListener(BuildContext context, String email) {
    _userDocSubscription?.cancel();

    _userDocSubscription =
        Injector.usersCollection.doc(email).snapshots().handleError((error) {
      print("Error in User Document Listener: $error");
      // If we get a permission error, it likely means the user document is gone
      if (error.toString().toLowerCase().contains('permission-denied')) {
        handleUserDeletion(context);
      }
    }).listen(
      (docSnapshot) {
        if (!docSnapshot.exists) {
          print("Document No longer exists");
          handleUserDeletion(context);
        }
      },
      onError: (error) {
        print("Error in user document listener: $error");
        if (error.toString().toLowerCase().contains('permission-denied')) {
          handleUserDeletion(context);
        }
      },
    );
  }

  void handleUserDeletion(BuildContext context) {
    FirebaseAnalytics.instance.logEvent(
      name: "handleUserDeletion",
      parameters: {
        "user_name": Injector.userModel?.name ?? "null",
        "user_email": Injector.userModel?.email ?? "null",
        "user_role": Injector.userModel?.role ?? "null",
      },
    );

    // Cancel subscription first
    _userDocSubscription?.cancel();
    _userDocSubscription = null;

    signOut();
    if (context.mounted) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const SignOutAlertDialog(),
      );
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    _userDocSubscription?.cancel();
  }

  void dispose() {
    _userDocSubscription?.cancel();
    _userDocSubscription = null;
  }
}
