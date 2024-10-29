import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/core/errors/firebase_errors.dart';
import 'package:inventory_app/features/auth/data/auth_service.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final AuthService _authService = AuthService();

  AuthCubit() : super(AuthInitial());

  // Check initial auth state
  Future<bool> checkInitialAuthState(BuildContext context) async {
    try {
      final User? currentUser = _auth.currentUser;

      if (currentUser?.email != null) {
        final bool userExists =
            await _authService.checkUserInFirestore(currentUser!.email!);

        if (userExists) {
          _authService.setupUserListener(currentUser.email!, context);
          return true;
        } else {
          await _authService.logout();
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      emit(AuthLoading());

      final UserCredential userCredential = await _auth
          .signInWithEmailAndPassword(email: email, password: password);

      final bool userExists = await _authService.checkUserInFirestore(email);

      if (!userExists) {
        emit(AuthError('هذا المستخدم غير مسجل في النظام'));
        return;
      } else {
        _authService.setupUserListener(userCredential.user!.email!, context);

        emit(AuthSuccess());
      }
    } on FirebaseAuthException catch (e) {
      log("FirebaseAuthException $signIn");
      FirebaseFailure.fromFirebaseAuthException(e);
      emit(AuthError(FirebaseFailure.fromFirebaseAuthException(e).errMsg));
    } on FirebaseException catch (e) {
      log('Error fetching documents: ${e.message}');
      return emit(AuthError(FirebaseFailure.fromFirebaseException(e).errMsg));
    } catch (e) {
      log("Error at Home Cubit: ${e}");
      return emit(AuthError("حدث خطأ!!"));
    }
  }

  @override
  Future<void> close() {
    _authService.dispose();
    return super.close();
  }
}
